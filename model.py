# model.py
import mysql.connector

class DatabaseModel:
    def __init__(self):
        self.db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="DLSU1234!",
            database="vct"
        )
        self.cursor = self.db.cursor()

    def get_available_tables(self):
        self.cursor.execute("SHOW TABLES;")
        return [row[0] for row in self.cursor.fetchall()]

    def show_tables(self, table, limit):
        query = f"SELECT * FROM {table} LIMIT %s;"
        self.cursor.execute(query, (limit,))
        return self.cursor.fetchall(), self.cursor.column_names

    def get_matches_for_team(self, team_id):
        query = """
            SELECT t.team_id, m.tournament_id, m.match_id, m.bracket,
                   CONCAT(m.team1_id, ' vs ', m.team2_id) AS match_up,
                   m.map_winner_team_id
            FROM matches m
            JOIN team t ON t.team_id = m.team1_id OR t.team_id = m.team2_id
            WHERE t.team_id = %s
            ORDER BY m.tournament_id;
        """
        self.cursor.execute(query, (team_id,))
        return self.cursor.fetchall(), self.cursor.column_names
