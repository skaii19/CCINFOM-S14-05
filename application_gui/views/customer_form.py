from PySide6.QtWidgets import (
    QWidget, QFormLayout, QLineEdit, QComboBox,
    QPushButton, QVBoxLayout, QCheckBox, QDateEdit
)
from PySide6.QtCore import Signal, QDate

class CustomerForm(QWidget):
    # Signal emitted when user saves the form
    saved = Signal(dict)

    def __init__(self, tournaments, existing=None):
        super().__init__()
        self.setWindowTitle("Customer Form")
        self.tournaments = tournaments
        self.existing = existing
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()
        form = QFormLayout()

        # Input fields
        self.name_input = QLineEdit()
        self.date_of_ticket = QDateEdit()
        self.date_of_ticket.setDate(QDate.currentDate())  # Default to current date
        self.tournament_select = QComboBox()
        self.ticket_id_input = QLineEdit()
        self.ticket_price_input = QLineEdit()
        self.payment_method_select = QComboBox()
        self.verified_check = QCheckBox("Verified")

        # Populate tournament dropdown with tournament IDs
        for tournament in self.tournaments:
            self.tournament_select.addItem(tournament["tournament_name"])

        # Payment method options
        payment_methods = ["Credit Card", "Paypal", "Bank Transfer", "GCash"]
        self.payment_method_select.addItems(payment_methods)

        # Form rows
        form.addRow("Customer Name:", self.name_input)
        form.addRow("Date of Ticket:", self.date_of_ticket)
        form.addRow("Tournament ID:", self.tournament_select)
        form.addRow("Ticket ID:", self.ticket_id_input)
        form.addRow("Ticket Price:", self.ticket_price_input)
        form.addRow("Payment Method:", self.payment_method_select)

        # Save button
        self.save_btn = QPushButton("Save")
        self.save_btn.clicked.connect(self.on_save)

        layout.addLayout(form)
        layout.addWidget(self.save_btn)
        self.setLayout(layout)

        # Fill fields if editing
        if self.existing:
            self.fill_existing()

    def fill_existing(self):
        # Load existing values into the form
        self.name_input.setText(self.existing["customer_name"])
        self.date_of_ticket.setDate(QDate.fromString(self.existing["date_of_ticket"], "yyyy-MM-dd"))
        self.ticket_id_input.setText(self.existing["ticket_id"])
        self.ticket_price_input.setText(str(self.existing["ticket_price"]))
        self.payment_method_select.setCurrentText(self.existing["mode_of_payment"])
        self.verified_check.setChecked(self.existing["verified"] == 1)

        # Set tournament ID
        tournament = self.existing["tournament_id"]
        idx = self.tournament_select.findText(tournament)
        if idx >= 0:
            self.tournament_select.setCurrentIndex(idx)

    def on_save(self):
        # Collect form data
        customer_name = self.name_input.text().strip()
        date_of_ticket = self.date_of_ticket.date().toString("yyyy-MM-dd")
        tournament_id = self.tournament_select.currentText().strip()
        ticket_id = self.ticket_id_input.text().strip()
        ticket_price = float(self.ticket_price_input.text().strip())
        mode_of_payment = self.payment_method_select.currentText().strip()
        verified = 1 if self.verified_check.isChecked() else 0

        # Data returned to controller
        data = {
            "customer_name": customer_name,
            "date_of_ticket": date_of_ticket,
            "tournament_id": tournament_id,
            "ticket_id": ticket_id,
            "ticket_price": ticket_price,
            "mode_of_payment": mode_of_payment,
            "verified": verified
        }

        print(data)

        self.saved.emit(data)
        self.close()
