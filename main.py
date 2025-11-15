import sys
from PySide6.QtWidgets import QApplication
from controller import Controller
from model import DatabaseModel
from view import DatabaseView
import mysql.connector

def main():
    app = QApplication(sys.argv)
    
    model = DatabaseModel()
    view = DatabaseView()
    controller = Controller(model, view)

    # --- Run the app ---
    controller.run()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
