
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QFormLayout,
    QLineEdit, QComboBox, QDateEdit,
    QPushButton, QMessageBox
)
from PySide6.QtCore import Qt, QDate, Signal
from datetime import date


class TournamentForm(QWidget):
    # Signal emitted when user saves the form
    saved = Signal(dict)

    def __init__(self, existing=None):
        super().__init__()
        self.setWindowTitle("Tournament Form")  
        self.existing = existing
        self.setup_ui()

    def setup_ui(self):
        self.setMinimumSize(300, 250) 
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

        # If editing, add End Date
        if self.existing:
            self.end_date = QDateEdit()
            self.end_date.setCalendarPopup(True)
            # Set existing end_date if available
            end = self.existing.get("end_date", date.today())
            if isinstance(end, date):
                self.end_date.setDate(QDate(end.year, end.month, end.day))
            form.addRow("End Date:", self.end_date)
            
        form.addRow("Venue:", self.venue_input)
        form.addRow("City:", self.city_input)
        form.addRow("Country:", self.country_input)



        # Save button 
        self.save_btn = QPushButton("Save")
        self.save_btn.clicked.connect(self.on_save)
        self.cancel_btn = QPushButton("Cancel")
        self.cancel_btn.clicked.connect(self.close) 

        layout.addLayout(form)
        layout.addWidget(self.save_btn)
        layout.addWidget(self.cancel_btn)
        layout.addStretch()  
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
        # Trim text fields
        name = self.name_input.text().strip()
        prize_text = self.prize_input.text().strip()
        venue = self.venue_input.text().strip()
        city = self.city_input.text().strip()
        country = self.country_input.text().strip()

        # --- Validation ---
        if not all([name, prize_text, venue, city, country]):
            QMessageBox.warning(self, "Incomplete Data", "Please fill out all fields before saving.")
            return
    
        try:
            prize_pool = float(self.prize_input.text())
        except ValueError:
            QMessageBox.warning(self, "Validation Error", "Prize Pool must be a number")
            return

        data = {
                "tournament_name": name,
                "tournament_type": self.type_dropdown.currentText(),
                "start_date": self.start_date.date().toPython(),
                "prize_pool": prize_pool,
                "venue": venue,
                "city": city,
                "country": country
            }
        
        if hasattr(self, "end_date"):
            data["end_date"] = self.end_date.date().toPython()
        
        self.saved.emit(data)
        self.close()
