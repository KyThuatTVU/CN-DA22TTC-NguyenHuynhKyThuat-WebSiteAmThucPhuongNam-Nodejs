const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Lấy tất cả món ăn
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT m.*, d.ten_danh_muc 
      FROM mon_an m 
      LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc
      ORDER BY m.ma_mon DESC
    `);
    res.json({ success: true, data: rows });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lấy món ăn theo danh mục
router.get('/category/:id', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM mon_an WHERE ma_danh_muc = ?',
      [req.params.id]
    );
    res.json({ success: true, data: rows });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lấy chi tiết món ăn
router.get('/:id', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT m.*, d.ten_danh_muc 
      FROM mon_an m 
      LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc
      WHERE m.ma_mon = ?
    `, [req.params.id]);
    
    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Không tìm thấy món ăn' });
    }
    res.json({ success: true, data: rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
