from PySide6.QtWidgets import QMessageBox

from models.matches_model import MatchesModel
from models.matches_details_model import MatchesDetailsModel

from views.matches_form import MatchesForm
from views.matches_details_window import MatchesDetailsWindow
from views.player_stats_form import PlayerStatsForm


class MatchesController:

    def __init__(self, view):
        self.view = view

        # Models
        self.match_model = MatchesModel()
        self.details_model = MatchesDetailsModel()

        # Prevent GC of windows/forms
        self.forms = []
        self.details_windows = []

        # Load table + filters before enabling signals
        self.load_table()
        self.load_filters()

        # Now it is safe to enable UI signals
        self.enable_signals()

    def enable_signals(self):
        # Enable search box and filter signals now that data exists
        self.view.search_box.blockSignals(False)
        self.view.tournament_filter.blockSignals(False)
        self.view.year_filter.blockSignals(False)

        # Table actions
        self.view.add_clicked.connect(self.add_match)
        self.view.edit_clicked.connect(self.edit_match)
        self.view.row_double_clicked.connect(lambda mid: self.show_match_details(mid))

        # Filters
        self.view.search_changed.connect(self.apply_filters)
        self.view.tournament_filter_changed.connect(self.apply_filters)
        self.view.year_filter_changed.connect(self.apply_filters)

    # Load match list
    def load_table(self):
        matches = self.match_model.load_matches()
        self.view.fill(matches)

    # Load dropdown filters
    def load_filters(self):
        tournaments = self.match_model.get_tournaments()
        years = self.match_model.get_years()

        self.view.load_tournament_filter(tournaments)
        self.view.load_year_filter(years)

    # Search and filter
    def apply_filters(self, *args):
        search = self.view.search_box.text().strip().lower()
        tournament_id = self.view.tournament_filter.currentData()
        year = self.view.year_filter.currentData()

        matches = self.match_model.load_matches()
        filtered = []

        for m in matches:
            # Search (matchup)
            if search:
                if search not in str(m["match_up"]).lower():
                    continue

            # Tournament filter
            if tournament_id and m["tournament_id"] != tournament_id:
                continue

            # Year filter
            if year != 0:
                md = m["match_date"]
                match_year = md.year if hasattr(md, "year") else int(str(md)[:4])
                if match_year != year:
                    continue

            filtered.append(m)

        self.view.fill(filtered)

    # Add match
    def add_match(self):
        tournaments = self.match_model.get_tournaments()
        teams = self.match_model.get_teams()
        maps = self.match_model.get_maps()
        players_by_team = self.match_model.get_players_grouped_by_team()

        form = MatchesForm(tournaments, teams, maps, players_by_team)
        form.saved.connect(self.save_new_match)
        form.show()
        self.forms.append(form)

    def save_new_match(self, data):
        # Insert match
        try:
            self.match_model.add_match(
                data["match_id"],
                data["tournament_id"],
                data["date"],
                data["time"],
                data["bracket"],
                data["team1_id"],
                data["team2_id"],
                data["winner_team_id"],
                data["map_id"],
                data["score"],
                data["mvp_id"]
            )
        except Exception as e:
            QMessageBox.warning(None, "Error", f"Error adding match: {e}")
            return

        # Load players for stats & agent selection
        players = self.match_model.get_players_from_two_teams(
            data["team1_id"],
            data["team2_id"]
        )

        agents = self.match_model.get_agents()

        # Open combined stats + agent form
        stats_form = PlayerStatsForm(players, agents)
        stats_form.saved.connect(
            lambda stats: self.save_stats_and_agents(data["match_id"], stats)
        )
        stats_form.show()
        self.forms.append(stats_form)

        self.load_table()

    def save_stats_and_agents(self, match_id, stats):
        # Save each player's stats and agent pick
        for s in stats:
            # Stats
            self.match_model.add_player_stats(
                match_id,
                s["player_id"],
                s["kd"],
                s["hs"],
                s["acs"]
            )

            # Agent pick
            self.match_model.add_agent_pick(
                match_id,
                s["player_id"],
                s["agent_id"]
            )

    # Edit match
    def edit_match(self, match_id):
        match = self.match_model.get_match(match_id)
        if not match:
            QMessageBox.warning(None, "Error", "Match not found.")
            return

        tournaments = self.match_model.get_tournaments()
        teams = self.match_model.get_teams()
        maps = self.match_model.get_maps()
        players_by_team = self.match_model.get_players_grouped_by_team()

        form = MatchesForm(tournaments, teams, maps, players_by_team, existing=match)
        form.saved.connect(lambda data: self.save_edit_match(match_id, data))
        form.show()
        self.forms.append(form)

    def save_edit_match(self, match_id, data):
        # Update match
        try:
            self.match_model.update_match(
                match_id,
                data["tournament_id"],
                data["date"],
                data["time"],
                data["bracket"],
                data["team1_id"],
                data["team2_id"],
                data["winner_team_id"],
                data["map_id"],
                data["score"],
                data["mvp_id"]
            )
        except Exception as e:
            QMessageBox.warning(None, "Error", f"Error updating match: {e}")
            return

        self.load_table()

    # Show match details
    def show_match_details(self, match_id):
        details = {
            "basic": self.details_model.get_basic_info(match_id),
            "team1": self.details_model.get_team1_details(match_id),
            "team2": self.details_model.get_team2_details(match_id)
        }

        window = MatchesDetailsWindow(details)
        window.show()
        self.details_windows.append(window)