from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout,
    QLabel, QLineEdit, QTextEdit, QSpinBox,
    QDoubleSpinBox, QPushButton, QMessageBox
)
from PySide6.QtCore import Signal

class MerchandiseForm(QDialog):
    saved = Signal(dict)

    def __init__(self, existing=None):
        super().__init__()
        self.setWindowTitle("Product Form")
        self.setMinimumWidth(400)

        self.existing = existing or {}

        self.setup_ui()
        self.load_existing()

    def setup_ui(self):
        layout = QVBoxLayout()

        # Name
        self.name_input = QLineEdit()
        layout.addWidget(QLabel("Product Name:"))
        layout.addWidget(self.name_input)

        # Price
        self.price_input = QDoubleSpinBox()
        self.price_input.setMaximum(999999.99)
        self.price_input.setPrefix("$")
        self.price_input.setDecimals(2)
        layout.addWidget(QLabel("Price:"))
        layout.addWidget(self.price_input)

        # Description
        self.desc_input = QTextEdit()
        self.desc_input.setFixedHeight(80)
        layout.addWidget(QLabel("Description:"))
        layout.addWidget(self.desc_input)

        # Quantity
        self.quantity_input = QSpinBox()
        self.quantity_input.setMaximum(1000000)
        layout.addWidget(QLabel("Quantity in Stock:"))
        layout.addWidget(self.quantity_input)

        # Buttons
        btn_layout = QHBoxLayout()
        self.save_btn = QPushButton("Save")
        self.cancel_btn = QPushButton("Cancel")
        btn_layout.addStretch()
        btn_layout.addWidget(self.save_btn)
        btn_layout.addWidget(self.cancel_btn)

        layout.addLayout(btn_layout)
        self.setLayout(layout)

        # Connect buttons
        self.save_btn.clicked.connect(self.on_save)
        self.cancel_btn.clicked.connect(self.reject)

    def load_existing(self):
        if self.existing:
            self.name_input.setText(self.existing.get("product_name", ""))
            self.price_input.setValue(float(self.existing.get("product_price", 0)))
            self.desc_input.setPlainText(self.existing.get("product_description", ""))
            self.quantity_input.setValue(int(self.existing.get("quantity_inStock", 0)))

    def on_save(self):
        name = self.name_input.text().strip()
        price = self.price_input.value()
        desc = self.desc_input.toPlainText().strip()
        quantity = self.quantity_input.value()

        if not name:
            QMessageBox.warning(self, "Validation Error", "Product name cannot be empty.")
            return

        if price <= 0:
            QMessageBox.warning(self, "Validation Error", "Price must be greater than 0.")
            return

        if quantity < 0:
            QMessageBox.warning(self, "Validation Error", "Quantity cannot be negative.")
            return

        data = {
            "product_name": name,
            "product_price": price,
            "product_description": desc,
            "quantity_inStock": quantity
        }

        self.saved.emit(data)
        self.accept()

