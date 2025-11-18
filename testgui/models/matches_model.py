from db import get_cursor, get_connection

class MatchesModel:

    # Load all matches
    def load_matches(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT m.match_id, m.tournament_id, t.tournament_name, m.match_date, m.match_time, m.bracket,
                            CONCAT(m.team1_id, ' vs ', m.team2_id) AS match_up, m.team1_id, m.team2_id, wt.team_id AS winning_team,
                            m.map_played, mp.map_name, m.score, m.mvp_player_id, p.player_ign AS mvp FROM matches m
                        JOIN tournament t ON m.tournament_id = t.tournament_id
                        JOIN team t1 ON m.team1_id = t1.team_id
                        JOIN team t2 ON m.team2_id = t2.team_id
                        LEFT JOIN team wt ON m.map_winner_team_id = wt.team_id
                        LEFT JOIN maps mp ON m.map_played = mp.map_id
                        LEFT JOIN player p ON m.mvp_player_id = p.player_id
                        ORDER BY m.match_date, m.match_time
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading matches:", e)
            return []

    # Insert a new match
    def add_match(self, match_id, tournament_id, match_date, match_time,
                  bracket, team1_id, team2_id, winner_team_id,
                  map_played_id, score, mvp_player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO matches (
                            match_id, tournament_id, match_date, match_time, bracket,
                            team1_id, team2_id, map_winner_team_id, map_played,
                            score, mvp_player_id
                        )
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                        """, (
                            match_id, tournament_id, match_date, match_time, bracket,
                            team1_id, team2_id, winner_team_id, map_played_id,
                            score, mvp_player_id
                        ))

            get_connection().commit()
        except Exception as e:
            print("Error adding match:", e)

    # Update an existing match
    def update_match(self, match_id, tournament_id, match_date, match_time,
                     bracket, team1_id, team2_id, winner_team_id,
                     map_played_id, score, mvp_player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE matches
                        SET tournament_id=%s, match_date=%s, match_time=%s, bracket=%s,
                            team1_id=%s, team2_id=%s, map_winner_team_id=%s,
                            map_played=%s, score=%s, mvp_player_id=%s
                        WHERE match_id=%s
                        """, (
                            tournament_id, match_date, match_time, bracket,
                            team1_id, team2_id, winner_team_id, map_played_id,
                            score, mvp_player_id, match_id
                        ))

            get_connection().commit()
        except Exception as e:
            print("Error updating match:", e)

    # Get distinct years for filter
    def get_years(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT DISTINCT YEAR(match_date) AS year FROM matches
                        ORDER BY year
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error fetching years:", e)
            return []

    # Get tournaments for dropdowns
    def get_tournaments(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT tournament_id, tournament_name FROM tournament
                        ORDER BY tournament_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error fetching tournaments:", e)
            return []

    # Get teams for dropdowns
    def get_teams(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT team_id, team_name FROM team
                        ORDER BY team_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error fetching teams:", e)
            return []

    # Get maps for dropdowns
    def get_maps(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT map_id, map_name FROM maps
                        ORDER BY map_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error fetching maps:", e)
            return []

    # Get a dictionary of players per team
    def get_players_grouped_by_team(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT player_id, player_ign, team_id FROM player
                        """)
            rows = cur.fetchall()

            grouped = {}
            for r in rows:
                tid = r["team_id"]
                if tid not in grouped:
                    grouped[tid] = []
                grouped[tid].append(r)

            return grouped
        except Exception as e:
            print("Error fetching players by team:", e)
            return {}

    # Get players from both teams in a match
    def get_players_from_two_teams(self, team1_id, team2_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT player_id, player_ign, team_id FROM player
                        WHERE team_id IN (%s, %s)
                        ORDER BY team_id, player_ign
                        """, (team1_id, team2_id))
            return cur.fetchall()
        except Exception as e:
            print("Error fetching players from two teams:", e)
            return []

    # Get list of agents
    def get_agents(self):
        try:
            cur = get_cursor()
            cur.execute("SELECT agent_id, agent_name FROM agents ORDER BY agent_name")
            return cur.fetchall()
        except Exception as e:
            print("Error fetching agents:", e)
            return []

    # Insert stats per player for a match
    def add_player_stats(self, match_id, player_id, kd, hs, acs):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO player_stats (
                            match_id, player_id, kd_ratio, headshot_pct, avg_combat_score
                        )
                        VALUES (%s, %s, %s, %s, %s)
                        """, (match_id, player_id, kd, hs, acs))
            get_connection().commit()
        except Exception as e:
            print("Error adding player stats:", e)

    # Insert agent pick per player for a match
    def add_agent_pick(self, match_id, player_id, agent_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO agent_pick (match_id, player_id, agent_id)
                        VALUES (%s, %s, %s)
                        """, (match_id, player_id, agent_id))
            get_connection().commit()
        except Exception as e:
            print("Error adding agent pick:", e)

    # Get match data for editing
    def get_match(self, match_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT m.match_id, m.tournament_id, m.match_date, m.match_time, m.bracket, m.team1_id, m.team2_id,
                               m.map_winner_team_id AS winning_team, m.map_played, m.score, m.mvp_player_id FROM matches m
                        WHERE m.match_id = %s
                        """, (match_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching match:", e)
            return None