from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

def init_db():
    conn = sqlite3.connect('data.db')
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS requests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        data = request.form.get('data', '')
        conn = sqlite3.connect('data.db')
        c = conn.cursor()
        c.execute('INSERT INTO requests (data) VALUES (?)', (data,))
        conn.commit()
        conn.close()
        return jsonify({'status': 'success'}), 201
    return '''
        <html>
            <body>
                <form action="/" method="post">
                    <input type="text" name="data">
                    <input type="submit" value="Submit">
                </form>
            </body>
        </html>
    '''

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5001)