from db import get_cursor

class PlayerDetailsModel:

    # Load basic player info (IGN + real name)
    def get_basic_info(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT player_ign, player_name
                        FROM player
                        WHERE player_id = %s
                       """, (player_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching basic player info:", e)
            return None

    # Load aggregated stats
    def get_aggregated_stats(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            AVG(headshot_pct) AS headshot_pct,
                            AVG(kd_ratio) AS kd_ratio,
                            AVG(avg_combat_score) AS avg_combat_score
                        FROM player_stats
                        WHERE player_id = %s
                        """, (player_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching aggregated stats:", e)
            return None

    # Load full team history
    def get_team_history(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            th.team_id,
                            t.team_name,
                            th.start_date,
                            th.end_date
                        FROM team_history th
                        JOIN team t ON th.team_id = t.team_id
                        WHERE th.player_id = %s
                        ORDER BY th.start_date
                        """, (player_id,))
            return cur.fetchall()
        except Exception as e:
            print("Error fetching team history:", e)
            return []

    # Load all distinct agents used
    def get_agent_picks(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT DISTINCT agent_name
                        FROM agent_pick
                        WHERE player_id = %s
                        ORDER BY agent_name
                        """, (player_id,))
            return cur.fetchall()
        except Exception as e:
            print("Error fetching agent picks:", e)
            return []

    # Load MVP count
    def get_mvp_count(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT COUNT(*) AS mvp_count
                        FROM matches
                        WHERE mvp_player_id = %s
                        """, (player_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching MVP count:", e)
            return None
