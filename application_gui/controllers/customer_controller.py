from datetime import date, timedelta
from PySide6.QtWidgets import QMessageBox

from models.customer_model import CustomerModel
from models.tournament_model import TournamentModel

from views.customer_form import CustomerForm

class CustomerController:

    def __init__(self, view):
        self.view = view

        # Models
        self.customer_model = CustomerModel()

        # Prevent garbage collection of windows/forms
        self.details_windows = []

        # Connect signals
        self.view.edit_clicked.connect(self.edit_customer)
        self.view.delete_clicked.connect(self.delete_customer)

        # Search/filter signals
        view.search_changed.connect(self.apply_filters)
        view.tournament_filter_changed.connect(self.apply_filters)
        view.verified_filter_changed.connect(self.apply_filters)

        # Load initial table
        self.load_table()

        # Load tournaments into filter dropdown
        tournaments = self.customer_model.get_tournament_names()
        self.view.load_tournament_filter(tournaments)

    # Load table
    def load_table(self):
        customers = self.customer_model.load_customers()
        self.view.fill(customers)

    # Search and Filter
    def apply_filters(self, *args):
        search = self.view.search_box.text().strip().lower()
        tournament = self.view.tournament_filter.currentData()
        verified = self.view.verified_filter.currentData()

        customers = self.customer_model.load_customers()

        filtered = []
        for c in customers:
            # Search filter
            if search:
                if search not in c["customer_name"].lower():
                    continue

            # Tournament filter
            if tournament and c["tournament_id"] != tournament:
                continue

            # Verified filter
            if verified is not None and c["verified"] != verified:
                continue

            filtered.append(c)

        self.view.fill(filtered)

    # Edit Customer
    def edit_customer(self, customer_id):
        customer = self.customer_model.get_customer(customer_id)
        tournaments = self.customer_model.get_tournament_names()

        form = CustomerForm(tournaments, existing=customer)
        form.saved.connect(lambda data: self.save_edit_customer(customer_id, customer, data))
        form.show()
        self.details_windows.append(form)

    def save_edit_customer(self, new):
        self.customer_model.update_customer(new["customer_name"], new["ticket_id"], new["tournament_id"], new["date_of_ticket"], new["ticket_price"], new["mode_of_payment"], new["verified"])

        self.load_table()

    # Delete Customer
    def delete_customer(self, customer_id):
        self.customer_model.delete_customer(customer_id)
        self.load_table()