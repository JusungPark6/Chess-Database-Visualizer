from flask import Flask, jsonify, request, render_template
from flaskext.mysql import MySQL
import mysql.connector
import pymysql

app = Flask(__name__)

# DB connection
def get_db_connection():
    connection = pymysql.connect(host='chesss.coxdz1cagmaq.us-east-1.rds.amazonaws.com',
                                 user='admin',
                                 password='password',
                                 db='chess_db',
                                 charset='utf8mb4',
                                 cursorclass=pymysql.cursors.DictCursor)
    return connection

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/players')
def get_players():
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM Players"
            cursor.execute(sql)
            players = cursor.fetchall()
            return jsonify(players=players)
    finally:
        connection.close()

@app.route('/api/games')
def get_games():
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM Game"
            cursor.execute(sql)
            games = cursor.fetchall()
            return jsonify(games=games)
    finally:
        connection.close()

@app.route('/api/game-details')
def get_game_details():
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM Game_details"
            cursor.execute(sql)
            game_details = cursor.fetchall()
            return jsonify(game_details=game_details)
    finally:
        connection.close()

@app.route('/api/execute-query', methods=['POST'])
def execute_query():
    query = request.json.get('query')
    if not query:
        return jsonify({'error': 'No query provided.'})
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute(query)
            results = cursor.fetchall()
            return jsonify(results=results)
    except Exception as e:
        return jsonify({'error': str(e)})
    finally:
        connection.close()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
