from datetime import date, timedelta
from PySide6.QtWidgets import QMessageBox

from models.player_model import PlayerModel
from models.player_details_model import PlayerDetailsModel
from models.team_history_model import TeamHistoryModel

from views.player_form import PlayerForm
from views.player_details_window import PlayerDetailsWindow

class PlayerController:

    def __init__(self, view):
        self.view = view

        # Models
        self.player_model = PlayerModel()
        self.details_model = PlayerDetailsModel()
        self.history_model = TeamHistoryModel()

        # Prevent garbage collection of windows/forms
        self.forms = []
        self.details_windows = []

        # Connect signals
        self.view.add_clicked.connect(self.add_player)
        self.view.edit_clicked.connect(self.edit_player)
        self.view.delete_clicked.connect(self.delete_player)
        self.view.row_double_clicked.connect(lambda pid: self.show_player_details(pid))

        # Search/filter signals
        view.search_changed.connect(self.apply_filters)
        view.team_filter_changed.connect(self.apply_filters)
        view.active_filter_changed.connect(self.apply_filters)

        # Load initial table
        self.load_table()

        # Load teams into filter dropdown
        teams = self.player_model.get_teams()
        self.view.load_team_filter(teams)


# Load table
    def load_table(self):
        players = self.player_model.load_players()
        self.view.fill(players)

    # Search and Filter
    def apply_filters(self, *args):
        search = self.view.search_box.text().strip().lower()
        team = self.view.team_filter.currentData()
        status = self.view.status_filter.currentData()

        players = self.player_model.load_players()

        filtered = []
        for p in players:

            # Search filter
            if search:
                if search not in p["player_ign"].lower() and search not in p["player_name"].lower():
                    continue

            # Team filter
            if team and p["team_id"] != team:
                continue

            # Active filter
            if status and p["active_status"][0] != status:   # Yes/No → Y/N
                continue

            filtered.append(p)

        self.view.fill(filtered)


    # Add Player
    def add_player(self):
        teams = self.player_model.get_teams()
        form = PlayerForm(teams)
        form.saved.connect(self.save_new_player)
        form.show()
        self.forms.append(form)

    def save_new_player(self, data):
        # Insert player
        new_id = self.player_model.add_player(data["ign"], data["name"], data["team_id"], "Y")

        # Create team history record
        self.history_model.add_history(new_id, data["team_id"], date.today())

        self.load_table()

    # Edit Player
    def edit_player(self, player_id):
        player = self.player_model.get_player(player_id)
        teams = self.player_model.get_teams()

        form = PlayerForm(teams, existing=player)
        form.saved.connect(lambda data: self.save_edit_player(player_id, player, data))
        form.show()
        self.forms.append(form)

    def save_edit_player(self, pid, old, new):
        today = date.today()
        old_team = old["team_id"]
        new_team = new["team_id"]
        old_status = old["active_status"]
        new_status = new["active"]

        # Leaving team
        if old_team and not new_team:
            self.history_model.close_current_history(pid, today)
            new_status = "N"

        # Joining team
        if not old_team and new_team:
            self.history_model.add_history(pid, new_team, today)
            new_status = "Y"

        # Switching team
        if old_team and new_team and old_team != new_team:
            self.history_model.close_current_history(pid, today - timedelta(days=1))
            self.history_model.add_history(pid, new_team, today)
            new_status = "Y"

        # Inactive to Active
        if old_status == "N" and new_status == "Y":
            if not new_team:
                QMessageBox.warning(None, "Error", "Active players must have a team.")
                return
            self.history_model.add_history(pid, new_team, today)

        # Active to Inactive
        if old_status == "Y" and new_status == "N":
            self.history_model.close_current_history(pid, today)
            new_team = None

        # Update DB
        self.player_model.update_player(
            pid,
            new["ign"],
            new["name"],
            new_team,
            new_status
        )

        self.load_table()

    # Delete Player
    def delete_player(self, player_id):

        stats = self.player_model.count_stats(player_id)
        picks = self.player_model.count_agent_picks(player_id)
        mvps = self.player_model.count_mvp_refs(player_id)
        history = len(self.history_model.load_history(player_id))

        if stats > 0 or picks > 0 or mvps > 0 or history > 1:
            QMessageBox.warning(None, "Error", "Cannot delete: related records exist.")
            return

        self.player_model.delete_player(player_id)
        self.load_table()

    # Show Details
    def show_player_details(self, player_id):
        details = {
            "basic": self.details_model.get_basic_info(player_id),
            "stats": self.details_model.get_aggregated_stats(player_id),
            "history": self.details_model.get_team_history(player_id),
            "agents": self.details_model.get_agent_picks(player_id),
            "mvps": self.details_model.get_mvp_count(player_id)
        }

        window = PlayerDetailsWindow(details)
        window.show()
        self.details_windows.append(window)
