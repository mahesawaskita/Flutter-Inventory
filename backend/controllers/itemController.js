const db = require('../config/db');
const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, 'uploads/'),
  filename: (req, file, cb) => {
    const unique = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, unique + path.extname(file.originalname));
  },
});

exports.upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const ok = /jpeg|jpg|png|gif|webp/.test(path.extname(file.originalname).toLowerCase()) &&
               /image\//.test(file.mimetype);
    cb(ok ? null : new Error('Hanya file gambar yang diperbolehkan'), ok);
  },
  limits: { fileSize: 5 * 1024 * 1024 },
}).single('image');

// 🔹 GET ALL ITEMS (with category_name via JOIN)
exports.getItems = (req, res) => {
  const sql = `
    SELECT items.*, categories.name AS category_name
    FROM items
    LEFT JOIN categories ON items.category_id = categories.id
    WHERE (items.status IS NULL OR items.status != 'inactive')
    ORDER BY items.id DESC
  `;
  db.query(sql, (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
};

// 🔹 CREATE ITEM
exports.createItem = (req, res) => {
  const { category_id, name, description, stock, condition, price } = req.body;
  const image = req.file ? req.file.filename : null;

  if (!name || name.trim() === '') {
    return res.status(400).json({ message: 'Nama barang wajib diisi' });
  }

  const sql = `
    INSERT INTO items (category_id, name, description, stock, \`condition\`, status, price, image)
    VALUES (?, ?, ?, ?, ?, 'available', ?, ?)
  `;

  db.query(
    sql,
    [category_id || null, name.trim(), description || '', stock || 0, condition || 'good', price || 0, image],
    (err, result) => {
      if (err) {
        console.log('[CREATE ITEM] ERROR:', err.message);
        return res.status(500).json({ message: 'Gagal menambahkan barang', error: err.message });
      }
      console.log('[CREATE ITEM] SUKSES, id:', result.insertId);
      res.json({ message: 'Item berhasil ditambahkan', id: result.insertId });
    }
  );
};

// 🔹 UPDATE ITEM
exports.updateItem = (req, res) => {
  const { id } = req.params;
  const { category_id, name, description, stock, condition } = req.body;

  const sql = `
    UPDATE items 
    SET category_id=?, name=?, description=?, stock=?, \`condition\`=?
    WHERE id=?
  `;

  db.query(sql, [category_id, name, description, stock, condition, id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: 'Item berhasil diupdate' });
  });
};

// 🔹 DELETE (SOFT DELETE)
exports.deleteItem = (req, res) => {
  const { id } = req.params;

  db.query(
    "UPDATE items SET status='inactive' WHERE id=?",
    [id],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: 'Item berhasil dihapus' });
    }
  );
};