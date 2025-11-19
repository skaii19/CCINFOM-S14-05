from PySide6.QtWidgets import QMainWindow, QTabWidget
from views.player_tab import PlayerTab
from views.teams_tab import TeamsTab
from views.tournaments_tab import TournamentsTab
from views.matches_tab import MatchesTab
from views.customers_tab import CustomersTab
from views.merchandise_tab import MerchandiseTab
from views.reports_tab import ReportsTab


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setMinimumSize(1724, 768)

        # Main tab widget
        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)

        # Create all tabs
        self.player_tab = PlayerTab()
        self.teams_tab = TeamsTab()
        self.tournaments_tab = TournamentsTab()
        self.matches_tab = MatchesTab()
        self.customers_tab = CustomersTab()
        self.merch_tab = MerchandiseTab()
        self.reports_tab = ReportsTab()

        # Add tabs to window
        self.tabs.addTab(self.player_tab, "Players")
        self.tabs.addTab(self.teams_tab, "Teams")
        self.tabs.addTab(self.tournaments_tab, "Tournaments")
        self.tabs.addTab(self.matches_tab, "Matches")
        self.tabs.addTab(self.customers_tab, "Customers")
        self.tabs.addTab(self.merch_tab, "Merchandise")
        self.tabs.addTab(self.reports_tab, "Reports")