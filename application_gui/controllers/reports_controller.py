from PySide6.QtWidgets import QTableWidgetItem
from PySide6.QtCore import QDate
from models.reports_model import ReportsModel  
from models.tournament_model import TournamentModel
from datetime import datetime, date

class ReportController:
    def __init__(self, view):
        self.view = view

        self.reports_model = ReportsModel()
        self.tournament_model = TournamentModel()

        self.load_tournaments()

        # Connect buttons
        self.view.generate_btn.clicked.connect(self.generate_report)
        self.view.tournament_filter.currentIndexChanged.connect(self.update_tournament_days)
        self.view.clear_btn.clicked.connect(self.clear_filters)

    def load_tournaments(self):
        tournaments = self.tournament_model.load_tournaments() 
        for t in tournaments:
            t_id = t['tournament_id']
            t_name = t['tournament_name']
            self.view.tournament_filter.addItem(t_name, t_id)

    def update_tournament_days(self):
        selected_index = self.view.tournament_filter.currentIndex()
        tournament_id = self.view.tournament_filter.itemData(selected_index)

        # clear previous days
        self.view.tournament_day_filter.clear()
        self.view.tournament_day_filter.addItem("All")

        if tournament_id:
            self.view.year_filter.hide()
        else:
            self.view.year_filter.show()

        # unique dates for this tournament
        dates = self.tournament_model.get_tournament_days(tournament_id)
        for d in dates:
            self.view.tournament_day_filter.addItem(d.strftime("%B %d, %Y"))

        self.view.tournament_day_filter.setCurrentIndex(0)

    def generate_report(self):
        tournament_index = self.view.tournament_filter.currentIndex()
        tournament_id = self.view.tournament_filter.itemData(tournament_index)

        day_text = self.view.tournament_day_filter.currentText()
        day = None if day_text == "All" else day_text

        year_text = self.view.year_filter.currentText()
        year = None if year_text == "All" else int(year_text)

        # Determine which report to run
        if tournament_id and day:
            # Tournament + specific day
            day_obj = datetime.strptime(day, "%B %d, %Y").date()
            data = self.reports_model.revenue_tournament_day(tournament_id, day_obj)
            columns = ["Tournament ID", "Tournament Name", "Tournament Type", "Date", "Total Ticket Sales"]
            key_map = {
                "Tournament ID": "tournament_id",
                "Tournament Name": "tournament_name",
                "Tournament Type": "tournament_type",
                "Date": "date_of_ticket",
                "Total Ticket Sales": "total_ticket_sales"
            }

        elif tournament_id and not day:
            # Tournament + whole event
            data = self.reports_model.revenue_tournament(tournament_id)
            columns = ["Tournament ID", "Tournament Name", "Tournament Type", "Total Ticket Sales"]
            key_map = {
                "Tournament ID": "tournament_id",
                "Tournament Name": "tournament_name",
                "Tournament Type": "tournament_type",
                "Total Ticket Sales": "total_ticket_sales"
            }

        elif year and not tournament_id:
            # Whole year, all tournaments
            data = self.reports_model.revenue_year(year)
            columns = ["Year", "Total Ticket Sales"]
            key_map = {
                "Year": "tourn_year",
                "Total Ticket Sales": "total_ticket_sales"
            }

        else:
            # Default: all tournaments average
            data = self.reports_model.average_per_tournament()
            columns = ["Tournament ID", "Tournament Name", "Tournament Type", "Average Ticket Sales"]
            key_map = {
                "Tournament ID": "tournament_id",
                "Tournament Name": "tournament_name",
                "Tournament Type": "tournament_type",
                "Average Ticket Sales": "average_ticket_sales"
            }

        self.load_table(data, columns, key_map)

    def load_table(self, rows, columns, key_map=None):
        table = self.view.table
        table.setRowCount(0)
        table.setColumnCount(len(columns))
        table.setHorizontalHeaderLabels(columns)

        for row_data in rows:
            row_index = table.rowCount()
            table.insertRow(row_index)

            if isinstance(row_data, dict) and key_map:
                values = [row_data.get(key_map[col], "") for col in columns]
            else:
                values = row_data

            for col_index, value in enumerate(values):
                # Format sales columns
                if "Sales" in columns[col_index] and value not in (None, ""):
                    try:
                        value = f"${float(value):,.2f}"  # $1,234.00
                    except ValueError:
                        pass

                # Format date columns
                if "Date" in columns[col_index] and value not in (None, ""):
                    if isinstance(value, (date, datetime)):
                        value = value.strftime("%B %d, %Y")
                    else:
                        try:
                            dt = datetime.strptime(str(value), "%Y-%m-%d")
                            value = dt.strftime("%B %d, %Y")
                        except ValueError:
                            pass

                item = QTableWidgetItem(str(value))
                table.setItem(row_index, col_index, item)

    def clear_filters(self):
        if hasattr(self.view, 'tournament_filter'):
            self.view.tournament_filter.setCurrentIndex(0)
        if hasattr(self.view, 'tournament_day_filter'):
            self.view.tournament_day_filter.setCurrentIndex(0)
        if hasattr(self.view, 'year_filter'):
            self.view.year_filter.setCurrentText(str(QDate.currentDate().year()))
        self.view.table.setRowCount(0)

