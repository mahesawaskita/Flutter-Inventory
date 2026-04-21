const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db'); 

exports.login = (req, res) => {
  const { username, password } = req.body;

  console.log("LOGIN REQUEST:", username, password);

  const sql = "SELECT * FROM users WHERE username = ?";

  db.query(sql, [username], (err, result) => {
    if (err) {
      console.log("DB ERROR:", err);
      return res.status(500).json(err);
    }

    console.log("DB RESULT:", result);

    if (result.length === 0) {
      return res.status(401).json({ message: "User tidak ditemukan" });
    }

    const user = result[0];

    if (user.password !== password) {
      return res.status(401).json({ message: "Password salah" });
    }

    res.json({
      message: "Login berhasil",
      user: user,
    });
  });
};

exports.register = async (req, res) => {
  const { username, password } = req.body;

  const hashedPassword = await bcrypt.hash(password, 10);

  const sql = "INSERT INTO users (username, password) VALUES (?, ?)";

  db.query(sql, [username, hashedPassword], (err, result) => {
    if (err) return res.status(500).json(err);

    res.json({ message: "Register success" });
  });
};