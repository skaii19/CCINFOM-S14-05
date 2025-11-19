from PySide6.QtWidgets import (
    QWidget, QFormLayout, QLineEdit, QComboBox,
    QPushButton, QVBoxLayout, QMessageBox, QDateEdit, QTimeEdit
)
from PySide6.QtCore import Signal, QDate, QTime


class MatchesForm(QWidget):
    # Signal sent when user saves the form
    saved = Signal(dict)

    def __init__(self, tournaments, teams, maps, players_by_team, existing=None):
        super().__init__()
        self.setWindowTitle("Match Form")
        self.tournaments = tournaments
        self.teams = teams
        self.maps = maps
        self.players_by_team = players_by_team
        self.existing = existing
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()
        form = QFormLayout()

        # Input fields
        self.match_id_input = QLineEdit()

        # Date picker
        self.date_input = QDateEdit()
        self.date_input.setCalendarPopup(True)
        self.date_input.setDisplayFormat("yyyy-MM-dd")
        self.date_input.setDate(QDate.currentDate())

        # Time picker
        self.time_input = QTimeEdit()
        self.time_input.setDisplayFormat("HH:mm")
        self.time_input.setTime(QTime.currentTime())

        self.bracket_input = QLineEdit()
        self.score_input = QLineEdit()

        # Tournament dropdown
        self.tourn_select = QComboBox()
        for t in self.tournaments:
            self.tourn_select.addItem(t["tournament_name"], t["tournament_id"])

        # Team dropdowns
        self.team1_select = QComboBox()
        self.team2_select = QComboBox()
        for t in self.teams:
            self.team1_select.addItem(t["team_name"], t["team_id"])
            self.team2_select.addItem(t["team_name"], t["team_id"])

        # Winner dropdown
        self.winner_select = QComboBox()
        self.winner_select.addItem("Select team", None)

        # Map dropdown
        self.map_select = QComboBox()
        for m in self.maps:
            self.map_select.addItem(m["map_name"], m["map_id"])

        # MVP dropdown
        self.mvp_select = QComboBox()
        self.mvp_select.addItem("Select MVP", None)

        # Update dependent dropdowns when teams change
        self.team1_select.currentIndexChanged.connect(self.update_dependent_lists)
        self.team2_select.currentIndexChanged.connect(self.update_dependent_lists)

        # Form rows
        form.addRow("Match ID:", self.match_id_input)
        form.addRow("Tournament:", self.tourn_select)
        form.addRow("Date:", self.date_input)
        form.addRow("Time:", self.time_input)
        form.addRow("Bracket:", self.bracket_input)
        form.addRow("Team 1:", self.team1_select)
        form.addRow("Team 2:", self.team2_select)
        form.addRow("Winning Team:", self.winner_select)
        form.addRow("Map:", self.map_select)
        form.addRow("Score:", self.score_input)
        form.addRow("MVP:", self.mvp_select)

        # Save button
        self.save_btn = QPushButton("Save")
        self.save_btn.clicked.connect(self.on_save)

        layout.addLayout(form)
        layout.addWidget(self.save_btn)
        self.setLayout(layout)

        # Fill fields if editing
        if self.existing:
            self.fill_existing()
        else:
            self.update_dependent_lists()

    def update_dependent_lists(self):
        # Update winner + MVP choices based on selected teams
        team1 = self.team1_select.currentData()
        team2 = self.team2_select.currentData()

        # Winner dropdown
        self.winner_select.clear()
        self.winner_select.addItem("Select team", None)
        if team1:
            self.winner_select.addItem(self.team1_select.currentText(), team1)
        if team2:
            self.winner_select.addItem(self.team2_select.currentText(), team2)

        # MVP dropdown
        self.mvp_select.clear()
        self.mvp_select.addItem("Select MVP", None)

        if team1 in self.players_by_team:
            for p in self.players_by_team[team1]:
                self.mvp_select.addItem(p["player_ign"], p["player_id"])

        if team2 in self.players_by_team:
            for p in self.players_by_team[team2]:
                self.mvp_select.addItem(p["player_ign"], p["player_id"])

    def fill_existing(self):
        # Load existing values into the form
        m = self.existing

        self.match_id_input.setText(str(m["match_id"]))
        self.match_id_input.setEnabled(False)

        idx = self.tourn_select.findData(m["tournament_id"])
        if idx >= 0:
            self.tourn_select.setCurrentIndex(idx)

        # Set date/time fields
        self.date_input.setDate(QDate.fromString(str(m["match_date"]), "yyyy-MM-dd"))
        self.time_input.setTime(QTime.fromString(str(m["match_time"]), "HH:mm"))

        self.bracket_input.setText(m["bracket"])

        idx = self.team1_select.findData(m["team1_id"])
        if idx >= 0:
            self.team1_select.setCurrentIndex(idx)

        idx = self.team2_select.findData(m["team2_id"])
        if idx >= 0:
            self.team2_select.setCurrentIndex(idx)

        # Refresh winner/MVP lists after teams set
        self.update_dependent_lists()

        idx = self.winner_select.findData(m["winning_team"])
        if idx >= 0:
            self.winner_select.setCurrentIndex(idx)

        idx = self.map_select.findData(m["map_played"])
        if idx >= 0:
            self.map_select.setCurrentIndex(idx)

        self.score_input.setText(str(m["score"]))

        idx = self.mvp_select.findData(m["mvp_player_id"])
        if idx >= 0:
            self.mvp_select.setCurrentIndex(idx)

    def on_save(self):
        # Retrieve team selections
        team1 = self.team1_select.currentData()
        team2 = self.team2_select.currentData()
        winner = self.winner_select.currentData()
        mvp = self.mvp_select.currentData()

        # Validate winner
        if winner not in (team1, team2):
            QMessageBox.warning(self, "Error", "Winning team must be Team 1 or Team 2.")
            return

        # Validate MVP (if chosen)
        valid_mvp_ids = []
        if team1 in self.players_by_team:
            valid_mvp_ids += [p["player_id"] for p in self.players_by_team[team1]]
        if team2 in self.players_by_team:
            valid_mvp_ids += [p["player_id"] for p in self.players_by_team[team2]]

        if mvp is not None and mvp not in valid_mvp_ids:
            QMessageBox.warning(self, "Error", "MVP must be from Team 1 or Team 2.")
            return

        # Data returned to controller
        data = {
            "match_id": self.match_id_input.text(),
            "tournament_id": self.tourn_select.currentData(),
            "date": self.date_input.date().toString("yyyy-MM-dd"),
            "time": self.time_input.time().toString("HH:mm"),
            "bracket": self.bracket_input.text(),
            "team1_id": team1,
            "team2_id": team2,
            "winner_team_id": winner,
            "map_id": self.map_select.currentData(),
            "score": self.score_input.text(),
            "mvp_id": mvp
        }

        self.saved.emit(data)
        self.close()