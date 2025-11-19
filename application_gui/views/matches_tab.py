from PySide6.QtWidgets import QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QTableWidget, QTableWidgetItem, \
    QHeaderView, QLineEdit, QComboBox
from PySide6.QtCore import Qt, Signal


class MatchesTab(QWidget):
    # Signals given to the controller
    add_clicked = Signal()
    edit_clicked = Signal(str)
    delete_clicked = Signal(str)
    row_double_clicked = Signal(str)

    search_changed = Signal(str)
    tournament_filter_changed = Signal(str)
    year_filter_changed = Signal(int)

    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()

        # Search and filter row
        search_filter_row = QHBoxLayout()

        # Search box (matchup)
        self.search_box = QLineEdit()
        self.search_box.setPlaceholderText("Search Matchup:")
        # Initially block signals until controller enables them
        self.search_box.blockSignals(True)
        self.search_box.textChanged.connect(self.search_changed.emit)
        search_filter_row.addWidget(self.search_box)

        # Tournament filter
        self.tournament_filter = QComboBox()
        self.tournament_filter.addItem("All Tournaments", None)
        self.tournament_filter.blockSignals(True)
        self.tournament_filter.currentIndexChanged.connect(
            lambda: self.tournament_filter_changed.emit(self.tournament_filter.currentData())
        )
        search_filter_row.addWidget(self.tournament_filter)

        # Year filter
        self.year_filter = QComboBox()
        self.year_filter.addItem("All Years", 0)
        self.year_filter.blockSignals(True)
        self.year_filter.currentIndexChanged.connect(
            lambda: self.year_filter_changed.emit(self.year_filter.currentData())
        )
        search_filter_row.addWidget(self.year_filter)

        layout.addLayout(search_filter_row)

        # Table for match list
        self.table = QTableWidget()
        self.table.setColumnCount(10)
        self.table.verticalHeader().setVisible(False)
        self.table.setHorizontalHeaderLabels([
            "ID", "TOURNAMENT", "DATE", "TIME", "BRACKET",
            "MATCHUP", "WINNER", "MAP", "SCORE", "MVP"
        ])

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

        # Table behavior
        self.table.verticalHeader().setDefaultSectionSize(40)
        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.setSortingEnabled(True)
        self.table.setShowGrid(False)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)

        # Style
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

        # Double-click for details
        self.table.cellDoubleClicked.connect(self.on_double_click)

        # Buttons
        btn_layout = QHBoxLayout()
        self.add_btn = QPushButton("Add")
        self.edit_btn = QPushButton("Edit")

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

        btn_layout.addWidget(self.add_btn)
        btn_layout.addWidget(self.edit_btn)
        btn_layout.addStretch()

        # Button signals
        self.add_btn.clicked.connect(lambda: self.add_clicked.emit())
        self.edit_btn.clicked.connect(self.on_edit)

        layout.addWidget(self.table)
        layout.addLayout(btn_layout)
        self.setLayout(layout)

    # Fill table with rows
    def fill(self, rows):
        self.table.setSortingEnabled(False)

        columns = [
            "match_id", "tournament_name", "match_date", "match_time",
            "bracket", "match_up", "winning_team", "map_name",
            "score", "mvp"
        ]

        self.table.setRowCount(len(rows))

        for r, row in enumerate(rows):
            for c, key in enumerate(columns):
                item = QTableWidgetItem()
                val = row.get(key, "")

                if isinstance(val, (int, float)):
                    item.setData(Qt.DisplayRole, val)
                else:
                    item.setText(str(val))

                self.table.setItem(r, c, item)

        self.table.setSortingEnabled(True)

    # Get the ID of the selected match
    def get_selected_id(self):
        row = self.table.currentRow()
        if row < 0:
            return None
        return str(self.table.item(row, 0).text())

    # Edit button handler
    def on_edit(self):
        match_id = self.get_selected_id()
        if match_id:
            self.edit_clicked.emit(match_id)

    # Row double-click handler
    def on_double_click(self, row, column):
        match_id = str(self.table.item(row, 0).text())
        self.row_double_clicked.emit(match_id)

    # Load tournament filter
    def load_tournament_filter(self, tournaments):
        self.tournament_filter.blockSignals(True)
        self.tournament_filter.clear()
        self.tournament_filter.addItem("All Tournaments", None)
        for t in tournaments:
            self.tournament_filter.addItem(t["tournament_name"], t["tournament_id"])
        self.tournament_filter.blockSignals(False)

    # Load year filter
    def load_year_filter(self, years):
        self.year_filter.blockSignals(True)
        self.year_filter.clear()
        self.year_filter.addItem("All Years", 0)
        for y in years:
            self.year_filter.addItem(str(y["year"]), y["year"])
        self.year_filter.blockSignals(False)