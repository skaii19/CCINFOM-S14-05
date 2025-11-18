from PySide6.QtWidgets import QApplication
from views.main_window import MainWindow
# from controllers.player_controller import PlayerController
from controllers.team_controller import TeamController
# from controllers.tournament_controller import TournamentController
from controllers.customer_controller import CustomerController
from controller.merchandise_controller import MerchandiseController

# Create the Qt application
app = QApplication([])

# Create the main window (contains all tabs)
mw = MainWindow()

# Connect the Player tab to its controller
# PlayerController(mw.player_tab)

# Connect the Tournament tab to its controller
# tournament_controller = TournamentController(mw.tournaments_tab)

TeamController(mw.teams_tab)

CustomerController(mw.customers_tab)

merchandise_controller = MerchandiseController(mw.merch_tab)

# Show the UI
mw.show()

# Start the event loop
app.exec()
