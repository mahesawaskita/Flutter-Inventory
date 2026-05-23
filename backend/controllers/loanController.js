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

const imageFilter = (req, file, cb) => {
  const extOk = /\.(jpeg|jpg|png|gif|webp)$/i.test(file.originalname);
  const mimeOk = file.mimetype.startsWith('image/') || file.mimetype === 'application/octet-stream';
  cb(null, extOk || mimeOk);
};

exports.uploadLoanPhoto = multer({
  storage,
  fileFilter: imageFilter,
  limits: { fileSize: 10 * 1024 * 1024 },
}).single('foto_barang');

exports.uploadReturnPhoto = multer({
  storage,
  fileFilter: imageFilter,
  limits: { fileSize: 10 * 1024 * 1024 },
}).single('foto_pengembalian');

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

// GET /api/loans/item/:itemId — semua peminjaman untuk item tertentu
exports.getLoansByItem = (req, res) => {
  const { itemId } = req.params;
  const sql = `
    SELECT
      b.id, b.user_id, b.status,
      b.borrow_date,
      b.return_date  AS due_date,
      b.actual_return AS return_date,
      COALESCE(b.nama_barang, i.name) AS item_name,
      u.username,
      b.quantity
    FROM borrowings b
    LEFT JOIN users u ON b.user_id = u.id
    LEFT JOIN items i ON b.item_id = i.id
    WHERE b.item_id = ?
    ORDER BY b.id DESC
  `;
  db.query(sql, [itemId], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error', error: err.message });
    res.json(result);
  });
};

// POST /api/loans — buat peminjaman baru (status awal: pending menunggu persetujuan admin)
exports.createLoan = (req, res) => {
  const userId = req.user.id;
  const { item_id, borrow_date, due_date, quantity = 1 } = req.body;
  const qty = parseInt(quantity, 10) || 1;

  if (!item_id || !borrow_date || !due_date) {
    return res.status(400).json({ message: 'item_id, borrow_date, dan due_date wajib diisi' });
  }

  db.query(
    "SELECT id, name, image, stock, `status` FROM items WHERE id = ? AND status != 'inactive'",
    [item_id],
    (err, items) => {
      if (err) return res.status(500).json({ message: 'Server error' });
      if (items.length === 0) return res.status(404).json({ message: 'Barang tidak ditemukan' });

      const item = items[0];

      if (item.stock <= 0) {
        return res.status(400).json({ message: 'Stok barang habis, tidak tersedia untuk dipinjam' });
      }
      if (item.stock < qty) {
        return res.status(400).json({ message: `Stok tidak cukup. Tersedia: ${item.stock}` });
      }

      const fotoBarang = req.file ? req.file.filename : item.image;

      // Simpan dengan status 'pending' — stok belum dikurangi sampai admin acc
      const sql = `
        INSERT INTO borrowings (user_id, item_id, nama_barang, foto_barang, quantity, borrow_date, return_date, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')
      `;
      db.query(sql, [userId, item_id, item.name, fotoBarang, qty, borrow_date, due_date], (err2, result) => {
        if (err2) return res.status(500).json({ message: 'Gagal membuat peminjaman', error: err2.message });

        console.log(`[LOAN] User ${userId} mengajukan ${qty}x "${item.name}" (item_id:${item_id}), menunggu persetujuan admin, borrowing id: ${result.insertId}`);
        res.json({ message: 'Pengajuan peminjaman berhasil dikirim, menunggu persetujuan admin', id: result.insertId });
      });
    }
  );
};

// GET /api/loans/pending — semua pengajuan pending (admin)
exports.getPendingLoans = (req, res) => {
  if (req.user.role !== 'admin') return res.status(403).json({ message: 'Akses ditolak' });

  const sql = `
    SELECT
      b.id, b.item_id, b.user_id, b.status,
      b.borrow_date,
      b.return_date AS due_date,
      b.quantity,
      COALESCE(b.nama_barang, i.name) AS item_name,
      COALESCE(b.foto_barang, i.image) AS item_image,
      u.username,
      i.stock AS item_stock,
      i.condition AS item_condition,
      c.name AS category_name
    FROM borrowings b
    LEFT JOIN users u ON b.user_id = u.id
    LEFT JOIN items i ON b.item_id = i.id
    LEFT JOIN categories c ON i.category_id = c.id
    WHERE b.status = 'pending'
    ORDER BY b.id DESC
  `;
  db.query(sql, (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error', error: err.message });
    res.json(result);
  });
};

