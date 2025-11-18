import mysql.connector

# Global connection instance (reused by all queries)
_connection = None

def get_connection():
    global _connection

    # Create a new connection if none exists or if it was dropped
    if _connection is None or not _connection.is_connected():
        _connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="DLSU1234!",
            database="vct"
        )

    # Return active MySQL connection
    return _connection


def get_cursor(dictionary=True):
    # Always get an active DB connection
    conn = get_connection()

    # Return a cursor; dictionary=True returns rows as dicts instead of tuples
    return conn.cursor(dictionary=dictionary)
