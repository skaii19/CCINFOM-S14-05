# from PySide6.QtWidgets import (
#     QDialog, QVBoxLayout, QFormLayout,
#     QLineEdit, QComboBox, QDateEdit,
#     QDialogButtonBox, QLabel, QPushButton
# )
# from PySide6.QtCore import Qt, QDate, Signal
# from .add_tournament_view import AddTournamentDialog
# from datetime import date

# class TournamentForm(QDialog):
#     # signal to emit form data
#     saved = Signal(dict)

#     def __init__(self, existing=None):
#         super().__init__()
#         self.setWindowTitle("Add Tournament")
#         self.existing = existing
#         self.setup_ui()


#     def setup_ui(self):
#         self.setMinimumSize(500, 350)
#         self.setStyleSheet("background-color: #121212; color: white;")

#         layout = QVBoxLayout()
#         form_layout = QFormLayout()

#         # Tournament Name
#         self.name_input = QLineEdit()
#         form_layout.addRow(QLabel("Tournament Name:"), self.name_input)

#         # Tournament Type
#         self.type_dropdown = QComboBox()
#         self.type_dropdown.addItems(["Masters", "Champions"])
#         form_layout.addRow(QLabel("Tournament Type:"), self.type_dropdown)

#         # Prize Pool
#         self.prize_input = QLineEdit()
#         self.prize_input.setPlaceholderText("Enter amount in USD")
#         form_layout.addRow(QLabel("Prize Pool:"), self.prize_input)

#         # Start Date
#         self.start_date = QDateEdit()
#         self.start_date.setDate(QDate.currentDate())
#         self.start_date.setCalendarPopup(True)
#         form_layout.addRow(QLabel("Start Date:"), self.start_date)

#         # Venue
#         self.venue_input = QLineEdit()
#         form_layout.addRow(QLabel("Venue:"), self.venue_input)

#         # City
#         self.city_input = QLineEdit()
#         form_layout.addRow(QLabel("City:"), self.city_input)

#         # Country
#         self.country_input = QLineEdit()
#         form_layout.addRow(QLabel("Country:"), self.country_input)

#         layout.addLayout(form_layout)
    

#         # Buttons
#         self.buttons = QDialogButtonBox(QDialogButtonBox.Save | QDialogButtonBox.Cancel)
#         self.buttons.clicked.connect(self.on_save)
#         self.buttons.rejected.connect(self.reject)
#         self.buttons.setStyleSheet("""
#             QDialogButtonBox QPushButton {
#                 background-color: #FF4655;
#                 color: white;
#                 border-radius: 5px;
#                 padding: 6px 12px;
#                 font-weight: bold;
#             }
#             QDialogButtonBox QPushButton:hover { background-color: #FF6B78; }
#             QDialogButtonBox QPushButton:pressed { background-color: #CC3A45; }
#         """)

#         layout.addWidget(self.buttons)

#         if self.existing:
#             self.fill_existing()


#     def fill_existing(self):
#         # Use the widgets you actually defined
#         self.name_input.setText(self.existing.get("tournament_name", ""))
#         self.type_dropdown.setCurrentText(self.existing.get("tournament_type", ""))
        
#         start = self.existing.get("start_date", date.today())
#         if isinstance(start, date):
#             self.start_date.setDate(QDate(start.year, start.month, start.day))
        
#         self.prize_input.setText(str(self.existing.get("prize_pool", "")))
#         self.country_input.setText(self.existing.get("country", ""))
#         self.city_input.setText(self.existing.get("city", ""))
#         self.venue_input.setText(self.existing.get("venue", ""))

#     def on_save(self, button):  
#         if self.buttons.button(QDialogButtonBox.Save) == button:  # Check if Save was clicked
#             data = {
#                 "tournament_name": self.name_input.text().strip(),
#                 "tournament_type": self.type_dropdown.currentText(),
#                 "start_date": self.start_date.date().toPython(),
#                 "prize_pool": float(self.prize_input.text() or 0),
#                 "country": self.country_input.text().strip(),
#                 "city": self.city_input.text().strip(),
#                 "venue": self.venue_input.text().strip()
#             }
#             self.saved.emit(data)
#         # If Cancel was clicked, do nothing 
#         self.close()  # Close regardless


from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QFormLayout,
    QLineEdit, QComboBox, QDateEdit,
    QPushButton
)
from PySide6.QtCore import Qt, QDate, Signal
from datetime import date


class TournamentForm(QWidget):
    # Signal emitted when user saves the form
    saved = Signal(dict)

    def __init__(self, existing=None):
        super().__init__()
        self.setWindowTitle("Tournament Form")  # Changed title for consistency
        self.existing = existing
        self.setup_ui()

    def setup_ui(self):
        self.setStyleSheet("background-color: #282c34; color: white;") 
        
        layout = QVBoxLayout()
        form = QFormLayout()

        # --- Input fields ---
        self.name_input = QLineEdit()
        self.type_dropdown = QComboBox()
        self.type_dropdown.addItems(["Masters", "Champions"])
        self.prize_input = QLineEdit()
        self.prize_input.setPlaceholderText("Enter amount in USD")
        self.start_date = QDateEdit()
        self.start_date.setDate(QDate.currentDate())
        self.start_date.setCalendarPopup(True)
        self.venue_input = QLineEdit()
        self.city_input = QLineEdit()
        self.country_input = QLineEdit()

        # Form rows
        form.addRow("Tournament Name:", self.name_input)
        form.addRow("Tournament Type:", self.type_dropdown)
        form.addRow("Prize Pool:", self.prize_input)
        form.addRow("Start Date:", self.start_date)
        form.addRow("Venue:", self.venue_input)
        form.addRow("City:", self.city_input)
        form.addRow("Country:", self.country_input)

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
        self.name_input.setText(self.existing.get("tournament_name", ""))
        self.type_dropdown.setCurrentText(self.existing.get("tournament_type", ""))
        
        start = self.existing.get("start_date", date.today())
        if isinstance(start, date):
            self.start_date.setDate(QDate(start.year, start.month, start.day))
        
        self.prize_input.setText(str(self.existing.get("prize_pool", "")))
        self.country_input.setText(self.existing.get("country", ""))
        self.city_input.setText(self.existing.get("city", ""))
        self.venue_input.setText(self.existing.get("venue", ""))

    def on_save(self):

        try:
            prize_pool = float(self.prize_input.text() or 0)
        except ValueError:
            prize_pool = 0.0

        data = {
            "tournament_name": self.name_input.text().strip(),
            "tournament_type": self.type_dropdown.currentText(),
            "start_date": self.start_date.date().toPython(),
            "prize_pool": prize_pool,
            "country": self.country_input.text().strip(),
            "city": self.city_input.text().strip(),
            "venue": self.venue_input.text().strip()
        }
        
        self.saved.emit(data)
        self.close()
