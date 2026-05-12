const express = require('express');
const router = express.Router();
const { getAllLoans, getMyLoans, createLoan, returnLoan } = require('../controllers/loanController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', authMiddleware, getAllLoans);
router.get('/my', authMiddleware, getMyLoans);
router.post('/', authMiddleware, createLoan);
router.put('/:id/return', authMiddleware, returnLoan);

module.exports = router;
