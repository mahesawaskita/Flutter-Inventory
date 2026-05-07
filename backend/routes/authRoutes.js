const express = require('express');
const router = express.Router();

const { login, register, registerAdmin } = require('../controllers/authController');

router.post('/login', login);
router.post('/register', register);
router.post('/register-admin', registerAdmin);

module.exports = router;