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

    # Add a new team history record
    def add_history(self, player_id, team_id, start_date, end_date=None):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO team_history (player_id, team_id, start_date, end_date)
                        VALUES (%s, %s, %s, %s)
                        """, (player_id, team_id, start_date, end_date))
            get_connection().commit()
            print("Team history added successfully!")
        except Exception as e:
            print("Error adding team history:", e)

    # Update an existing history record
    def update_history(self, player_id, start_date, team_id, end_date=None):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE team_history
                        SET team_id=%s, end_date=%s
                        WHERE player_id=%s AND start_date=%s
                        """, (team_id, end_date, player_id, start_date))
            get_connection().commit()
            print("Team history updated successfully!")
        except Exception as e:
            print("Error updating team history:", e)

    # Delete a history record
    def delete_history(self, player_id, start_date):
        try:
            cur = get_cursor()
            cur.execute("""
                        DELETE FROM team_history
                        WHERE player_id=%s AND start_date=%s
                        """, (player_id, start_date))
            get_connection().commit()
            print("Team history deleted successfully!")
        except Exception as e:
            print("Error deleting team history:", e)

    # Get the current team for a player (where end_date is NULL or in the future)
    def get_current_team(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            th.team_id,
                            t.team_name,
                            th.start_date,
                            th.end_date
                        FROM team_history th
                        LEFT JOIN team t ON th.team_id = t.team_id
                        WHERE th.player_id = %s
                        AND (th.end_date IS NULL OR th.end_date >= CURDATE())
                        ORDER BY th.start_date DESC
                        LIMIT 1
                        """, (player_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching current team:", e)
            return None

    # Get all players who were in a specific team
    def get_players_by_team(self, team_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            th.player_id,
                            p.player_name,
                            th.start_date,
                            th.end_date
                        FROM team_history th
                        LEFT JOIN player p ON th.player_id = p.player_id
                        WHERE th.team_id = %s
                        ORDER BY th.start_date
                        """, (team_id,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error fetching players for team {team_id}:", e)
            return []

    # Get all players who were in a specific team during a date range
    def get_players_by_team_and_date(self, team_id, start_date, end_date):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            th.player_id,
                            p.player_name,
                            th.start_date,
                            th.end_date
                        FROM team_history th
                        LEFT JOIN player p ON th.player_id = p.player_id
                        WHERE th.team_id = %s
                        AND th.start_date <= %s AND (th.end_date IS NULL OR th.end_date >= %s)
                        ORDER BY th.start_date
                        """, (team_id, end_date, start_date))
            return cur.fetchall()
        except Exception as e:
            print(f"Error fetching players for team {team_id} in date range:", e)
            return []

    # Get full history for all players in a team
    def get_full_history_for_team(self, team_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            th.player_id,
                            p.player_name,
                            th.start_date,
                            th.end_date
                        FROM team_history th
                        LEFT JOIN player p ON th.player_id = p.player_id
                        WHERE th.team_id = %s
                        ORDER BY th.start_date
                        """, (team_id,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error fetching full history for team {team_id}:", e)
            return []
    
    # Get active players in a team
    def get_current_players_in_team(self, team_id):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT
                    th.player_id,
                    p.player_name,
                    th.start_date,
                    th.end_date
                FROM team_history th
                LEFT JOIN player p ON th.player_id = p.player_id
                WHERE th.team_id = %s
                AND (th.end_date IS NULL OR th.end_date >= CURDATE())
                ORDER BY th.start_date
            """, (team_id,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error fetching current players for team {team_id}:", e)
            return []