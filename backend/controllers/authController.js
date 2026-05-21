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

// ✅ GET PROFILE — profil user yang sedang login
exports.getMe = (req, res) => {
  const userId = req.user.id;
  db.query(
    'SELECT id, username, role, email, phone, jabatan, created_at FROM users WHERE id = ?',
    [userId],
    (err, result) => {
      if (err) return res.status(500).json({ message: 'Server error' });
      if (result.length === 0) return res.status(404).json({ message: 'User tidak ditemukan' });
      res.json(result[0]);
    }
  );
};

// ✅ UPDATE PROFILE — ubah email, phone, jabatan, username
exports.updateMe = (req, res) => {
  const userId = req.user.id;
  const { email, phone, jabatan, username } = req.body;

  if (username && username.trim() === '') {
    return res.status(400).json({ message: 'Username tidak boleh kosong' });
  }

  db.query(
    'UPDATE users SET email = ?, phone = ?, jabatan = ?, username = ? WHERE id = ?',
    [email || null, phone || null, jabatan || null, username || null, userId],
    (err) => {
      if (err) {
        if (err.code === 'ER_DUP_ENTRY') {
          return res.status(400).json({ message: 'Username sudah digunakan' });
        }
        return res.status(500).json({ message: 'Gagal update profil' });
      }
      res.json({ message: 'Profil berhasil diupdate' });
    }
  );
};

// ✅ CHANGE PASSWORD
exports.changePassword = async (req, res) => {
  const userId = req.user.id;
  const { oldPassword, newPassword } = req.body;

  if (!oldPassword || !newPassword) {
    return res.status(400).json({ message: 'Password lama dan baru wajib diisi' });
  }
  if (newPassword.length < 4) {
    return res.status(400).json({ message: 'Password baru minimal 4 karakter' });
  }

  db.query('SELECT password FROM users WHERE id = ?', [userId], async (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.length === 0) return res.status(404).json({ message: 'User tidak ditemukan' });

    const user = result[0];
    let valid = false;
    if (isBcryptHash(user.password)) {
      valid = await bcrypt.compare(oldPassword, user.password);
    } else {
      valid = user.password === oldPassword;
    }

    if (!valid) return res.status(400).json({ message: 'Password lama salah' });

    const hashed = await bcrypt.hash(newPassword, 10);
    db.query('UPDATE users SET password = ? WHERE id = ?', [hashed, userId], (err2) => {
      if (err2) return res.status(500).json({ message: 'Gagal ganti password' });
      res.json({ message: 'Password berhasil diubah' });
    });
  });
};

// ✅ REGISTER ADMIN — hanya bisa dipakai jika belum ada admin sama sekali
exports.registerAdmin = async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username dan password wajib diisi' });
  }

  db.query('SELECT id FROM users WHERE role = ?', ['admin'], async (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });

    if (result.length > 0) {
      return res.status(403).json({ message: 'Admin sudah ada, tidak bisa mendaftar lagi' });
    }

    db.query('SELECT id FROM users WHERE username = ?', [username], async (err2, result2) => {
      if (err2) return res.status(500).json({ message: 'Server error' });

      if (result2.length > 0) {
        return res.status(400).json({ message: 'Username sudah digunakan' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      const sql = 'INSERT INTO users (username, password, role) VALUES (?, ?, ?)';

      db.query(sql, [username, hashedPassword, 'admin'], (err3) => {
        if (err3) return res.status(500).json({ message: 'Gagal register admin' });
        res.json({ message: 'Register admin berhasil' });
      });
    });
  });
};