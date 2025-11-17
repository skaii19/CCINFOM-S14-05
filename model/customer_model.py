from db import get_cursor, get_connection

class CustomerModel:

    # Load all customers
    def load_customers(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT *
                        FROM customer
                        ORDER BY customer_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading customers:", e)
            return []

    # Load customers by tournament
    def get_customers_by_tournament(self, tournament_id):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT *
                        FROM customer
                        WHERE tournament_id = %s
                        ORDER BY customer_id
                        """, (tournament_id,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading customers for tournament {tournament_id}:", e)
            return []

    # Load customers by mode of payment
    def get_customers_by_payment(self, mode_of_payment):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT *
                        FROM customer
                        WHERE mode_of_payment = %s
                        ORDER BY customer_id
                        """, (mode_of_payment,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading customers with payment {mode_of_payment}:", e)
            return []

