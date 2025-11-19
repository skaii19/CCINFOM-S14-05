from PySide6.QtWidgets import QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QTableWidget, QTableWidgetItem, \
    QHeaderView, QLineEdit, QComboBox
from PySide6.QtCore import Qt, Signal

class TeamsTab(QWidget):

    add_clicked = Signal()
    edit_clicked = Signal(str)
    delete_clicked = Signal(str)
    row_double_clicked = Signal(str)

    search_changed = Signal(str)
    region_filter_changed = Signal(str)
    active_filter_changed = Signal(str)

    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()
        
        # Search and filter
        search_filter_row = QHBoxLayout()

        # Search bar (ID + Name)
        self.search_box = QLineEdit()
        self.search_box.setPlaceholderText("Search ID or Name:")
        self.search_box.textChanged.connect(self.search_changed.emit)
        search_filter_row.addWidget(self.search_box)

        # Region filter
        self.region_filter = QComboBox()
        self.region_filter.addItem("All", None)
        self.region_filter.currentIndexChanged.connect(
            lambda: self.region_filter_changed.emit(self.region_filter.currentData())
        )
        search_filter_row.addWidget(self.region_filter)

        # Active status filter
        self.status_filter = QComboBox()
        self.status_filter.addItem("All", None)
        self.status_filter.addItem("Active", "Yes")
        self.status_filter.addItem("Inactive", "No")
        self.status_filter.currentIndexChanged.connect(
            lambda: self.active_filter_changed.emit(self.status_filter.currentData())
        )
        search_filter_row.addWidget(self.status_filter)

        layout.addLayout(search_filter_row)

        # Table for displaying teams
        self.table = QTableWidget()
        self.table.setColumnCount(5)
        self.table.setHorizontalHeaderLabels(["ID", "NAME", "REGION", "TOTAL WINNINGS", "ACTIVE"])

        # Row font
        font = self.table.font()
        font.setPointSize(14)
        self.table.setFont(font)

        # Header font
        header = self.table.horizontalHeader()
        hfont = header.font()
        hfont.setPointSize(15)
        hfont.setBold(True)
        header.setFont(hfont)
        header.setDefaultAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        # Row height
        self.table.verticalHeader().setDefaultSectionSize(40)

        # Table behavior
        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.setSortingEnabled(True)
        self.table.setShowGrid(False)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)

        # Theme and row colors
        self.table.setAlternatingRowColors(True)
        self.table.setStyleSheet("""
            QTableWidget {
                background-color: #1a8277;
                alternate-background-color: #763746;
                color: #FFFFFF;
                gridline-color: #353d49;
            }

            QHeaderView::section {
                background-color: #353d49;
                color: #FFFFFF;
                border: none;
                padding: 12px;
            }

            QTableWidget::item {
                border: none;
                padding-left: 10px;
                background-color: transparent;
            }

            QTableWidget::item:selected {
                background-color: rgba(255,255,255,0.15);
                color: white;
            }
        """)

        # Double-click handler
        self.table.cellDoubleClicked.connect(self.on_double_click)

        # Button row
        btn_layout = QHBoxLayout()
        self.add_btn = QPushButton("Add")
        self.edit_btn = QPushButton("Edit")
        self.del_btn = QPushButton("Delete")

        # Button styling
        button_style = """
            QPushButton {
                background-color: #353d49;
                color: white;
                border: 2px solid #FF4655;
                padding: 8px 16px;
                border-radius: 6px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #763746;
            }
            QPushButton:pressed {
                background-color: #161A1E;
            }
        """

        self.add_btn.setStyleSheet(button_style)
        self.edit_btn.setStyleSheet(button_style)
        self.del_btn.setStyleSheet(button_style)

        btn_layout.addWidget(self.add_btn)
        btn_layout.addWidget(self.edit_btn)
        btn_layout.addWidget(self.del_btn)
        btn_layout.addStretch()

        # Button signals
        self.add_btn.clicked.connect(lambda: self.add_clicked.emit())
        self.edit_btn.clicked.connect(self.on_edit)
        self.del_btn.clicked.connect(self.on_delete)

        # Background for tab
        self.setStyleSheet("background-color: #1B1F23;")

        layout.addWidget(self.table)
        layout.addLayout(btn_layout)
        self.setLayout(layout)

    def fill(self, rows):
        # Disable sorting while filling the table
        self.table.setSortingEnabled(False)

        # Team info columns to be filled
        columns = ["team_id", "team_name", "region", "total_winnings", "active_status"]

        self.table.setRowCount(len(rows))

        for r, row in enumerate(rows):
            for c, key in enumerate(columns):
                item = QTableWidgetItem()
                val = row.get(key, "")

                # Use DisplayRole for numeric sorting
                if isinstance(val, (int, float)):
                    item.setData(Qt.DisplayRole, val)
                else:
                    item.setText(str(val))

                self.table.setItem(r, c, item)

        # Reenable sorting
        self.table.setSortingEnabled(True)

    def get_selected_id(self):
        # Return selected team's ID or None
        row = self.table.currentRow()
        if row < 0:
            return None
        return self.table.item(row, 0).text()

    def on_edit(self):
        # Edit signal for selected team
        team_id = self.get_selected_id()
        if id:
            self.edit_clicked.emit(team_id)

    def on_delete(self):
        # Delete signal for selected team
        team_id = self.get_selected_id()
        if id:
            self.delete_clicked.emit(team_id)

    def on_double_click(self, row):
        # Double-click signal for details window
        team_id = self.table.item(row, 0).text()
        self.row_double_clicked.emit(team_id)

    def load_region_filter(self, regions):
        # Get teams for filter dropdown
        self.region_filter.clear()
        self.region_filter.addItem("All", None)

        for r in regions:
            if isinstance(r, dict):
                self.region_filter.addItem(r.get("region", ""))
            else:
                self.region_filter.addItem(str(r))