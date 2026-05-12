const db = require('../config/db');

// GET /api/loans — semua peminjaman (admin)
exports.getAllLoans = (req, res) => {
  const sql = `
    SELECT l.*, u.username,
           i.name AS item_name, i.condition AS item_condition,
           c.name AS category_name
    FROM loans l
    LEFT JOIN users u ON l.user_id = u.id
    LEFT JOIN items i ON l.item_id = i.id
    LEFT JOIN categories c ON i.category_id = c.id
    ORDER BY l.created_at DESC
  `;
  db.query(sql, (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error', error: err.message });
    res.json(result);
  });
};

// GET /api/loans/my — peminjaman milik user yang login
exports.getMyLoans = (req, res) => {
  const userId = req.user.id;
  const sql = `
    SELECT l.*, i.name AS item_name, i.condition AS item_condition,
           c.name AS category_name
    FROM loans l
    LEFT JOIN items i ON l.item_id = i.id
    LEFT JOIN categories c ON i.category_id = c.id
    WHERE l.user_id = ?
    ORDER BY l.created_at DESC
  `;
  db.query(sql, [userId], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(result);
  });
};

// POST /api/loans — buat peminjaman baru
exports.createLoan = (req, res) => {
  const userId = req.user.id;
  const { item_id, purpose, borrow_date, due_date } = req.body;

  if (!item_id || !borrow_date || !due_date) {
    return res.status(400).json({ message: 'item_id, borrow_date, dan due_date wajib diisi' });
  }

  db.query(
    'SELECT id, `condition` FROM items WHERE id = ? AND (status IS NULL OR status != "inactive")',
    [item_id],
    (err, items) => {
      if (err) return res.status(500).json({ message: 'Server error' });
      if (items.length === 0) return res.status(404).json({ message: 'Barang tidak ditemukan' });
      if (items[0].condition !== 'Tersedia') {
        return res.status(400).json({ message: 'Barang tidak tersedia untuk dipinjam' });
      }

      const sql = `
        INSERT INTO loans (user_id, item_id, purpose, borrow_date, due_date, status)
        VALUES (?, ?, ?, ?, ?, 'active')
      `;
      db.query(sql, [userId, item_id, purpose || '', borrow_date, due_date], (err2, result) => {
        if (err2) return res.status(500).json({ message: 'Gagal membuat peminjaman', error: err2.message });

        db.query("UPDATE items SET `condition` = 'Dipinjam' WHERE id = ?", [item_id]);
        console.log(`[LOAN] User ${userId} meminjam item ${item_id}, loan id: ${result.insertId}`);
        res.json({ message: 'Peminjaman berhasil dibuat', id: result.insertId });
      });
    }
  );
};

// PUT /api/loans/:id/return — kembalikan barang
exports.returnLoan = (req, res) => {
  const { id } = req.params;
  const userId = req.user.id;
  const role = req.user.role;

  const querySql = role === 'admin'
    ? 'SELECT * FROM loans WHERE id = ?'
    : 'SELECT * FROM loans WHERE id = ? AND user_id = ?';
  const queryParams = role === 'admin' ? [id] : [id, userId];

  db.query(querySql, queryParams, (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.length === 0) return res.status(404).json({ message: 'Peminjaman tidak ditemukan' });

    const loan = result[0];
    if (loan.status === 'returned') {
      return res.status(400).json({ message: 'Barang sudah dikembalikan' });
    }

    const returnDate = new Date().toISOString().slice(0, 10);
    db.query(
      "UPDATE loans SET status = 'returned', return_date = ? WHERE id = ?",
      [returnDate, id],
      (err2) => {
        if (err2) return res.status(500).json({ message: 'Gagal memperbarui peminjaman' });
        db.query("UPDATE items SET `condition` = 'Tersedia' WHERE id = ?", [loan.item_id]);
        console.log(`[LOAN] Item ${loan.item_id} dikembalikan, loan id: ${id}`);
        res.json({ message: 'Barang berhasil dikembalikan' });
      }
    );
  });
};
