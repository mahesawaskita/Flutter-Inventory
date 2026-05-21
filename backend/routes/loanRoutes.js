const express = require('express');
const router = express.Router();
const { getAllLoans, getMyLoans, getLoansByItem, createLoan, returnLoan, uploadLoanPhoto, uploadReturnPhoto } = require('../controllers/loanController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', authMiddleware, getAllLoans);
router.get('/my', authMiddleware, getMyLoans);
router.get('/item/:itemId', authMiddleware, getLoansByItem);
router.post('/', authMiddleware, uploadLoanPhoto, createLoan);
router.put('/:id/return', authMiddleware, uploadReturnPhoto, returnLoan);

module.exports = router;
