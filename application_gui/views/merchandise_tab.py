from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QPushButton, 
    QTableWidget, QTableWidgetItem, QHeaderView, 
    QLabel, QMessageBox, QLineEdit
)
from PySide6.QtCore import Qt, Signal
from decimal import Decimal

class MerchandiseTab(QWidget):
    add_clicked = Signal()
    edit_clicked = Signal(int)
    delete_clicked = Signal(int)
    row_double_clicked = Signal(int)
    filter_changed = Signal()

    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()
        filter_layout = QHBoxLayout()

        # Name filter
        self.name_filter = QLineEdit()
        self.name_filter.setPlaceholderText("Search by product name")

        # Price range filters
        self.min_price_filter = QLineEdit()
        self.min_price_filter.setPlaceholderText("Min price")
        self.max_price_filter = QLineEdit()
        self.max_price_filter.setPlaceholderText("Max price")

        # Clear filter button
        self.clear_filter_btn = QPushButton("Clear")
        self.clear_filter_btn.setStyleSheet("""
            QPushButton {
                background-color: #353d49;
                color: white;
                padding: 4px 10px;
                border-radius: 5px;
                border: 1px solid #FF4655;
            }
            QPushButton:hover { background-color: #763746; }
        """)

        filter_layout.addWidget(QLabel("Name:"))
        filter_layout.addWidget(self.name_filter)
        filter_layout.addWidget(QLabel("Price:"))
        filter_layout.addWidget(self.min_price_filter)
        filter_layout.addWidget(QLabel("to"))
        filter_layout.addWidget(self.max_price_filter)
        filter_layout.addWidget(self.clear_filter_btn)
        filter_layout.addStretch()

        self.name_filter.textChanged.connect(lambda: self.filter_changed.emit())
        self.min_price_filter.textChanged.connect(lambda: self.filter_changed.emit())
        self.max_price_filter.textChanged.connect(lambda: self.filter_changed.emit())
        self.clear_filter_btn.clicked.connect(self.reset_filters)


        layout.addLayout(filter_layout)
    

        # ---- TABLE SETUP ----
        self.table = QTableWidget()
        self.table.setColumnCount(5)
        self.table.setHorizontalHeaderLabels([
            "ID", "Name", "Price", "Description", "Quantity"
        ])

        
        font = self.table.font()
        font.setPointSize(11)
        self.table.setFont(font)

        header = self.table.horizontalHeader()
        hfont = header.font()
        hfont.setPointSize(13)
        hfont.setBold(True)
        header.setFont(hfont)
        header.setDefaultAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        self.table.verticalHeader().setVisible(False)
        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.setSortingEnabled(True)
        self.table.setShowGrid(False)
        self.table.verticalHeader().setDefaultSectionSize(40)

        # ----- COLUMN RESIZING -----
        header = self.table.horizontalHeader()

        # ID
        header.setSectionResizeMode(0, QHeaderView.Fixed)
        header.resizeSection(0, 100)

        # Name 
        header.setSectionResizeMode(1, QHeaderView.Fixed)
        self.table.setColumnWidth(1, 220) 

        # Price 
        header.setSectionResizeMode(2, QHeaderView.Fixed)
        header.resizeSection(2, 150)

        # Description
        header.setSectionResizeMode(3, QHeaderView.Stretch)
        self.table.setColumnWidth(3, 250) 

        # Quantity 
        header.setSectionResizeMode(4, QHeaderView.Fixed)
        header.resizeSection(4, 200)


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

        self.table.cellDoubleClicked.connect(self.on_double_click)

        # ---- BUTTONS ----
        btn_layout = QHBoxLayout()
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
        self.edit_btn.setStyleSheet(button_style)
        self.del_btn.setStyleSheet(button_style)

        btn_layout.addWidget(self.edit_btn)
        btn_layout.addWidget(self.del_btn)
        btn_layout.addStretch()

        self.edit_btn.clicked.connect(self.on_edit)
        self.del_btn.clicked.connect(self.on_delete)

        self.table.setSelectionBehavior(QTableWidget.SelectRows)
        self.table.setSelectionMode(QTableWidget.SingleSelection)

        layout.addWidget(self.table)
        layout.addLayout(btn_layout)
        self.setLayout(layout)
        self.setStyleSheet("background-color: #121212;")

    # ---- TABLE FILLING ----
    def fill(self, rows):
        self.table.setSortingEnabled(False)
        self.table.setRowCount(len(rows))

        for r, row in enumerate(rows):
            self.table.setItem(r, 0, QTableWidgetItem(str(row["product_id"])))
            self.table.setItem(r, 1, QTableWidgetItem(row["product_name"]))

            # Price formatting
            price_item = QTableWidgetItem()
            val = row.get("product_price", 0)
            try:
                num = float(val) if isinstance(val, (Decimal, str)) else val
                price_item.setText(f"${num:,.2f}")
                price_item.setData(Qt.UserRole, num)
            except:
                price_item.setText(str(val))
            
            self.table.setItem(r, 2, price_item)
            self.table.setItem(r, 3, QTableWidgetItem(row.get("product_description", "")))
            self.table.setItem(r, 4, QTableWidgetItem(str(row.get("quantity_inStock", 0))))

        self.table.setSortingEnabled(True)

    # ---- SELECTION HELPERS ----
    def get_selected_id(self):
        items = self.table.selectedItems()
        if not items:
            return None
        row = items[0].row()
        return int(self.table.item(row, 0).text())

    # ---- BUTTON HANDLERS ----
    def on_edit(self):
        pid = self.get_selected_id()
        if pid:
            self.edit_clicked.emit(pid)
        else:
            QMessageBox.warning(self, "No Selection", "Please select a product to edit.")

    def on_delete(self):
        pid = self.get_selected_id()
        if pid:
            self.delete_clicked.emit(pid)

    def on_double_click(self, row, col):
        pid = int(self.table.item(row, 0).text())
        self.row_double_clicked.emit(pid)

    def reset_filters(self):
        self.name_filter.clear()
        self.min_price_filter.clear()
        self.max_price_filter.clear()
        self.filter_changed.emit()
