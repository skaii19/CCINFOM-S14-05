from db import get_cursor, get_connection

class ReportsModel:

    # tournament revenue
    def revenue_tournament_day (self, tournament_id, date_of_ticket) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT t.tournament_id, SUM(c.ticket_price) AS total_ticket_sales, c.date_of_ticket FROM customer c
                        JOIN tournament t ON c.tournament_id = t.tournament_id
                        WHERE t.tournament_id = %s AND c.date_of_ticket = %s
                        GROUP BY t.tournament_id, c.date_of_ticket
                        ORDER BY c.date_of_ticket
                        """, (tournament_id, date_of_ticket))
            return cur.fetchall()
        except Exception as e:
            print("Error loading revenue for tournament day:", e)
            return []
        
    def revenue_tournament (self, tournament_id) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT t.tournament_id, SUM(c.ticket_price) AS total_ticket_sales FROM customer c
                        JOIN tournament t ON c.tournament_id = t.tournament_id
                        WHERE t.tournament_id = %s
                        GROUP BY t.tournament_id
                        ORDER BY t.tournament_id
                        """, (tournament_id))
            return cur.fetchall()
        except Exception as e:
            print("Error loading revenue for tournament:", e)
            return []
        
    def revenue_year (self, year) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            YEAR(date_of_ticket) AS tourn_year,
                            SUM(ticket_price) AS total_ticket_sales
                        FROM customer
                        WHERE YEAR(date_of_ticket) = %s
                        GROUP BY 
                            YEAR(date_of_ticket)
                        ORDER BY tourn_year
                        """, (year))
            return cur.fetchall()
        except Exception as e:
            print("Error loading revenue for year:", e)
            return []
    
    # merchandise revenue
    def revenue_product(self, product_id) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            p.product_id,
                            p.product_name,
                            SUM(st.quantity_sold) AS total_units_sold,
                            p.product_price,
                            SUM(st.quantity_sold * p.product_price) AS total_revenue
                        FROM 
                            sales_transaction st
                        JOIN 
                            product p ON st.product_id = p.product_id
                        WHERE 
                            p.product_id = %s
                        GROUP BY 
                            p.product_id, p.product_name, YEAR(st.transaction_date), p.product_price
                        """, (product_id))
            return cur.fetchall()
        except Exception as e:
            print("Error loading product revenue:", e)
            return []
        
    def revenue_merchandise_year(self) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            YEAR(st.transaction_date) AS sales_year,
                            SUM(st.quantity_sold * p.product_price) AS total_revenue
                        FROM 
                            sales_transaction st
                        JOIN 
                            product p ON st.product_id = p.product_id
                        GROUP BY 
                            YEAR(st.transaction_date)
                        ORDER BY 
                            YEAR(st.transaction_date)
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading year merchandise revenue:", e)
            return []
        
    def revenue_merchandise_month(self) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            YEAR(st.transaction_date) AS sales_year,
                            MONTH(st.transaction_date) AS sales_month,
                            SUM(st.quantity_sold * p.product_price) AS total_revenue
                        FROM 
                            sales_transaction st
                        JOIN 
                            product p ON st.product_id = p.product_id
                        GROUP BY 
                            YEAR(st.transaction_date),
                            MONTH(st.transaction_date)
                        ORDER BY 
                            sales_year, 
                            sales_month
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading month merchandise revenue:", e)
            return []
    
    # tournament stats
    def agent_picks(self, tournament_id) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            a.agent_id,
                            a. agent_name,
                            COUNT(ap.agent_id) AS total_picks,
                            COUNT(ap.agent_id) / (SELECT COUNT(*) FROM agent_pick) * 100 AS average_pick_rate_pct
                        FROM 
                            agent_pick ap
                            JOIN agents a ON ap.agent_id = a.agent_id
                            JOIN matches m ON ap.match_id = m.match_id
                        WHERE 
                            m.tournament_id = %s
                        GROUP BY 
                            a.agent_id
                        ORDER BY 
                            total_picks DESC
                        """, (tournament_id))
            return cur.fetchall()
        except Exception as e:
            print("Error loading agent picks:", e)
            return []
        
    def map_picks(self, tournament_id) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            mp.map_id,
                            mp.map_name,
                            COUNT(m.map_played) AS total_picked,
                            COUNT(m.map_played) / (SELECT COUNT(*) FROM matches) * 100 AS avg_pick_rate_pct
                        FROM 
                            matches m
                            JOIN maps mp ON m.map_played = mp.map_id
                        WHERE 
                            m.tournament_id = %s
                        GROUP BY 
                            mp.map_id, mp.map_name
                        ORDER BY 
                            total_picked DESC
                        """, (tournament_id))
            return cur.fetchall()
        except Exception as e:
            print("Error loading map picks:", e)
            return []
        
    def team_winrate(self, tournament_id) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            t.team_id,
                            t.team_name,
                            COUNT(m.map_winner_team_id) AS total_wins,
                            COUNT(m.map_winner_team_id) / (
                                SELECT COUNT(*) FROM matches 
                                WHERE team1_id = t.team_id OR team2_id = t.team_id
                            ) * 100 AS win_rate_pct
                        FROM 
                            team t
                            LEFT JOIN matches m 
                                ON m.map_winner_team_id = t.team_id
                        WHERE 
                            m.tournament_id = %s
                        GROUP BY 
                            t.team_id, t.team_name
                        ORDER BY 
                            win_rate_pct DESC
                        """, (tournament_id))
            return cur.fetchall()
        except Exception as e:
            print("Error loading team win rate:", e)
            return []
        
    def team_performance_tournament(self, tournament_id) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            t.team_id,
                            t.team_name,
                            AVG(ps.headshot_pct) AS avg_headshot_pct,
                            AVG(ps.kd_ratio) AS avg_kd_ratio,
                            AVG(ps.avg_combat_score) AS avg_combat_score
                        FROM 
                            player_stats ps
                        JOIN player p 
                            ON ps.player_id = p.player_id
                        JOIN team t
                            ON p.team_id = t.team_id
                        JOIN matches m
                            ON ps.match_id = m.match_id
                        WHERE 
                            m.tournament_id = %s
                        GROUP BY 
                            t.team_id, t.team_name
                        ORDER BY 
                            t.team_id
                        """, (tournament_id))
            return cur.fetchall()
        except Exception as e:
            print("Error loading team performance (tournament):", e)
            return []
        
    def team_performance_year(self, year) :
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            t.team_id,
                            t.team_name,
                            AVG(ps.headshot_pct) AS avg_headshot_pct,
                            AVG(ps.kd_ratio) AS avg_kd_ratio,
                            AVG(ps.avg_combat_score) AS avg_combat_score
                        FROM 
                            player_stats ps
                        JOIN player p 
                            ON ps.player_id = p.player_id
                        JOIN team t
                            ON p.team_id = t.team_id
                        JOIN matches m
                            ON ps.match_id = m.match_id
                        WHERE 
                            YEAR(m.match_date) = %s
                        GROUP BY 
                            t.team_id, t.team_name
                        ORDER BY 
                            avg_combat_score
                        """, (year))
            return cur.fetchall()
        except Exception as e:
            print("Error loading team performance (year):", e)
            return []