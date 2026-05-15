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

exports.uploadLoanPhoto = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const extOk = /\.(jpeg|jpg|png|gif|webp)$/i.test(file.originalname);
    const mimeOk = file.mimetype.startsWith('image/') || file.mimetype === 'application/octet-stream';
    cb(null, extOk || mimeOk); // terima jika salah satu lolos
  },
  limits: { fileSize: 10 * 1024 * 1024 },
}).single('foto_barang');

// GET /api/loans — semua peminjaman (admin)
exports.getAllLoans = (req, res) => {
  const sql = `
    SELECT
      b.id, b.item_id, b.user_id, b.status,
      b.borrow_date,
      b.return_date  AS due_date,
      b.actual_return AS return_date,
      COALESCE(b.nama_barang, i.name) AS item_name,
      COALESCE(b.foto_barang, i.image) AS item_image,
      u.username,
      i.condition AS item_condition,
      i.status AS item_status,
      c.name AS category_name
    FROM borrowings b
    LEFT JOIN users u ON b.user_id = u.id
    LEFT JOIN items i ON b.item_id = i.id
    LEFT JOIN categories c ON i.category_id = c.id
    ORDER BY b.id DESC
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
    SELECT
      b.id, b.item_id, b.user_id, b.status,
      b.borrow_date,
      b.return_date  AS due_date,
      b.actual_return AS return_date,
      COALESCE(b.nama_barang, i.name) AS item_name,
      COALESCE(b.foto_barang, i.image) AS item_image,
      i.condition AS item_condition,
      i.status AS item_status,
      c.name AS category_name
    FROM borrowings b
    LEFT JOIN items i ON b.item_id = i.id
    LEFT JOIN categories c ON i.category_id = c.id
    WHERE b.user_id = ?
    ORDER BY b.id DESC
  `;
  db.query(sql, [userId], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(result);
  });
};

// POST /api/loans — buat peminjaman baru
exports.createLoan = (req, res) => {
  const userId = req.user.id;
  const { item_id, borrow_date, due_date, quantity = 1 } = req.body;
  const qty = parseInt(quantity, 10) || 1;

  if (!item_id || !borrow_date || !due_date) {
    return res.status(400).json({ message: 'item_id, borrow_date, dan due_date wajib diisi' });
  }

  // Ambil detail item: nama, foto, stok, status
  db.query(
    "SELECT id, name, image, stock, `status` FROM items WHERE id = ? AND status != 'inactive'",
    [item_id],
    (err, items) => {
      if (err) return res.status(500).json({ message: 'Server error' });
      if (items.length === 0) return res.status(404).json({ message: 'Barang tidak ditemukan' });

      const item = items[0];

      if (item.stock <= 0 || item.status === 'borrowed') {
        return res.status(400).json({ message: 'Stok barang habis, tidak tersedia untuk dipinjam' });
      }
      if (item.stock < qty) {
        return res.status(400).json({ message: `Stok tidak cukup. Tersedia: ${item.stock}` });
      }

      // Foto yang diupload user saat peminjaman (opsional)
      const fotoBarang = req.file ? req.file.filename : item.image;

      // Simpan peminjaman dengan snapshot nama, foto, dan jumlah
      const sql = `
        INSERT INTO borrowings (user_id, item_id, nama_barang, foto_barang, quantity, borrow_date, return_date, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, 'borrowed')
      `;
      db.query(sql, [userId, item_id, item.name, fotoBarang, qty, borrow_date, due_date], (err2, result) => {
        if (err2) return res.status(500).json({ message: 'Gagal membuat peminjaman', error: err2.message });

        // Kurangi stok sesuai jumlah; jika habis ubah status jadi 'borrowed'
        const newStock = item.stock - qty;
        const newStatus = newStock <= 0 ? 'borrowed' : 'available';
        db.query(
          "UPDATE items SET stock = ?, `status` = ? WHERE id = ?",
          [newStock, newStatus, item_id],
          (err3) => {
            if (err3) console.error('[LOAN] Gagal update stok:', err3.message);
          }
        );

        console.log(`[LOAN] User ${userId} meminjam ${qty}x "${item.name}" (item_id:${item_id}), stok: ${item.stock} → ${newStock}, borrowing id: ${result.insertId}`);
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
    ? 'SELECT * FROM borrowings WHERE id = ?'
    : 'SELECT * FROM borrowings WHERE id = ? AND user_id = ?';
  const queryParams = role === 'admin' ? [id] : [id, userId];

  db.query(querySql, queryParams, (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.length === 0) return res.status(404).json({ message: 'Peminjaman tidak ditemukan' });

    const loan = result[0];
    if (loan.status === 'returned') {
      return res.status(400).json({ message: 'Barang sudah dikembalikan' });
    }

    db.query(
      "UPDATE borrowings SET status = 'returned', actual_return = CURDATE() WHERE id = ?",
      [id],
      (err2) => {
        if (err2) return res.status(500).json({ message: 'Gagal memperbarui peminjaman' });

        // Tambah stok kembali + set status available
        db.query(
          "UPDATE items SET stock = stock + 1, `status` = 'available' WHERE id = ?",
          [loan.item_id],
          (err3) => {
            if (err3) console.error('[RETURN] Gagal update stok:', err3.message);
          }
        );

        console.log(`[RETURN] Item ${loan.item_id} dikembalikan, borrowing id: ${id}`);
        res.json({ message: 'Barang berhasil dikembalikan' });
      }
    );
  });
};
