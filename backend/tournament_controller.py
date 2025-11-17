from db import get_cursor, get_connection

class Tournament:

    # Load all tournaments together with their location (venue, city, country)
    def load_tournaments(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            t.tournament_id,
                            t.tournament_name,
                            t.tournament_type,
                            t.prize_pool,
                            t.start_date,
                            t.end_date,
                            tl.venue,
                            tl.city,
                            tl.country
                        FROM tournament t
                        LEFT JOIN tournament_location tl ON t.tournament_id = tl.tournament_id
                        ORDER BY t.start_date, t.end_date
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading tournaments:", e)
            return []

    # Add a new tournament
    def add_tournament(self, tournament_id, tournament_name, tournament_type, prize_pool, start_date, end_date):
        try:
            cur = get_cursor()
            cur.execute("""
                        INSERT INTO tournament (tournament_id, tournament_name, prize_pool, tournament_type, start_date, end_date)
                        VALUES (%s, %s, %s, %s, %s, %s)
                        """, (tournament_id, tournament_name, prize_pool, tournament_type, start_date, end_date))
            get_connection().commit()
            print("Tournament added successfully!")
        except Exception as e:
            print("Error adding tournament:", e)

    # Update an existing tournament
    def update_tournament(self, tournament_id, tournament_name, tournament_type, prize_pool, start_date, end_date):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE tournament
                        SET tournament_name=%s, prize_pool=%s, tournament_type=%s, start_date=%s, end_date=%s
                        WHERE tournament_id=%s
                        """, (tournament_name, prize_pool, tournament_type, start_date, end_date, tournament_id))
            get_connection().commit()
            print("Tournament updated successfully!")
        except Exception as e:
            print("Error updating tournament:", e)

    # Delete a tournament
    def delete_tournament(self, tournament_id):
        try:
            cur = get_cursor()
            cur.execute("DELETE FROM tournament WHERE tournament_id=%s", (tournament_id,))
            get_connection().commit()
            print("Tournament deleted successfully!")
        except Exception as e:
            print("Error deleting tournament:", e)

    # Get a single tournament by ID
    def get_tournament(self, tournament_id):
        try:
            cur = get_cursor()
            cur.execute("SELECT * FROM tournament WHERE tournament_id=%s", (tournament_id,))
            return cur.fetchone()
        except Exception as e:
            print("Error fetching tournament:", e)
            return None

    # Get tournaments based on the type (Masters/Champions)
    def load_tournaments_by_type(self, tournament_type):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT
                            t.tournament_id,
                            t.tournament_name,
                            t.tournament_type,
                            t.prize_pool,
                            t.start_date,
                            t.end_date,
                            tl.venue,
                            tl.city,
                            tl.country
                        FROM tournament t
                        LEFT JOIN tournament_location tl ON t.tournament_id = tl.tournament_id
                        WHERE t.tournament_type = %s
                        ORDER BY t.start_date, t.end_date
                        """, (tournament_type,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading tournaments of type {tournament_type}:", e)
            return []
