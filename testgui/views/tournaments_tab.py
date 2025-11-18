from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QTableWidget, QTableWidgetItem, QHeaderView, QDialog
)
from PySide6.QtCore import Qt, Signal
from datetime import datetime, date
from decimal import Decimal
from .tournament_form import TournamentForm

class TournamentsTab(QWidget):

    add_clicked = Signal()
    edit_clicked = Signal(str)
    delete_clicked = Signal(str)
    row_double_clicked = Signal(str)

    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()

        # ---- TABLE SETUP ----
        self.table = QTableWidget()
        self.table.setColumnCount(9)
        self.table.setHorizontalHeaderLabels([
            "ID", "Name", "Type", "Prize Pool",
            "Start Date", "End Date",
            "Venue", "City", "Country"
        ])

        # Font sizes
        font = self.table.font()
        font.setPointSize(11)
        self.table.setFont(font)

        header = self.table.horizontalHeader()
        hfont = header.font()
        hfont.setPointSize(13)
        hfont.setBold(True)
        header.setFont(hfont)
        header.setDefaultAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        # Remove row numbers
        self.table.verticalHeader().setVisible(False)

        # Behavior
        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.setSortingEnabled(True)
        self.table.setShowGrid(False)
        self.table.verticalHeader().setDefaultSectionSize(40)

        # Resizing the column width
        header.setSectionResizeMode(0, QHeaderView.Fixed)   # ID
        header.resizeSection(0, 100)                         

        header.setSectionResizeMode(1, QHeaderView.Interactive)
        self.table.setColumnWidth(1, 250)  # initial width
        self.table.horizontalHeader().setMaximumSectionSize(400)  # max width allowed

        header.setSectionResizeMode(2, QHeaderView.Fixed) # Type
        header.resizeSection(2, 150)  

        header.setSectionResizeMode(3, QHeaderView.Fixed) # Prize
        header.resizeSection(3, 160)  

        header.setSectionResizeMode(4, QHeaderView.Fixed) # Start
        header.resizeSection(4, 175)  

        header.setSectionResizeMode(5, QHeaderView.Fixed) # End
        header.resizeSection(5, 175)  

        header.setSectionResizeMode(6, QHeaderView.Fixed) # Venue
        header.resizeSection(6, 180)  

        header.setSectionResizeMode(7, QHeaderView.Fixed) # City
        header.resizeSection(7, 170)  

        header.setSectionResizeMode(8, QHeaderView.Fixed) # Country
        header.resizeSection(8, 170)  


        # Theme 
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
                padding: 8px;
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

        # On double click
        self.table.cellDoubleClicked.connect(self.on_double_click)

        # ---- BUTTONS ----
        btn_layout = QHBoxLayout()
        self.add_btn = QPushButton("Add")
        self.edit_btn = QPushButton("Edit")
        self.del_btn = QPushButton("Delete")

        button_style = """
            QPushButton {
                background-color: #353d49;  
                color: white;
                border: 2px solid #FF4655;
                padding: 6px 14px;
                border-radius: 5px;
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

        # ---- BUTTON SIGNALS ----
        self.add_btn.clicked.connect(lambda: self.add_clicked.emit())
        self.edit_btn.clicked.connect(self.on_edit)
        self.del_btn.clicked.connect(self.on_delete)

        # Background
        self.setStyleSheet("background-color: #121212;")  

        layout.addWidget(self.table)
        layout.addLayout(btn_layout)
        self.setLayout(layout)

    # ---- TABLE FILLING ----
    def fill(self, rows):
        self.table.setSortingEnabled(False)

        columns = [
            "tournament_id", "tournament_name", "tournament_type",
            "prize_pool", "start_date", "end_date",
            "venue", "city", "country"
        ]

        self.table.setRowCount(len(rows))

        for r, row in enumerate(rows):
            for c, key in enumerate(columns):
                item = QTableWidgetItem()
                val = row.get(key, "")

                # Handle prize_pool with proper formatting
                if key == "prize_pool" and val != "":
                    try:
                        # Convert Decimal or string to float
                        num = float(val) if isinstance(val, (Decimal, str)) else val
                        item.setText(f"${num:,.2f}")       # display with commas and 2 decimals
                        item.setData(Qt.UserRole, num)   
                    except Exception:
                        item.setText(str(val))

                # Format dates as "November 11, 2025"
                elif key in ["start_date", "end_date"] and val:
                    try:
                        item.setText(val.strftime("%B %d, %Y"))
                    except Exception:
                        item.setText(str(val))

                # Default case
                else:
                    item.setText(str(val))

                self.table.setItem(r, c, item)

        self.table.setSortingEnabled(True)

    # ---- SELECTION HELPERS ----

    def get_selected_id(self):
        row = self.table.currentRow()
        if row < 0:
            return None
        return self.table.item(row, 0).text()  

    # Button handlers
    def on_edit(self):
        tid = self.get_selected_id()
        if tid:
            self.edit_clicked.emit(tid)

    def on_delete(self):
        tid = self.get_selected_id()
        if tid:
            self.delete_clicked.emit(tid)

    def on_double_click(self, row, col):
        tid = self.table.item(row, 0).text()
        self.row_double_clicked.emit(tid)


