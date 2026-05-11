const express = require('express');
const app = express();
const authMiddleware = require('./middleware/authMiddleware');
const db = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const itemRoutes = require('./routes/itemRoutes');
const categoryRoutes = require('./routes/categoryRoutes');


app.use(express.json());
app.use('/uploads', express.static('uploads'));

// Log setiap request masuk
app.use((req, res, next) => {
  console.log(`[${new Date().toLocaleTimeString()}] ${req.method} ${req.path}`);
  next();
});

app.use('/api/items', itemRoutes);
app.use('/api/categories', categoryRoutes);

app.get('/users', authMiddleware, (req, res) => {
  db.query('SELECT * FROM users', (err, result) => {
    if (err) return res.send(err);
    res.json(result);
  });
});


app.use('/api/auth', authRoutes);

app.get('/', (req, res) => {
  res.send('Backend jalan 🚀');
});

app.get('/users', (req, res) => {
  db.query('SELECT * FROM users', (err, result) => {
    if (err) {
      return res.send(err);
    }
    res.json(result);
  });
});

app.listen(3000, () => {
  console.log('Server jalan di http://localhost:3000');
});
