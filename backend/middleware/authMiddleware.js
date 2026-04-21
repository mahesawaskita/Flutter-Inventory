const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) {
    return res.status(403).json({ message: 'Token tidak ada' });
  }

  try {
    const decoded = jwt.verify(token, 'SECRET_KEY');
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ message: 'Token tidak valid' });
  }
};

module.exports = authMiddleware;