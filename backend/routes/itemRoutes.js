const express = require('express');
const router = express.Router();

const {
  getItems,
  getItemById,
  createItem,
  updateItem,
  deleteItem,
  upload,
} = require('../controllers/itemController');

const authMiddleware = require('../middleware/authMiddleware');

// semua route diproteksi
router.get('/', authMiddleware, getItems);
router.get('/:id', authMiddleware, getItemById);
router.post('/', authMiddleware, upload, createItem);
router.put('/:id', authMiddleware, updateItem);
router.delete('/:id', authMiddleware, deleteItem);

module.exports = router;