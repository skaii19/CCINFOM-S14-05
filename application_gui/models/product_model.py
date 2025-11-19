from db import get_cursor, get_connection

class ProductModel:

    def load_products(self):
        try:
            cur = get_cursor()
            cur.execute("SELECT * FROM product ORDER BY product_id")
            return cur.fetchall()
        except Exception as e:
            print("Error loading products:", e)
            return []

    def add_product(self, name, price, description, quantity):
        try:
            cur = get_cursor()
            cur.execute("""
                INSERT INTO product (product_name, product_price, product_description, quantity_inStock)
                VALUES (%s, %s, %s, %s)
            """, (name, price, description, quantity))
            get_connection().commit()
        except Exception as e:
            print("Error adding product:", e)

    def update_product(self, product_id, name, price, description, quantity):
        try:
            cur = get_cursor()
            cur.execute("""
                UPDATE product
                SET product_name=%s, product_price=%s, product_description=%s, quantity_inStock=%s
                WHERE product_id=%s
            """, (name, price, description, quantity, product_id))
            get_connection().commit()
        except Exception as e:
            print("Error updating product:", e)

    def delete_product(self, product_id):
        try:
            cur = get_cursor()
            cur.execute("DELETE FROM product WHERE product_id=%s", (product_id,))
            get_connection().commit()
        except Exception as e:
            print("Error deleting product:", e)

    def get_product(self, product_id):
        try:
            cur = get_cursor()
            cur.execute("SELECT * FROM product WHERE product_id = %s", (product_id,))
            return cur.fetchone()  
        except Exception as e:
            print("Error fetching product:", e)
            return None
