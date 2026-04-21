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
  const { category_id, name, description, stock, condition } = req.body;

  const sql = `
    INSERT INTO items (category_id, name, description, stock, \`condition\`)
    VALUES (?, ?, ?, ?, ?)
  `;

  db.query(sql, [category_id, name, description, stock, condition], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: 'Item berhasil ditambahkan' });
  });
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