// PUT /api/loans/:id/approve — setujui pengajuan peminjaman (admin)
exports.approveLoan = (req, res) => {
  if (req.user.role !== 'admin') return res.status(403).json({ message: 'Akses ditolak' });

  const { id } = req.params;

  db.query('SELECT * FROM borrowings WHERE id = ? AND status = ?', [id, 'pending'], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.length === 0) return res.status(404).json({ message: 'Pengajuan tidak ditemukan atau sudah diproses' });

    const loan = result[0];
    const qty = parseInt(loan.quantity, 10) || 1;

    // Cek stok masih cukup
    db.query("SELECT stock FROM items WHERE id = ?", [loan.item_id], (err2, items) => {
      if (err2) return res.status(500).json({ message: 'Server error' });
      if (items.length === 0) return res.status(404).json({ message: 'Barang tidak ditemukan' });

      const currentStock = items[0].stock;
      if (currentStock < qty) {
        return res.status(400).json({ message: `Stok tidak cukup untuk disetujui. Tersedia: ${currentStock}` });
      }

      db.query("UPDATE borrowings SET status = 'borrowed' WHERE id = ?", [id], (err3) => {
        if (err3) return res.status(500).json({ message: 'Gagal memperbarui status' });

        const newStock = currentStock - qty;
        const newStatus = newStock <= 0 ? 'borrowed' : 'available';
        db.query(
          "UPDATE items SET stock = ?, `status` = ? WHERE id = ?",
          [newStock, newStatus, loan.item_id],
          (err4) => {
            if (err4) console.error('[APPROVE] Gagal update stok:', err4.message);
          }
        );

        console.log(`[APPROVE] Borrowing ${id} disetujui, stok item ${loan.item_id}: ${currentStock} → ${newStock}`);
        res.json({ message: 'Peminjaman disetujui' });
      });
    });
  });
};

// PUT /api/loans/:id/reject — tolak pengajuan peminjaman (admin)
exports.rejectLoan = (req, res) => {
  if (req.user.role !== 'admin') return res.status(403).json({ message: 'Akses ditolak' });

  const { id } = req.params;

  db.query("UPDATE borrowings SET status = 'rejected' WHERE id = ? AND status = 'pending'", [id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Pengajuan tidak ditemukan atau sudah diproses' });

    console.log(`[REJECT] Borrowing ${id} ditolak`);
    res.json({ message: 'Pengajuan ditolak' });
  });
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
    console.log('[RETURN] Data loan:', JSON.stringify(loan));

    if (loan.status === 'returned') {
      return res.status(400).json({ message: 'Barang sudah dikembalikan' });
    }

    const returnQty = parseInt(loan.quantity, 10);
    if (!returnQty || returnQty <= 0) {
      return res.status(400).json({ message: `Data quantity tidak valid: ${loan.quantity}` });
    }

    const fotoReturn = req.file ? req.file.filename : null;
    const catatan = req.body?.catatan_pengembalian || null;

    db.query(
      "UPDATE borrowings SET status = 'returned', actual_return = CURDATE(), foto_pengembalian = ?, catatan_pengembalian = ? WHERE id = ?",
      [fotoReturn, catatan, id],
      (err2) => {
        if (err2) return res.status(500).json({ message: 'Gagal memperbarui peminjaman' });

        db.query(
          "UPDATE items SET stock = stock + ?, `status` = 'available' WHERE id = ?",
          [returnQty, loan.item_id],
          (err3) => {
            if (err3) console.error('[RETURN] Gagal update stok:', err3.message);
          }
        );

        console.log(`[RETURN] Item ${loan.item_id} dikembalikan ${returnQty}x, borrowing id: ${id}`);
        res.json({ message: 'Barang berhasil dikembalikan' });
      }
    );
  });
};
