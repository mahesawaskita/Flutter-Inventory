const express = require('express');
const router = express.Router();

const { login, register, registerAdmin, getMe, updateMe, changePassword } = require('../controllers/authController');
const authMiddleware = require('../middleware/authMiddleware');

router.post('/login', login);
router.post('/register', register);
router.post('/register-admin', registerAdmin);
router.get('/me', authMiddleware, getMe);
router.put('/me', authMiddleware, updateMe);
router.put('/change-password', authMiddleware, changePassword);

module.exports = router;