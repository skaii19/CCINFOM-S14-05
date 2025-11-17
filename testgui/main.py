from PySide6.QtWidgets import QApplication
from views.main_window import MainWindow
from controllers.player_controller import PlayerController

# Create the Qt application
app = QApplication([])

# Create the main window (contains all tabs)
mw = MainWindow()

# Connect the Player tab to its controller
PlayerController(mw.player_tab)

# Show the UI
mw.show()

# Start the event loop
app.exec()