from PySide6.QtWidgets import (
    QWidget, QFormLayout, QLineEdit, QComboBox,
    QPushButton, QVBoxLayout, QCheckBox
)
from PySide6.QtCore import Signal

class TeamForm(QWidget):
    # Signal emitted when user saves the form
    saved = Signal(dict)

    def __init__(self, regions, existing=None):
        super().__init__()
        self.setWindowTitle("Team Form")
        self.regions = regions
        self.existing = existing
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()
        form = QFormLayout()

        # Input fields
        self.id_input = QLineEdit()
        self.name_input = QLineEdit()
        self.region_select = QComboBox()
        self.total_winnings = QLineEdit()

        # Populate team dropdown using acronym team_id
        for r in self.regions:
            self.region_select.addItem(r["region"])

        # Form rows
        form.addRow("Team ID:", self.id_input)
        form.addRow("Team Name:", self.name_input)
        form.addRow("Region: ", self.region_select)
        form.addRow("Total Winnings:", self.total_winnings)

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
        self.id_input.setText(self.existing["team_id"])
        self.id_input.setReadOnly(True)
        self.name_input.setText(self.existing["team_name"])
        self.total_winnings.setText(str(self.existing["total_winnings"]))
        self.active_check.setChecked(self.existing["active_status"] == "Y")

        region = self.existing["region"]
        idx = self.region_select.findText(region)
        if idx >= 0:
            self.region_select.setCurrentIndex(idx)

    def on_save(self):
        region = self.region_select.currentText().strip()

        if region is not None:
            region = str(region)  # ensure non-null acronym

        # Add mode → always active
        if not self.existing:
            active_status = "Y"
        else:
            # Edit mode → use checkbox
            active_status = "Y" if self.active_check.isChecked() else "N"
            
        # Data returned to controller
        data = {
            "team_id": self.id_input.text(),
            "team_name": self.name_input.text(),
            "region": region,
            "total_winnings" : float(self.total_winnings.text()),
            "active_status": active_status
        }

        print(data)

        self.saved.emit(data)
        self.close()