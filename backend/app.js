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

// Auto-create loans table jika belum ada
db.query(`
  CREATE TABLE IF NOT EXISTS loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    purpose VARCHAR(255) DEFAULT '',
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    status ENUM('active', 'returned', 'late') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
  )
`, (err) => {
  if (err) console.log('[DB] Error membuat tabel loans:', err.message);
  else console.log('[DB] Tabel loans siap');
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

app.listen(3000, () => {
  console.log('Server jalan di http://localhost:3000');
});
