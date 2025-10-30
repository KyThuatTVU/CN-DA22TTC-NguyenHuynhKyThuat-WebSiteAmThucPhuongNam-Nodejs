const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Lấy tất cả album
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM album_anh ORDER BY ma_album DESC');
    res.json({ success: true, data: rows });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lấy ảnh theo món ăn
router.get('/product/:id', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM anh_san_pham WHERE ma_mon = ?',
      [req.params.id]
    );
    res.json({ success: true, data: rows });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
