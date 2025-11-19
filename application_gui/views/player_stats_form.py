from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QGridLayout, QLabel, QComboBox,
    QLineEdit, QPushButton, QScrollArea
)
from PySide6.QtCore import Signal

class PlayerStatsForm(QWidget):
    # Signal emitted when user saves stats & agent picks
    saved = Signal(list)

    def __init__(self, players, agents):
        super().__init__()
        self.setWindowTitle("Player Stats & Agents")
        self.players = players
        self.agents = agents
        self.inputs = {}
        self.setup_ui()

    def setup_ui(self):
        outer_layout = QVBoxLayout()

        # Scroll area for many players
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)

        widget = QWidget()
        grid = QGridLayout()
        widget.setLayout(grid)

        # ---- Header row ----
        header_style = "font-weight: bold; font-size: 14px;"
        grid.addWidget(self._header_label("IGN"), 0, 0)
        grid.addWidget(self._header_label("Agent"), 0, 1)
        grid.addWidget(self._header_label("K/D"), 0, 2)
        grid.addWidget(self._header_label("HS%"), 0, 3)
        grid.addWidget(self._header_label("ACS"), 0, 4)

        # ---- Player rows ----
        row = 1
        for p in self.players:
            pid = p["player_id"]

            # IGN label (not editable)
            ign_label = QLabel(p["player_ign"])

            # Agent dropdown
            agent_box = QComboBox()
            for a in self.agents:
                agent_box.addItem(a["agent_name"], a["agent_id"])

            # Stat inputs
            kd_input = QLineEdit()
            hs_input = QLineEdit()
            acs_input = QLineEdit()

            # Track fields
            self.inputs[pid] = {
                "ign": p["player_ign"],
                "agent": agent_box,
                "kd": kd_input,
                "hs": hs_input,
                "acs": acs_input
            }

            # Add to grid
            grid.addWidget(ign_label, row, 0)
            grid.addWidget(agent_box, row, 1)
            grid.addWidget(kd_input, row, 2)
            grid.addWidget(hs_input, row, 3)
            grid.addWidget(acs_input, row, 4)

            row += 1

        scroll.setWidget(widget)
        outer_layout.addWidget(scroll)

        # ---- Save All Button ----
        save_btn = QPushButton("Save All")
        save_btn.clicked.connect(self.on_save)
        outer_layout.addWidget(save_btn)

        self.setLayout(outer_layout)

    # Helper to format header labels
    def _header_label(self, text):
        lbl = QLabel(text)
        lbl.setStyleSheet("font-weight: bold; font-size: 14px;")
        return lbl

    # On save, collect all data and emit it
    def on_save(self):
        result = []

        for pid, fields in self.inputs.items():
            result.append({
                "player_id": pid,
                "agent_id": fields["agent"].currentData(),
                "kd": fields["kd"].text(),
                "hs": fields["hs"].text(),
                "acs": fields["acs"].text()
            })

        self.saved.emit(result)
        self.close()