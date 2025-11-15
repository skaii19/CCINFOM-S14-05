import sys
from PySide6.QtWidgets import QApplication
from model import DatabaseModel
from view import DatabaseView

class Controller():
    def __init__(self, model, view):
        self.model = model
        self.view = view

        tables = self.model.get_available_tables()
        self.view.set_table_options(tables)

        self.view.show_button.clicked.connect(self.show_table)
        self.view.matches_button.clicked.connect(self.show_matches)

    def show_table(self):
        table = self.view.table_dropdown.currentText()
        try:
            entries = int(self.view.entries_input.text())
        except ValueError:
            entries = 5
        rows, headers = self.model.show_tables(table, entries)
        self.view.populate_table(self.view.result_table, rows, headers)

    def show_matches(self):
        team_id = self.view.team_input.text().strip()
        if not team_id:
            return
        rows, headers = self.model.get_matches_for_team(team_id)
        self.view.populate_table(self.view.matches_table, rows, headers)

    def run(self):
        self.view.show()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    controller = Controller(DatabaseModel, DatabaseView)
    controller.run()
    sys.exit(app.exec())
