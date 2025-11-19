from PySide6.QtWidgets import QMessageBox
from models.team_model import TeamModel
from views.team_form import TeamForm
from views.team_details_window import TeamDetailsWindow

class TeamController:

    def __init__(self, view):
        self.view = view

        # Models
        self.team_model = TeamModel()

        # Prevent garbage collection of forms
        self.forms = []
        self.details_windows = []

        # Connect signals from the view
        self.view.add_clicked.connect(self.add_team)
        self.view.edit_clicked.connect(self.edit_team)
        self.view.delete_clicked.connect(self.delete_team)
        self.view.row_double_clicked.connect(lambda team_id: self.show_team_details(team_id))

        view.search_changed.connect(self.apply_filters)
        view.region_filter_changed.connect(self.apply_filters)
        view.active_filter_changed.connect(self.apply_filters)

        # Load initial table
        self.load_table()
        regions = self.team_model.get_regions()
        self.view.load_region_filter(regions)

    def load_table(self) :
        teams = self.team_model.load_teams()
        self.view.fill(teams)

    def apply_filters(self, *args):
        search = self.view.search_box.text().strip().lower()
        region = self.view.region_filter.currentText()
        status = self.view.status_filter.currentData()

        teams = self.team_model.load_teams()

        filtered = []
        for t in teams:

            # Search filter
            if search:
                if search not in t["team_id"].lower() and search not in t["team_name"].lower():
                    continue

            # Region filter
            if region != "All" and t["region"] != region:
                continue

            # Active filter
            if status and t["active_status"] != status:   # Yes/No → Y/N
                continue

            filtered.append(t)

        self.view.fill(filtered)


    def add_team(self):
        regions = self.team_model.get_regions()
        if not regions :
            QMessageBox.warning(None, "Error", "No regions available. Please check the database connection.")
            return
    
        form = TeamForm(regions)
        form.saved.connect(self.save_new_team)
        form.show()
        self.forms.append(form)

    def save_new_team(self, data):
        # Insert team
        self.team_model.add_team(data["team_id"], data["team_name"], data["region"], data["total_winnings"], "Y")

        self.load_table()

    # Edit Team
    def edit_team(self, team_id):
        team = self.team_model.get_team(team_id)
        regions = self.team_model.get_regions()

        form = TeamForm(regions, existing=team)
        form.saved.connect(lambda data: self.save_edit_team(data))
        form.show()
        self.forms.append(form)

    def save_edit_team(self, new):
        self.team_model.update_team(new["team_id"], new["team_name"], new["region"], new["total_winnings"], new["active_status"])
        self.load_table()

    # Delete Team
    def delete_team(self, team_id):

        placements = self.team_model.get_team_placements(team_id)

        if placements :
            QMessageBox.warning(None, "Error", "Cannot delete: related records exist.")
            return
            
        self.team_model.delete_team(team_id)
        self.load_table()

    # Show Details
    def show_team_details(self, team_id):
        basic = self.team_model.get_team(team_id)
    
        details = {
            "basic" : basic,
            "match history" : self.team_model.get_team_match_history(team_id),
            "team placements" : self.team_model.get_team_placements(team_id),
            "roster" : self.team_model.get_team_roster(team_id)
        }

        window = TeamDetailsWindow(details)
        window.show()
        self.details_windows.append(window)
