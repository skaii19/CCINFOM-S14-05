from db import get_cursor, get_connection

class PlayerModel:

    # Load all players with their current team
    def load_players(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            p.player_id,
                            p.player_ign,
                            p.player_name,
                            CASE 
                                WHEN t.active_status = 'Y' THEN 'Yes' 
                                ELSE 'No'
                            END AS active_status
                            p.team_id,
                            t.team_name AS current_team
                        FROM player p
                        LEFT JOIN team t ON p.team_id = t.team_id
                        ORDER BY p.player_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading players:", e)
            return []

    # Add a new player
    def add_player(self, player_ign, player_name, team_id, status):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO player (player_ign, player_name, team_id, active_status)
                        VALUES (%s, %s, %s, %s)
                        """, (player_ign, player_name, team_id, status))
            get_connection().commit()
            print("Player added successfully!")
        except Exception as e:
            print("Error adding player:", e)

    # Update existing player
    def update_player(self, player_id, player_ign, player_name, team_id, status):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE player
                        SET player_ign=%s, player_name=%s, team_id=%s, active_status=%s
                        WHERE player_id=%s
                        """, (player_ign, player_name, team_id, status, player_id))
            get_connection().commit()
            print("Player updated successfully!")
        except Exception as e:
            print("Error updating player:", e)

    # Delete a player
    def delete_player(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("DELETE FROM player WHERE player_id=%s", (player_id,))
            get_connection().commit()
            print("Player deleted successfully!")
        except Exception as e:
            print("Error deleting player:", e)

    # Get all teams for dropdown
    def get_teams(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT team_id, team_name
                        FROM team
                        ORDER BY team_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading teams:", e)
            return []

    # OPTIONAL: get one player (can be deleted)
    def get_player(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT *
                        FROM player
                        WHERE player_id = %s
                        """, (player_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching player:", e)
            return None
        
        # Get active players
    def get_active_players(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            p.player_id,
                            p.player_ign,
                            p.player_name,
                            'Yes' AS active_status,
                            p.team_id,
                            t.team_name AS current_team
                        FROM player p
                        LEFT JOIN team t ON p.team_id = t.team_id
                        WHERE p.active_status = '1'
                        ORDER BY p.player_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading active players:", e)
            return []

    # Get inactive players
    def get_inactive_players(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            p.player_id,
                            p.player_ign,
                            p.player_name,
                            'No' AS active_status,
                            p.team_id,
                            t.team_name AS current_team
                        FROM player p
                        LEFT JOIN team t ON p.team_id = t.team_id
                        WHERE p.active_status = '0'
                        ORDER BY p.player_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading inactive players:", e)
            return []
