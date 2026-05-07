const mysql = require('mysql');

const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'keep_tel'
});

db.connect((err) => {
  if (err) {
    console.log('Database error:', err);
  } else {
    console.log('Database connected');
  }
});

module.exports = db;