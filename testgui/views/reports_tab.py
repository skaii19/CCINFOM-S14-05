from PySide6.QtWidgets import QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QTableWidget, QTableWidgetItem, \
    QHeaderView, QLineEdit, QComboBox
from PySide6.QtCore import Qt, Signal

class ReportsTab(QWidget):
    # Signals given to the controller

    def __init__(self):
        super().__init__()
        self.setup_ui()