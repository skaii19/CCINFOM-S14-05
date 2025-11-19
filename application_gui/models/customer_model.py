from db import get_cursor, get_connection

class CustomerModel:

    # Load all customers
    def load_customers(self):
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT customer_id, customer_name, ticket_id, date_of_ticket, tournament_id, ticket_price, mode_of_payment,
                            CASE 
                            WHEN verified = '1' THEN 'Yes' 
                            ELSE 'No'
                            END AS verified
                        FROM customer
                        ORDER BY customer_id;
                        """)
            return cur.fetchall()
        except Exception as e:
            print("Error loading customers:", e)
            return []

    # Update an existing customer
    def update_customer(self, customer_name, ticket_id, date_of_ticket, tournament_id, ticket_price, mode_of_payment, verified):
        try:
            cur = get_cursor()
            cur.execute("""
                        UPDATE customer
                        SET customer_name=%s, ticket_id=%s, date_of_ticket=%s, tournament_id=%s, ticket_price=%s, mode_of_payment=%s, verified=%s
                        WHERE customer_id=%s
                        """, (customer_name, ticket_id, date_of_ticket, tournament_id, ticket_price, mode_of_payment, verified))
            get_connection().commit()
            print("Customer updated successfully!")
        except Exception as e:
            print("Error updating customer:", e)


    # Delete a customer
    def delete_customer(self, customer_id):
        try:
            cur = get_cursor()
            cur.execute("DELETE FROM customer WHERE customer_id=%s", (customer_id,))
            get_connection().commit()
            print("Customer deleted successfully!")
        except Exception as e:
            print("Error deleting customer:", e)
    
    def get_mode_of_payment(self) :
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT DISTINCT mode_of_payment
                        FROM customer
                        """)
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading mode of payment:", e)
            return []
    
    def get_tournament_names(self) :
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT DISTINCT c.tournament_id, t.tournament_name
                        FROM customer c JOIN tournament t ON t.tournament_id = c.tournament_id
                        """)
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading mode of payment:", e)
            return []
    
    def get_customer(self, customer_id) :
        try:
            cur = get_cursor()
            cur.execute("""
                        SELECT * FROM customer WHERE customer_id = %s
                        """, (customer_id,))
            return cur.fetchall()
        except Exception as e:
            print(f"Error loading mode of payment:", e)
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

