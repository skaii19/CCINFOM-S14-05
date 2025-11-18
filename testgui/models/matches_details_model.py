from db import get_cursor

class MatchesDetailsModel:

    # Load basic match info (tournament, matchup, MVP)
    def get_basic_info(self, match_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT t.tournament_name, CONCAT(t1.team_name, ' vs ', t2.team_name) AS match_up,
                            p.player_ign AS mvp FROM matches m
                        JOIN tournament t ON m.tournament_id = t.tournament_id
                        JOIN team t1 ON m.team1_id = t1.team_id
                        JOIN team t2 ON m.team2_id = t2.team_id
                        LEFT JOIN player p ON m.mvp_player_id = p.player_id
                        WHERE m.match_id = %s
                        """, (match_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching basic match info:", e)
            return None

    # Load team 1 player data (IGN, agent, match stats)
    def get_team1_details(self, match_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT t.team_name, p.player_ign AS ign, a.agent_name AS agent, ps.kd_ratio AS kd,
                            ps.headshot_pct AS hs, ps.avg_combat_score AS acs FROM matches m
                        JOIN team t ON m.team1_id = t.team_id
                        JOIN player_stats ps ON ps.match_id = m.match_id
                        JOIN player p ON ps.player_id = p.player_id
                        JOIN agent_pick ap ON ap.match_id = m.match_id AND ap.player_id = p.player_id
                        JOIN agents a ON a.agent_id = ap.agent_id
                        WHERE m.match_id = %s
                        ORDER BY p.player_ign
                        """, (match_id,))

            rows = cur.fetchall()

            if not rows:
                return {"team_name": None, "players": []}

            team_name = rows[0]["team_name"]
            players = [
                {
                    "ign": r["ign"],
                    "agent": r["agent"],
                    "kd": r["kd"],
                    "hs": r["hs"],
                    "acs": r["acs"]
                }
                for r in rows
            ]

            return {"team_name": team_name, "players": players}

        except Exception as e:
            print("Error fetching team 1 details:", e)
            return {"team_name": None, "players": []}

    # Load team 2 player data (IGN, agent, match stats)
    def get_team2_details(self, match_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT t.team_name, p.player_ign AS ign, a.agent_name AS agent, ps.kd_ratio AS kd,
                            ps.headshot_pct AS hs, ps.avg_combat_score AS acs FROM matches m
                        JOIN team t ON m.team2_id = t.team_id
                        JOIN player_stats ps ON ps.match_id = m.match_id
                        JOIN player p ON ps.player_id = p.player_id
                        JOIN agent_pick ap ON ap.match_id = m.match_id AND ap.player_id = p.player_id
                        JOIN agents a ON a.agent_id = ap.agent_id
                        WHERE m.match_id = %s
                        ORDER BY p.player_ign
                        """, (match_id,))

            rows = cur.fetchall()

            if not rows:
                return {"team_name": None, "players": []}

            team_name = rows[0]["team_name"]
            players = [
                {
                    "ign": r["ign"],
                    "agent": r["agent"],
                    "kd": r["kd"],
                    "hs": r["hs"],
                    "acs": r["acs"]
                }
                for r in rows
            ]

            return {"team_name": team_name, "players": players}

        except Exception as e:
            print("Error fetching team 2 details:", e)
            return {"team_name": None, "players": []}