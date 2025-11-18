from PySide6.QtWidgets import QWidget, QVBoxLayout, QLabel, QTextEdit

class MatchesDetailsWindow(QWidget):
    def __init__(self, details):
        super().__init__()
        self.setWindowTitle("Match Details")
        self.details = details
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()

        # Get detail sections
        basic = self.details["basic"]
        team1 = self.details["team1"]
        team2 = self.details["team2"]

        # Basic info
        layout.addWidget(QLabel(f"Tournament: {basic['tournament_name']}"))
        layout.addWidget(QLabel(f"Matchup: {basic['match_up']}"))
        layout.addWidget(QLabel(f"MVP: {basic['mvp']}"))

        # Team 1
        layout.addWidget(QLabel(f"Team 1: {team1['team_name']}"))
        team1_box = QTextEdit()
        team1_box.setReadOnly(True)

        if team1["players"]:
            for p in team1["players"]:
                ign = p["ign"]
                agent = p["agent"]
                kd = p["kd"]
                hs = p["hs"]
                acs = p["acs"]

                team1_box.append(f"{ign}: {agent} | {kd} | {hs}% | {acs}")
        else:
            team1_box.append("No player data available.")

        layout.addWidget(team1_box)

        # Team 2
        layout.addWidget(QLabel(f"Team 2: {team2['team_name']}"))
        team2_box = QTextEdit()
        team2_box.setReadOnly(True)

        if team2["players"]:
            for p in team2["players"]:
                ign = p["ign"]
                agent = p["agent"]
                kd = p["kd"]
                hs = p["hs"]
                acs = p["acs"]

                team2_box.append(f"{ign}: {agent} | {kd} | {hs}% | {acs}")
        else:
            team2_box.append("No player data available.")

        layout.addWidget(team2_box)

        self.setLayout(layout)