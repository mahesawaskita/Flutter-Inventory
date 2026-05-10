const db = require('../config/db');

exports.getCategories = (req, res) => {
  db.query('SELECT * FROM categories ORDER BY name', (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(result);
  });
};

exports.createCategory = (req, res) => {
  const { name } = req.body;

  if (!name || name.trim() === '') {
    return res.status(400).json({ message: 'Nama kategori wajib diisi' });
  }

  db.query(
    'INSERT INTO categories (name) VALUES (?)',
    [name.trim()],
    (err, result) => {
      if (err) return res.status(500).json({ message: 'Gagal menambah kategori' });
      res.json({ message: 'Kategori berhasil ditambahkan', id: result.insertId, name: name.trim() });
    }
  );
};
