from db import get_cursor, get_connection

class TeamHistoryModel:

    # Load all history for a player
    def load_history(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            th.player_id,
                            th.team_id,
                            t.team_name,
                            th.start_date,
                            th.end_date
                        FROM team_history th
                        LEFT JOIN team t ON th.team_id = t.team_id
                        WHERE th.player_id = %s
                        ORDER BY th.start_date
                        """, (player_id,))
            return cur.fetchall()
        except Exception as e:
            print("Error loading team history:", e)
            return []

    # Add a history record
    def add_history(self, player_id, team_id, start_date, end_date=None):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO team_history (player_id, team_id, start_date, end_date)
                        VALUES (%s, %s, %s, %s)
                        """, (player_id, team_id, start_date, end_date))
            get_connection().commit()
        except Exception as e:
            print("Error inserting team history:", e)

    # Close current active team entry
    def close_current_history(self, player_id, end_date):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE team_history
                        SET end_date=%s
                        WHERE player_id=%s AND end_date IS NULL
                        """, (end_date, player_id))
            get_connection().commit()
        except Exception as e:
            print("Error closing current team history:", e)

    # Get the most recent team entry
    def get_latest_history(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            player_id,
                            team_id,
                            start_date,
                            end_date
                        FROM team_history
                        WHERE player_id=%s
                        ORDER BY start_date DESC
                        LIMIT 1
                        """, (player_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching latest team history:", e)
            return None
