from PySide6.QtWidgets import QTableWidgetItem, QMessageBox
from PySide6.QtCore import QDate, Qt  
from models.reports_model import ReportsModel  
from models.tournament_model import TournamentModel
from datetime import datetime, date

class ReportController:
    def __init__(self, view):
        self.view = view
        self.view.controller = self


        self.reports_model = ReportsModel()
        self.tournament_model = TournamentModel()

        self.load_tournaments()

        # Connect buttons
        self.view.generate_btn.clicked.connect(self.generate_report)
        self.view.tournament_filter.currentIndexChanged.connect(self.update_tournament_days)
        self.view.clear_btn.clicked.connect(self.clear_filters)

        self.view.report_type.currentTextChanged.connect(self.load_tournaments)
        

    def load_tournaments(self):
        tournaments = self.tournament_model.load_tournaments() 

        # Tournament Revenue filter
        if hasattr(self.view, 'tournament_filter'):
            self.view.tournament_filter.clear()
            self.view.tournament_filter.addItem("All", None)
            for t in tournaments:
                self.view.tournament_filter.addItem(t['tournament_name'], t['tournament_id'])

        # Tournament Statistics filter
        if hasattr(self.view, 'stat_tournament_filter'):
            self.view.stat_tournament_filter.clear()
            self.view.stat_tournament_filter.addItem("All", None)
            for t in tournaments:
                self.view.stat_tournament_filter.addItem(t['tournament_name'], t['tournament_id'])

    def update_stat_tournament_days(self):
        selected_index = self.view.stat_tournament_filter.currentIndex()
        tournament_id = self.view.stat_tournament_filter.itemData(selected_index)
        
        self.view.stat_tournament_day_filter.clear()
        self.view.stat_tournament_day_filter.addItem("All", None) 
        
        if tournament_id:
            dates = self.tournament_model.get_tournament_days(tournament_id)
            for d in dates:
                self.view.stat_tournament_day_filter.addItem(d.strftime("%B %d, %Y"), d)
            self.view.stat_year_filter.hide()  # hide year if tournament selected
        else:
            self.view.stat_year_filter.show()

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
        report_type = self.view.report_type.currentText()

        if report_type == "Tournament Revenue":
            # Existing logic (unchanged)
            tournament_index = self.view.tournament_filter.currentIndex()
            tournament_id = self.view.tournament_filter.itemData(tournament_index)

            day_text = self.view.tournament_day_filter.currentText()
            day = None if day_text == "All" else day_text

            year_text = self.view.year_filter.currentText()
            year = None if year_text == "All" else int(year_text)

            if tournament_id and day:
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
                data = self.reports_model.revenue_tournament(tournament_id)
                columns = ["Tournament ID", "Tournament Name", "Tournament Type", "Total Ticket Sales"]
                key_map = {
                    "Tournament ID": "tournament_id",
                    "Tournament Name": "tournament_name",
                    "Tournament Type": "tournament_type",
                    "Total Ticket Sales": "total_ticket_sales"
                }
            elif year and not tournament_id:
                data = self.reports_model.revenue_year(year)
                columns = ["Year", "Total Ticket Sales"]
                key_map = {
                    "Year": "tourn_year",
                    "Total Ticket Sales": "total_ticket_sales"
                }
            else:
                data = self.reports_model.average_per_tournament()
                columns = ["Tournament ID", "Tournament Name", "Tournament Type", "Average Ticket Sales"]
                key_map = {
                    "Tournament ID": "tournament_id",
                    "Tournament Name": "tournament_name",
                    "Tournament Type": "tournament_type",
                    "Average Ticket Sales": "average_ticket_sales"
                }

            self.load_table(data, columns, key_map)

        elif report_type == "Tournament Statistics":
            stat_tournament_index = self.view.stat_tournament_filter.currentIndex()
            stat_tournament_id = self.view.stat_tournament_filter.itemData(stat_tournament_index)

            stat_day_text = self.view.stat_tournament_day_filter.currentText()
            stat_day = self.view.stat_tournament_day_filter.currentData() 
            stat_year = int(self.view.stat_year_filter.currentText())

            table = self.view.table
            table.setRowCount(0)  # clear table
            table.horizontalHeader().hide()

            if stat_tournament_id and stat_day:
                agent_data = self.reports_model.agent_picks(stat_tournament_id, stat_day)
                team_data = self.reports_model.team_winrate(stat_tournament_id, stat_day)
            elif stat_tournament_id:
                agent_data = self.reports_model.agent_picks(stat_tournament_id)
                team_data = self.reports_model.team_winrate(stat_tournament_id)
            elif stat_year:
                agent_data = self.reports_model.agent_picks_year(stat_year)
                team_data = self.reports_model.team_winrate_year(stat_year)
            else:
                agent_data = []
                team_data = []

            # Debug
            print("AGENT DATA:", agent_data)
            print("TEAM DATA:", team_data)

            # Append sections individually
            if agent_data:
                self._append_stat_section(
                    table,
                    "Agent Picks",
                    agent_data,
                    ["Agent ID", "Agent Name", "Total Picks", "Average Pick Rate %"],
                    {
                        "Agent ID": "agent_id",
                        "Agent Name": "agent_name",
                        "Total Picks": "total_picks",
                        "Average Pick Rate %": "average_pick_rate_pct"
                    }
                )


            if team_data:
                self._append_stat_section(
                    table,
                    "Team Win Rates",
                    team_data,
                    ["Team ID", "Team Name", "Total Wins", "Win Rate %"],
                    {
                        "Team ID": "team_id",
                        "Team Name": "team_name",
                        "Total Wins": "total_wins",
                        "Win Rate %": "win_rate_pct"
                    }
                )



        else:
            QMessageBox.warning(self.view, "Unknown Report Type", f"Report type '{report_type}' is not recognized.")

    def _append_stat_section(self, table, header_name, data, columns, key_map):
        if not data:
            return
        
        table.setColumnCount(len(columns))

        # Add header row for this section
        start_row = table.rowCount()
        table.insertRow(start_row)
        header_item = QTableWidgetItem(f"--- {header_name} ---")
        header_item.setBackground(Qt.gray)
        header_item.setForeground(Qt.white)
        header_item.setTextAlignment(Qt.AlignCenter)
        table.setItem(start_row, 0, header_item)
        table.setSpan(start_row, 0, 1, len(columns))

        # Add column labels
        start_row += 1
        table.insertRow(start_row)
        for col_index, col_name in enumerate(columns):
            table.setItem(start_row, col_index, QTableWidgetItem(col_name))

        # Add data rows
        for row_data in data:
            start_row += 1
            table.insertRow(start_row)
            values = [row_data.get(key_map[col], "") for col in columns]
            for col_index, value in enumerate(values):
                # Format percentages
                if "%" in columns[col_index] and value not in (None, ""):
                    try:
                        value = f"{float(value):.2f}%"
                    except ValueError:
                        pass
                item = QTableWidgetItem(str(value))
                table.setItem(start_row, col_index, item)

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
                if "Sales" in columns[col_index] or "Revenue" in columns[col_index] and value not in (None, ""):
                    try:
                        value = f"${float(value):,.2f}"
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
            
        if hasattr(self.view, 'stat_tournament_filter'):
            self.view.stat_tournament_filter.setCurrentIndex(0)
        if hasattr(self.view, 'stat_tournament_day_filter'):
            self.view.stat_tournament_day_filter.setCurrentIndex(0)
        if hasattr(self.view, 'stat_year_filter'):
            self.view.stat_year_filter.setCurrentText(str(QDate.currentDate().year()))
            
        self.view.table.setRowCount(0)

