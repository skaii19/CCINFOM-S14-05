from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPushButton,
    QComboBox, QDateEdit, QTableWidget, QHeaderView, 
)
from PySide6.QtCore import Qt, QDate
from PySide6.QtGui import QFont

class ReportTab(QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        main_layout = QVBoxLayout()
        main_layout.setSpacing(15)

        # --- REPORT TYPE ---
        report_type_layout = QHBoxLayout()
        report_type_label = QLabel("Report Type:")
        report_type_label.setStyleSheet("color: white; font-weight: bold; font-size: 16pt;")
        self.report_type = QComboBox()
        self.report_type.addItems([
            "Tournament Revenue",
            "Merchandise Revenue",
            "Tournament Statistics",
            "Team Performance"
        ])
        report_type_layout.addWidget(report_type_label)
        report_type_layout.addWidget(self.report_type)
        report_type_layout.addStretch()
        main_layout.addLayout(report_type_layout)

        # --- FILTER CONTAINER ---
        self.filter_container = QVBoxLayout()
        main_layout.addLayout(self.filter_container)

        # --- GENERATE BUTTON ---
        self.generate_btn = QPushButton("Generate")
        self.generate_btn.setStyleSheet("""
            QPushButton {
                background-color: #353d49;
                color: white;
                padding: 6px 14px;
                border-radius: 5px;
                font-weight: bold;
            }
            QPushButton:hover { background-color: #763746; }
            QPushButton:pressed { background-color: #161A1E; }
        """)

        self.clear_btn = QPushButton("Clear")
        self.clear_btn.setStyleSheet("""
            QPushButton {
                background-color: #555555;
                color: white;
                padding: 6px 14px;
                border-radius: 5px;
                font-weight: bold;
            }
            QPushButton:hover { background-color: #763746; }
            QPushButton:pressed { background-color: #161A1E; }
        """)
        main_layout.addWidget(self.generate_btn)
        main_layout.addWidget(self.clear_btn)



        # --- TABLE ---
        self.table = QTableWidget()
        self.table.setColumnCount(0)
        self.table.verticalHeader().setVisible(False)
        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.setSortingEnabled(True)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        header_font = QFont()
        header_font.setPointSize(16) 
        self.table.horizontalHeader().setFont(header_font)
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

        font = self.table.font()
        font.setPointSize(14)  
        self.table.setFont(font)

        main_layout.addWidget(self.table)

        self.setStyleSheet("background-color: #121212;")
        self.setLayout(main_layout)

        # --- CONNECT REPORT TYPE CHANGE ---
        self.report_type.currentTextChanged.connect(self.update_filters)
        self.update_filters(self.report_type.currentText())

    def clear_layout(self, layout):
        """Remove all widgets from a layout."""
        while layout.count():
            item = layout.takeAt(0)
            if item.widget():
                item.widget().deleteLater()
            elif item.layout():
                self.clear_layout(item.layout())

    def update_filters(self, report_name):
        # Clear old filters
        self.clear_layout(self.filter_container)

        row = QHBoxLayout()
        row.setSpacing(12)

        if report_name == "Tournament Revenue":
            # Tournament
            self.tournament_filter = QComboBox()
            self.tournament_filter.addItem("All")
            row.addWidget(QLabel("Tournament:"))
            row.addWidget(self.tournament_filter)

            # Tournament Day
            self.tournament_day_filter = QComboBox()
            self.tournament_day_filter.setSizeAdjustPolicy(QComboBox.AdjustToContents)
            self.tournament_day_filter.addItem("All")
            row.addWidget(QLabel("Tournament Day:"))
            row.addWidget(self.tournament_day_filter)

            # Year
            self.year_filter = QComboBox()
            self.year_filter.addItems([str(y) for y in range(2010, 2031)])
            self.year_filter.setCurrentText(str(QDate.currentDate().year()))
            row.addWidget(QLabel("Year:"))
            row.addWidget(self.year_filter)

        elif report_name == "Merchandise Revenue":
            self.merch_tournament_filter = QComboBox()
            self.merch_tournament_filter.addItem("All")
            row.addWidget(QLabel("Tournament:"))
            row.addWidget(self.merch_tournament_filter)

            self.merch_month_filter = QComboBox()
            self.merch_month_filter.addItems(["All"] + [str(m) for m in range(1, 13)])
            row.addWidget(QLabel("Month:"))
            row.addWidget(self.merch_month_filter)

            self.merch_year_filter = QComboBox()
            self.merch_year_filter.addItems([str(y) for y in range(2010, 2031)])
            self.merch_year_filter.setCurrentText(str(QDate.currentDate().year()))
            row.addWidget(QLabel("Year:"))
            row.addWidget(self.merch_year_filter)

        elif report_name == "Tournament Statistics":
            self.stat_tournament_filter = QComboBox()
            self.stat_tournament_filter.addItem("All")
            row.addWidget(QLabel("Tournament:"))
            row.addWidget(self.stat_tournament_filter)

        elif report_name == "Team Performance":
            self.team_filter = QComboBox()
            self.team_filter.addItem("All")
            row.addWidget(QLabel("Team:"))
            row.addWidget(self.team_filter)

        row.addStretch()
        self.filter_container.addLayout(row)
