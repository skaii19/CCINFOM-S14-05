from db import get_cursor, get_connection

class PlayerModel:

    # Load all players with their current team
    def load_players(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT p.player_id, p.player_ign, p.player_name,
                            CASE
                                WHEN p.active_status = 'Y' THEN 'Yes'
                                ELSE 'No'
                                END AS active_status, p.team_id, t.team_name AS current_team FROM player p
                        LEFT JOIN team t ON p.team_id = t.team_id
                        ORDER BY p.player_id
                        """)
            return cur.fetchall()   # return list of player rows
        except Exception as e:
            print("Error loading players:", e)
            return []

    # Insert a new player and return the generated ID
    def add_player(self, player_ign, player_name, team_id, status):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO player (player_ign, player_name, team_id, active_status)
                        VALUES (%s, %s, %s, %s)
                        """, (player_ign, player_name, team_id, status))
            get_connection().commit()      # save changes
            print("Player added successfully!")
            return cur.lastrowid           # return new player_id
        except Exception as e:
            print("Error adding player:", e)
            return None

    # Update an existing player
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

    # Retrieve all teams for dropdown lists
    def get_teams(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT team_id, team_name FROM team
                        ORDER BY team_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading teams:", e)
            return []

    # Get one player's full record
    def get_player(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT * FROM player
                        WHERE player_id = %s
                        """, (player_id,))
            return cur.fetchone()   # return single row
        except Exception as e:
            print("Error fetching player:", e)
            return None

    # Legacy method (no longer used with lastrowid)
    def get_last_insert_id(self):
        try:
            cur = get_cursor()
            cur.execute("SELECT LAST_INSERT_ID()")
            return cur.fetchone()[0]
        except Exception as e:
            print("Error getting last inserted ID:", e)
            return None

    # Get all active players
    def get_active_players(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT p.player_id, p.player_ign, p.player_name, 'Yes' AS active_status, p.team_id, t.team_name AS current_team FROM player p
                        LEFT JOIN team t ON p.team_id = t.team_id
                        WHERE p.active_status = '1'
                        ORDER BY p.player_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading active players:", e)
            return []

    # Get all inactive players
    def get_inactive_players(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT p.player_id, p.player_ign, p.player_name, 'No' AS active_status, p.team_id, t.team_name AS current_team FROM player p
                        LEFT JOIN team t ON p.team_id = t.team_id
                        WHERE p.active_status = '0'
                        ORDER BY p.player_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading inactive players:", e)
            return []

    # Count how many stat records a player has
    def count_stats(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("SELECT COUNT(*) FROM player_stats WHERE player_id=%s", (player_id,))
            return cur.fetchone()[0]
        except Exception as e:
            print("Error counting stats:", e)
            return 0

    # Count how many agent picks a player has
    def count_agent_picks(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("SELECT COUNT(*) FROM agent_pick WHERE player_id=%s", (player_id,))
            return cur.fetchone()[0]
        except Exception as e:
            print("Error counting agent picks:", e)
            return 0

    # Count how many matches reference this player as MVP
    def count_mvp_refs(self, player_id):
        try:
            cur = get_cursor()
            cur.execute("SELECT COUNT(*) FROM matches WHERE mvp_player_id=%s", (player_id,))
            return cur.fetchone()[0]
        except Exception as e:
            print("Error counting MVP references:", e)
            return 0
