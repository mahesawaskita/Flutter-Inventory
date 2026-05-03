const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

const JWT_SECRET = process.env.JWT_SECRET || 'rahasia_jwt_inventori';

// Cek apakah string sudah merupakan hash bcrypt
function isBcryptHash(str) {
  return str && (str.startsWith('$2b$') || str.startsWith('$2a$'));
}

// ✅ LOGIN — support plain text lama + bcrypt baru, auto-migrasi otomatis
exports.login = (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username dan password wajib diisi' });
  }

  const sql = 'SELECT * FROM users WHERE username = ?';

  db.query(sql, [username], async (err, result) => {
    if (err) {
      console.log('DB ERROR:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    if (result.length === 0) {
      return res.status(401).json({ message: 'Username tidak ditemukan' });
    }

    const user = result[0];
    let passwordValid = false;

    if (isBcryptHash(user.password)) {
      // Password sudah bcrypt — bandingkan pakai bcrypt.compare
      passwordValid = await bcrypt.compare(password, user.password);
    } else {
      // Password masih plain text (data lama) — bandingkan langsung
      passwordValid = (user.password === password);

      if (passwordValid) {
        // Auto-migrasi: hash password dan update ke database
        const newHash = await bcrypt.hash(password, 10);
        db.query('UPDATE users SET password = ? WHERE id = ?', [newHash, user.id]);
        console.log(`[MIGRASI] Password "${username}" berhasil di-hash otomatis`);
      }
    }

    if (!passwordValid) {
      return res.status(401).json({ message: 'Password salah' });
    }

    // Buat JWT token
    const token = jwt.sign(
      { id: user.id, username: user.username, role: user.role },
      JWT_SECRET,
      { expiresIn: '7d' }
    );

    res.json({
      message: 'Login berhasil',
      token: token,
      role: user.role,
      username: user.username,
    });
  });
};

// ✅ REGISTER — selalu simpan bcrypt, cek duplikat username
exports.register = async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username dan password wajib diisi' });
  }

  db.query('SELECT id FROM users WHERE username = ?', [username], async (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });

    if (result.length > 0) {
      return res.status(400).json({ message: 'Username sudah digunakan' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const sql = 'INSERT INTO users (username, password, role) VALUES (?, ?, ?)';

    db.query(sql, [username, hashedPassword, 'user'], (err2) => {
      if (err2) return res.status(500).json({ message: 'Gagal register' });
      res.json({ message: 'Register berhasil' });
    });
  });
};
