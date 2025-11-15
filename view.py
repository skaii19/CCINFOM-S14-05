from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit,
    QPushButton, QComboBox, QTableWidget, QTableWidgetItem, QTabWidget
)

class DatabaseView(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("CCINFOM DB APP")
        self.resize(900, 600)

        self.tabs = QTabWidget()
        self.table_dropdown = QComboBox()

        # --- Table Viewer Tab ---
        self.entries_input = QLineEdit()
        self.entries_input.setPlaceholderText("Number of entries")
        self.show_button = QPushButton("Show Table")
        self.result_table = QTableWidget()

        table_tab = QWidget()
        table_layout = QVBoxLayout()
        form_layout = QHBoxLayout()
        form_layout.addWidget(QLabel("Table:"))
        form_layout.addWidget(self.table_dropdown)
        form_layout.addWidget(QLabel("Entries:"))
        form_layout.addWidget(self.entries_input)
        form_layout.addWidget(self.show_button)
        table_layout.addLayout(form_layout)
        table_layout.addWidget(self.result_table)
        table_tab.setLayout(table_layout)

        # --- Matches Viewer Tab ---
        self.team_input = QLineEdit()
        self.team_input.setPlaceholderText("Enter team ID")
        self.matches_button = QPushButton("Show Matches")
        self.matches_table = QTableWidget()

        matches_tab = QWidget()
        matches_layout = QVBoxLayout()
        matches_form = QHBoxLayout()
        matches_form.addWidget(QLabel("Team ID:"))
        matches_form.addWidget(self.team_input)
        matches_form.addWidget(self.matches_button)
        matches_layout.addLayout(matches_form)
        matches_layout.addWidget(self.matches_table)
        matches_tab.setLayout(matches_layout)

        # Add tabs
        self.tabs.addTab(table_tab, "Tables")
        self.tabs.addTab(matches_tab, "Matches")

        # Main layout
        main_layout = QVBoxLayout()
        main_layout.addWidget(self.tabs)
        self.setLayout(main_layout)
        
    def set_table_options(self, tables):
            self.table_dropdown.clear()
            self.table_dropdown.addItems(tables)

    def populate_table(self, widget, rows, headers):
        widget.clear()
        widget.setRowCount(len(rows))
        widget.setColumnCount(len(headers))
        widget.setHorizontalHeaderLabels(headers)
        for i, row in enumerate(rows):
            for j, value in enumerate(row):
                widget.setItem(i, j, QTableWidgetItem(str(value)))
