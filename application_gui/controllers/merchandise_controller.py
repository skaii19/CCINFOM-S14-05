from PySide6.QtWidgets import QMessageBox
from models.product_model import ProductModel
from views.merchandise_tab import MerchandiseTab
from views.merchandise_form import MerchandiseForm  

class MerchandiseController:
    def __init__(self, view: MerchandiseTab):
        self.view = view

        # Model
        self.model = ProductModel()

        # Prevent garbage collection of forms
        self.forms = []

        # Connect signals
        # self.view.add_clicked.connect(self.add_product)
        self.view.edit_clicked.connect(self.edit_product)
        self.view.delete_clicked.connect(self.delete_product)
        self.view.filter_changed.connect(self.apply_filters)


        # Load initial table
        self.load_table()

    # ----------------- Load Table -----------------
    def load_table(self):
        products = self.model.load_products()
        self.view.fill(products)

    # # ----------------- Add Product -----------------
    # def add_product(self):
    #     form = MerchandiseForm()  # empty form for new product
    #     form.saved.connect(self.save_new_product)
    #     form.show()
    #     self.forms.append(form)

    # def save_new_product(self, data):
    #     try:
    #         name = data["product_name"]
    #         price = data["product_price"]
    #         desc = data.get("product_description", "")
    #         quantity = data["quantity_inStock"]

    #         self.model.add_product(name, price, desc, quantity)
    #         self.load_table()

    #     except Exception as e:
    #         QMessageBox.critical(None, "Error", f"Failed to save product: {e}")

    # ----------------- Edit Product -----------------
    def edit_product(self, product_id):
        product = self.model.get_product(product_id)
        if not product:
            QMessageBox.warning(None, "Error", "Product not found.")
            return

        form = MerchandiseForm(existing=product)
        form.saved.connect(lambda data: self.save_edit_product(product_id, data))
        form.show()
        self.forms.append(form)

    def save_edit_product(self, product_id, data):
        try:
            name = data["product_name"]
            price = data["product_price"]
            desc = data.get("product_description", "")
            quantity = data["quantity_inStock"]

            self.model.update_product(product_id, name, price, desc, quantity)
            self.load_table()
        except Exception as e:
            QMessageBox.critical(None, "Error", f"Failed to update product: {e}")

    # ----------------- Delete Product -----------------
    def delete_product(self, product_id):
        product = self.model.get_product(product_id)
        if not product:
            QMessageBox.warning(None, "Error", "Product not found.")
            return

        confirm = QMessageBox.question(
            None,
            "Delete Product",
            f"Are you sure you want to delete {product['product_name']}?",
            QMessageBox.Yes | QMessageBox.No
        )

        if confirm == QMessageBox.Yes:
            self.model.delete_product(product_id)
            self.load_table()

    def apply_filters(self):
        all_products = self.model.load_products()
        name_text = self.view.name_filter.text().strip().lower()
        
        min_price = self.view.min_price_filter.text().strip()
        max_price = self.view.max_price_filter.text().strip()
        
        try:
            min_price = float(min_price) if min_price else None
        except ValueError:
            min_price = None
        try:
            max_price = float(max_price) if max_price else None
        except ValueError:
            max_price = None

        filtered = []
        for p in all_products:
            name_ok = name_text in p["product_name"].lower()
            price = float(p["product_price"])
            min_ok = (min_price is None or price >= min_price)
            max_ok = (max_price is None or price <= max_price)
            
            if name_ok and min_ok and max_ok:
                filtered.append(p)

        self.view.fill(filtered)

