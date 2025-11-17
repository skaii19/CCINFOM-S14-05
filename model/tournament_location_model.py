from db import get_cursor, get_connection

class TournamentLocationModel:

    # Load all tournament locations
    def load_locations(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT 
                            tl.tournament_id, 
                            tl.venue, 
                            tl.city, 
                            tl.country
                        FROM tournament_location tl
                        ORDER BY tl.tournament_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading locations:", e)
            return []
        
    # Add a new location
    def add_location(self, tournament_id, venue, city, country):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO tournament_location (tournament_id, venue, city, country)
                        VALUES (%s, %s, %s, %s)
                        """, (tournament_id, venue, city, country))
            get_connection().commit()
            print("Location added successfully!")
        except Exception as e:
            print("Error adding location:", e)

    # Update an existing location
    def update_location(self, tournament_id, venue, city, country):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE tournament_location
                        SET venue=%s, city=%s, country=%s
                        WHERE tournament_id=%s
                        """, (venue, city, country, tournament_id))
            get_connection().commit()
            print("Location updated successfully!")
        except Exception as e:
            print("Error updating location:", e)

    # Delete an existing location
    def delete_location(self, tournament_id):
        try:
            cur = get_cursor()
            cur.execute("DELETE FROM tournament_location WHERE tournament_id=%s", (tournament_id,))
            get_connection().commit()
            print("Location deleted successfully!")
        except Exception as e:
            print("Error deleting location:", e)

    # Get a single tournament location by ID 
    def get_location(self, tournament_id):
        try:
            cur = get_cursor()
            cur.execute("SELECT * FROM tournament_location WHERE tournament_id=%s", (tournament_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching location:", e)
            return None
        

     # Filter locations by country
    def filter_by_country(self, country):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT *
                        FROM tournament_location
                        WHERE country = %s
                        ORDER BY tournament_id
                        """, (country,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error fetching locations for country '{country}':", e)
            return []
