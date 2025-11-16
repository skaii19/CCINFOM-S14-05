import mysql.connector

_connection = None

def get_connection():
    global _connection
    if _connection is None or not _connection.is_connected():
        _connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="vct"
        )
    return _connection

def get_cursor(dictionary=True):
    conn = get_connection()
    return conn.cursor(dictionary=dictionary)
