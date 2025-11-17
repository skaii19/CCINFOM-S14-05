from PySide6.QtWidgets import QWidget, QVBoxLayout, QLabel, QTextEdit

class PlayerDetailsWindow(QWidget):
    def __init__(self, details):
        super().__init__()
        self.setWindowTitle("Player Details")
        self.details = details
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout()

        # Get detail sections
        basic = self.details["basic"]
        stats = self.details["stats"]
        history = self.details["history"]
        agents = self.details["agents"]
        mvps = self.details["mvps"]

        # Basic info
        layout.addWidget(QLabel(f"IGN: {basic['player_ign']}"))
        layout.addWidget(QLabel(f"Name: {basic['player_name']}"))

        # Stats section
        layout.addWidget(QLabel("Stats:"))

        if stats:
            layout.addWidget(QLabel(f"KD Ratio: {stats['kd_ratio'] or 'N/A'}"))
            layout.addWidget(QLabel(f"Headshot %: {stats['headshot_pct'] or 'N/A'}"))
            layout.addWidget(QLabel(f"ACS: {stats['avg_combat_score'] or 'N/A'}"))
        else:
            layout.addWidget(QLabel("KD Ratio: N/A"))
            layout.addWidget(QLabel("Headshot %: N/A"))
            layout.addWidget(QLabel("ACS: N/A"))

        # Team history section
        layout.addWidget(QLabel("Team History:"))
        hist_box = QTextEdit()
        hist_box.setReadOnly(True)

        if history:
            for h in history:
                team = h["team_name"]
                start = h["start_date"]
                end = h["end_date"] or "Present"
                hist_box.append(f"{team} | {start} - {end}")
        else:
            hist_box.append("No team history available.")

        layout.addWidget(hist_box)

        # Agents section
        layout.addWidget(QLabel("Agents Used:"))
        agent_box = QTextEdit()
        agent_box.setReadOnly(True)

        if agents:
            for a in agents:
                agent_box.append(a["agent_name"])
        else:
            agent_box.append("No agent data available.")

        layout.addWidget(agent_box)

        # MVP count
        mvp_count = mvps["mvp_count"] if mvps else 0
        layout.addWidget(QLabel(f"MVP Count: {mvp_count}"))

        self.setLayout(layout)