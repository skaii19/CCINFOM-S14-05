from PySide6.QtWidgets import QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QTableWidget, QTableWidgetItem, \
    QHeaderView, QLineEdit, QComboBox
from PySide6.QtCore import Qt, Signal

class CustomersTab(QWidget):
    # Signals given to the controller
    edit_clicked = Signal(int)
    delete_clicked = Signal(int)

    search_changed = Signal(str)
    tournament_filter_changed = Signal(str)
    verified_filter_changed = Signal(str)

    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()

        # Search and filter
        search_filter_row = QHBoxLayout()

        # Search bar (Customer Name or Ticket ID)
        self.search_box = QLineEdit()
        self.search_box.setPlaceholderText("Search Customer Name or Ticket ID:")
        self.search_box.textChanged.connect(lambda text: self.search_changed.emit(text))
        search_filter_row.addWidget(self.search_box)

        # Tournament filter
        self.tournament_filter = QComboBox()
        self.tournament_filter.addItem("All", None)
        self.tournament_filter.currentIndexChanged.connect(
            lambda: self.tournament_filter_changed.emit(self.tournament_filter.currentData())
        )
        search_filter_row.addWidget(self.tournament_filter)

        # Verified filter (Active vs Inactive customers)
        self.verified_filter = QComboBox()
        self.verified_filter.addItem("All", None)
        self.verified_filter.addItem("Verified", "Yes")
        self.verified_filter.addItem("Unverified", "No")
        self.verified_filter.currentIndexChanged.connect(
            lambda: self.verified_filter_changed.emit(self.verified_filter.currentData())
        )
        search_filter_row.addWidget(self.verified_filter)

        layout.addLayout(search_filter_row)

        # Table for displaying customers
        self.table = QTableWidget()
        self.table.setColumnCount(8)
        self.table.verticalHeader().setVisible(False)
        self.table.setHorizontalHeaderLabels(["ID", "NAME", "DATE OF TICKET", "TOURNAMENT ID", "TICKET ID", "TICKET PRICE", "PAYMENT METHOD", "VERIFIED"])

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

        # Button row
        btn_layout = QHBoxLayout()
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

        self.edit_btn.setStyleSheet(button_style)
        self.del_btn.setStyleSheet(button_style)

        btn_layout.addWidget(self.edit_btn)
        btn_layout.addWidget(self.del_btn)
        btn_layout.addStretch()

        # Button signals
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

        # Customer info columns to be filled
        columns = ["customer_id", "customer_name", "date_of_ticket", "tournament_id", "ticket_id", "ticket_price", "mode_of_payment", "verified"]

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
        # Return selected customer's ID or None
        row = self.table.currentRow()
        if row < 0:
            return None
        return int(self.table.item(row, 0).text())

    def on_edit(self):
        # Edit signal for selected customer
        cid = self.get_selected_id()
        if cid:
            self.edit_clicked.emit(cid)

    def on_delete(self):
        # Delete signal for selected customer
        cid = self.get_selected_id()
        if cid:
            self.delete_clicked.emit(cid)

    def load_tournament_filter(self, tournaments):
        # Get tournaments for filter dropdown
        self.tournament_filter.clear()
        self.tournament_filter.addItem("All", None)

        for t in tournaments:
            self.tournament_filter.addItem(t["tournament_id"], t["tournament_id"])
