from db import get_cursor, get_connection

class TeamModel:

    # Load all teams
    def load_teams(self):
        try:
            cur = get_cursor() 
            cur.execute("""
                        SELECT 
                            t.region,
                            t.team_id,
                            t.team_name,
                            t.total_winnings,
                            CASE 
                                WHEN t.active_status = '1' THEN 'Yes' 
                                ELSE 'No'
                            END AS active_status
                        FROM 
                            team t 
                        ORDER BY 
                            t.team_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading teams:", e)
            return []
        
    # Add a new team
    def add_team(self, team_id, team_name, region, total_winnings, active_status):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO team (team_id, team_name, region, total_winnings, active_status)
                        VALUES (%s, %s, %s, %s, %s)
                        """, (team_id, team_name, region, total_winnings, active_status))
            get_connection().commit()
            print("Team added successfully!")
        except Exception as e:
            print("Error adding team:", e)

    # Update an existing team
    def update_team(self, team_id, team_name, region, total_winnings, active_status):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE team
                        SET team_name=%s, region=%s, total_winnings=%s, active_status=%s
                        WHERE team_id=%s
                        """, (team_name, region, total_winnings, active_status, team_id))
            get_connection().commit()
            print("Team updated successfully!")
        except Exception as e:
            print("Error updating team:", e)

    # Delete a team
    def delete_team(self, team_id):
        try:
            cur = get_cursor()
            cur.execute("DELETE FROM team WHERE team_id=%s", (team_id,))
            get_connection().commit()
            print("Team deleted successfully!")
        except Exception as e:
            print("Error deleting team:", e)

    # Get a single team by ID
    def get_team(self, team_id):
        try:
            cur = get_cursor()
            cur.execute("""
                SELECT
                    t.region,
                    t.team_id,
                    t.team_name,
                    t.total_winnings,
                    CASE
                        WHEN t.active_status = '1' THEN 'Yes'
                        ELSE 'No'
                    END AS active_status
                FROM team t
                WHERE t.team_id = %s
            """, (team_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching team:", e)
            return None
        
    # Get all teams in a specific region
    def get_teams_by_region(self, region):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            t.region,
                            t.team_id,
                            t.team_name,
                            t.total_winnings,
                            CASE
                                WHEN t.active_status = '1' THEN 'Yes'
                                ELSE 'No'
                            END AS active_status
                        FROM team t
                        WHERE t.region = %s
                        ORDER BY t.team_name
                        """, (region,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading teams in region {region}:", e)
            return []
    
    # Get only active teams
    def get_active_teams(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            t.region,
                            t.team_id,
                            t.team_name,
                            t.total_winnings,
                            'Yes' AS active_status
                        FROM team t
                        WHERE t.active_status = '1'
                        ORDER BY t.team_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading active teams:", e)
            return []
        
    # Get only inactive teams
    def get_inactive_teams(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            t.region,
                            t.team_id,
                            t.team_name,
                            t.total_winnings,
                            'No' AS active_status
                        FROM team t
                        WHERE t.active_status = '0'
                        ORDER BY t.team_name
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading inactive teams:", e)
            return []
        
    