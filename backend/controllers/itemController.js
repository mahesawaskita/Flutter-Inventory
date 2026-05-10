const db = require('../config/db');

// 🔹 GET ALL ITEMS
exports.getItems = (req, res) => {
  db.query('SELECT * FROM items WHERE status != "inactive"', (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
};

// 🔹 CREATE ITEM
exports.createItem = (req, res) => {
  const { category_id, name, description, stock, condition, price } = req.body;

  if (!name || name.trim() === '') {
    return res.status(400).json({ message: 'Nama barang wajib diisi' });
  }

  const sql = `
    INSERT INTO items (category_id, name, description, stock, \`condition\`, price)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [category_id || null, name.trim(), description || '', stock || 0, condition || 'Tersedia', price || 0],
    (err, result) => {
      if (err) return res.status(500).json({ message: 'Gagal menambahkan barang', error: err.message });
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