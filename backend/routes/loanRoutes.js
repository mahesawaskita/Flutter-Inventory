const express = require('express');
const router = express.Router();
const { getAllLoans, getMyLoans, getLoansByItem, createLoan, returnLoan, getPendingLoans, approveLoan, rejectLoan, uploadLoanPhoto, uploadReturnPhoto } = require('../controllers/loanController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', authMiddleware, getAllLoans);
router.get('/my', authMiddleware, getMyLoans);
router.get('/pending', authMiddleware, getPendingLoans);
router.get('/item/:itemId', authMiddleware, getLoansByItem);
router.post('/', authMiddleware, uploadLoanPhoto, createLoan);
router.put('/:id/approve', authMiddleware, approveLoan);
router.put('/:id/reject', authMiddleware, rejectLoan);
router.put('/:id/return', authMiddleware, uploadReturnPhoto, returnLoan);

module.exports = router;
