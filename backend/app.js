const express = require('express');
const app = express();
const authMiddleware = require('./middleware/authMiddleware');
const db = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const itemRoutes = require('./routes/itemRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const loanRoutes = require('./routes/loanRoutes');

app.use(express.json());
app.use('/uploads', express.static('uploads'));

// Log setiap request masuk
app.use((req, res, next) => {
  console.log(`[${new Date().toLocaleTimeString()}] ${req.method} ${req.path}`);
  next();
});


app.use('/api/auth', authRoutes);
app.use('/api/items', itemRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/loans', loanRoutes);

app.get('/users', authMiddleware, (req, res) => {
  db.query('SELECT * FROM users', (err, result) => {
    if (err) return res.send(err);
    res.json(result);
  });
});

app.get('/', (req, res) => {
  res.send('Backend jalan 🚀');
});

// Pastikan kolom quantity ada di tabel borrowings
db.query(`ALTER TABLE borrowings ADD COLUMN IF NOT EXISTS quantity INT NOT NULL DEFAULT 1`, (err) => {
  if (err && !err.message.includes('Duplicate column')) {
    console.log('[DB] quantity column check:', err.message);
  } else {
    console.log('[DB] Kolom quantity di borrowings siap');
  }
});

app.listen(3000, () => {
  console.log('Server jalan di http://localhost:3000');
});
