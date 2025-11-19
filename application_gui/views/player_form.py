from PySide6.QtWidgets import (
    QWidget, QFormLayout, QLineEdit, QComboBox,
    QPushButton, QVBoxLayout, QCheckBox
)
from PySide6.QtCore import Signal

class PlayerForm(QWidget):
    # Signal emitted when user saves the form
    saved = Signal(dict)

    def __init__(self, teams, existing=None):
        super().__init__()
        self.setWindowTitle("Player Form")
        self.teams = teams
        self.existing = existing
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()
        form = QFormLayout()

        # Input fields
        self.ign_input = QLineEdit()
        self.name_input = QLineEdit()
        self.team_select = QComboBox()

        # Populate team dropdown using acronym team_id
        for t in self.teams:
            self.team_select.addItem(t["team_name"], t["team_id"])

        # Form rows
        form.addRow("IGN:", self.ign_input)
        form.addRow("Name:", self.name_input)
        form.addRow("Current Team:", self.team_select)

        # Active checkbox only for editing
        if self.existing:
            self.active_check = QCheckBox("Active (Y)")
            form.addRow("Active Status:", self.active_check)
        else:
            self.active_check = None

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
        self.ign_input.setText(self.existing["player_ign"])
        self.name_input.setText(self.existing["player_name"])
        self.active_check.setChecked(self.existing["active_status"] == "Y")

        team_id = self.existing["team_id"]
        idx = self.team_select.findData(team_id)
        if idx >= 0:
            self.team_select.setCurrentIndex(idx)

    def on_save(self):
        # Retrieve selected team_id (must always return the acronym string)
        team_id = self.team_select.currentData()

        if team_id is not None:
            team_id = str(team_id)  # ensure non-null acronym

        # Add mode → always active
        if not self.existing:
            active_status = "Y"
        else:
            # Edit mode → use checkbox
            active_status = "Y" if self.active_check.isChecked() else "N"

        # Data returned to controller
        data = {
            "ign": self.ign_input.text(),
            "name": self.name_input.text(),
            "team_id": team_id,
            "active": active_status
        }

        self.saved.emit(data)
        self.close()