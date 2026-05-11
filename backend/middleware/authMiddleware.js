const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'rahasia_jwt_inventori';

const authMiddleware = (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) {
    console.log('[AUTH] GAGAL: Token tidak ada di header');
    return res.status(403).json({ message: 'Token tidak ada' });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    console.log('[AUTH] GAGAL: Token tidak valid -', err.message);
    return res.status(401).json({ message: 'Token tidak valid' });
  }
};

module.exports = authMiddleware;