from PySide6.QtWidgets import QWidget, QVBoxLayout, QLabel, QTextEdit, QTableWidget, QTableWidgetItem, QHeaderView
from PySide6.QtCore import Qt

class TeamDetailsWindow(QWidget):
    def __init__(self, details):
        super().__init__()
        self.setWindowTitle("Team Details")
        self.details = details
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()

        self.setMinimumSize(654, 462)

        # Get detail sections
        basic = self.details["basic"]
        match_history = self.details["match history"]
        team_placements = self.details["team placements"]
        roster = self.details["roster"]

        # Basic info
        layout.addWidget(QLabel(f"Team ID: {basic['team_id'] or 'N/A'}"))
        layout.addWidget(QLabel(f"Name: {basic['team_name'] or 'N/A'}"))

        # Match history section
        layout.addWidget(QLabel("Match History:"))
        match_history_box = QTextEdit()
        match_history_box.setReadOnly(True)

        if match_history:
            for h in match_history:
                tournament = h["tournament_name"]
                bracket = h["bracket"]
                match_up = h["match_up"]
                winner = h["map_winner_team_id"]
                match_history_box.append(f" {tournament :^20} | {bracket :^12} | {match_up :^10} | Winner: {winner :^3}")
        else:
            match_history_box.append("No team placements available.")

        layout.addWidget(match_history_box)

        # Team placements section
        layout.addWidget(QLabel("Team Placements:"))
        placements_box = QTextEdit()
        placements_box.setReadOnly(True)

        if team_placements:
            for p in team_placements:
                tournament = p["tournament_id"]
                placement = p["placement"]
                winnings = p["winnings"]
                placements_box.append(f"Tournament: {tournament :^8} | Placement: {placement :^5} | Winnings: {winnings :^10}")
        else:
            placements_box.append("No team placements available.")

        layout.addWidget(placements_box)

        # Roster section
        layout.addWidget(QLabel("Roster:"))
        roster_box = QTextEdit()
        roster_box.setReadOnly(True)

        if roster:
            for r in roster:
                player_id = r.get("player_id", "N/A")
                player_ign = r.get("player_ign", "N/A")
                roster_box.append(f"[{player_id}] {player_ign}")
        else:
            roster_box.append("No roster available.")

        layout.addWidget(roster_box)

        self.setLayout(layout)