const mysql = require('mysql');

const db = mysql.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'keep_tel',
  connectionLimit: 10,
});

db.getConnection((err, connection) => {
  if (err) {
    console.log('Database error:', err);
  } else {
    console.log('Database connected');
    connection.release();
  }
});

module.exports = db;