from db import get_cursor, get_connection

class ReportsModel:

    def revenue_tournament_day(self, tournament_id, date_of_ticket):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT
                    t.tournament_id,
                    t.tournament_name,
                    t.tournament_type,
                    c.date_of_ticket,
                    SUM(c.ticket_price) AS total_ticket_sales
                FROM customer c
                JOIN tournament t ON c.tournament_id = t.tournament_id
                WHERE t.tournament_id = %s AND c.date_of_ticket = %s
                GROUP BY t.tournament_id, t.tournament_name, t.tournament_type, c.date_of_ticket
                ORDER BY c.date_of_ticket
            """, (tournament_id, date_of_ticket))
            return cur.fetchall()
        except Exception as e:
            print("Error loading revenue for tournament day:", e)
            return []

    def revenue_tournament(self, tournament_id):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT
                    t.tournament_id,
                    t.tournament_name,
                    t.tournament_type,
                    SUM(c.ticket_price) AS total_ticket_sales
                FROM customer c
                JOIN tournament t ON c.tournament_id = t.tournament_id
                WHERE t.tournament_id = %s
                GROUP BY t.tournament_id, t.tournament_name, t.tournament_type
                ORDER BY t.tournament_id
            """, (tournament_id,))
            return cur.fetchall()
        except Exception as e:
            print("Error loading revenue for tournament:", e)
            return []

    def revenue_year(self, year):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT
                    YEAR(date_of_ticket) AS tourn_year,
                    SUM(ticket_price) AS total_ticket_sales
                FROM customer
                WHERE YEAR(date_of_ticket) = %s
                GROUP BY YEAR(date_of_ticket)
            """, (year,))
            return cur.fetchall()
        except Exception as e:
            print("Error loading revenue for year:", e)
            return []


    def average_per_tournament(self):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT
                    t.tournament_id,
                    t.tournament_name,
                    t.tournament_type,
                    AVG(c.ticket_price) AS average_ticket_sales
                FROM customer c
                JOIN tournament t ON c.tournament_id = t.tournament_id
                GROUP BY t.tournament_id, t.tournament_name, t.tournament_type
                ORDER BY t.tournament_id
            """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading average per tournament:", e)
            return []


    def team_performance_year(self, year):
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
            """, (int(year),))  # Ensure int and tuple
            return cur.fetchall()
        except Exception as e:
            print("Error loading team performance (year):", e)
            return []

    def agent_picks(self, tournament_id, match_date=None):
        try:
            cur = get_cursor()
            sql = """
                SELECT 
                    a.agent_id,
                    a.agent_name,
                    COUNT(ap.agent_id) AS total_picks,
                    COUNT(ap.agent_id) / (SELECT COUNT(*) FROM agent_pick) * 100 AS average_pick_rate_pct
                FROM 
                    agent_pick ap
                    JOIN agents a ON ap.agent_id = a.agent_id
                    JOIN matches m ON ap.match_id = m.match_id
                WHERE 
                    m.tournament_id = %s
            """
            params = [tournament_id]

            if match_date:
                sql += " AND m.match_date = %s"
                params.append(match_date)

            sql += " GROUP BY a.agent_id, a.agent_name ORDER BY total_picks DESC"
            cur.execute(sql, tuple(params))
            return cur.fetchall()
        except Exception as e:
            print("Error loading agent picks:", e)
            return []
        
    def agent_picks_year(self, year):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT 
                    a.agent_id,
                    a.agent_name,
                    COUNT(ap.agent_id) AS total_picks,
                    COUNT(ap.agent_id) / (SELECT COUNT(*) FROM agent_pick ap2
                                           JOIN matches m2 ON ap2.match_id = m2.match_id
                                           WHERE YEAR(m2.match_date) = %s) * 100 AS average_pick_rate_pct
                FROM 
                    agent_pick ap
                    JOIN agents a ON ap.agent_id = a.agent_id
                    JOIN matches m ON ap.match_id = m.match_id
                WHERE YEAR(m.match_date) = %s
                GROUP BY a.agent_id, a.agent_name
                ORDER BY total_picks DESC
            """, (year, year))
            return cur.fetchall()
        except Exception as e:
            print("Error loading agent picks per year:", e)
            return []

    def team_winrate_year(self, year):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT 
                    t.team_id,
                    t.team_name,
                    COUNT(m.map_winner_team_id) AS total_wins,
                    COUNT(m.map_winner_team_id) / (
                        SELECT COUNT(*) FROM matches 
                        WHERE (team1_id = t.team_id OR team2_id = t.team_id)
                          AND YEAR(match_date) = %s
                    ) * 100 AS win_rate_pct
                FROM 
                    team t
                    LEFT JOIN matches m 
                        ON m.map_winner_team_id = t.team_id
                        AND YEAR(m.match_date) = %s
                GROUP BY t.team_id, t.team_name
                ORDER BY win_rate_pct DESC
            """, (year, year))
            return cur.fetchall()
        except Exception as e:
            print("Error loading team winrate per year:", e)
            return []


    def map_picks(self, tournament_id, match_date=None):
        try:
            cur = get_cursor()
            sql = """
                SELECT 
                    mp.map_id,
                    mp.map_name,
                    COUNT(m.map_played) AS total_picked,
                    COUNT(m.map_played) / (SELECT COUNT(*) FROM matches WHERE tournament_id = %s) * 100 AS avg_pick_rate_pct
                FROM 
                    matches m
                    JOIN maps mp ON m.map_played = mp.map_id
                WHERE 
                    m.tournament_id = %s
            """
            params = [tournament_id, tournament_id]

            if match_date:
                sql += " AND m.match_date = %s"
                params.append(match_date)

            sql += " GROUP BY mp.map_id, mp.map_name ORDER BY total_picked DESC"
            cur.execute(sql, tuple(params))
            return cur.fetchall()
        except Exception as e:
            print("Error loading map picks:", e)
            return []

    def team_winrate(self, tournament_id, match_date=None):
        try:
            cur = get_cursor()
            sql = """
                SELECT 
                    t.team_id,
                    t.team_name,
                    COUNT(m.map_winner_team_id) AS total_wins,
                    COUNT(m.map_winner_team_id) / (
                        SELECT COUNT(*) FROM matches 
                        WHERE tournament_id = %s AND (team1_id = t.team_id OR team2_id = t.team_id)
                    ) * 100 AS win_rate_pct
                FROM 
                    team t
                    LEFT JOIN matches m 
                        ON m.map_winner_team_id = t.team_id
                WHERE 
                    m.tournament_id = %s
            """
            params = [tournament_id, tournament_id]

            if match_date:
                sql += " AND m.match_date = %s"
                params.append(match_date)

            sql += " GROUP BY t.team_id, t.team_name ORDER BY win_rate_pct DESC"
            cur.execute(sql, tuple(params))
            return cur.fetchall()
        except Exception as e:
            print("Error loading team win rate:", e)
            return []

