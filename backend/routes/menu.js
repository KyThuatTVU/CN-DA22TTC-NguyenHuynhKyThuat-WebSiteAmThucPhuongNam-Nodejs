const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Lấy tất cả món ăn với tìm kiếm và lọc
router.get('/', async (req, res) => {
  try {
    const { search, category, minPrice, maxPrice, sortBy } = req.query;
    
    let query = `
      SELECT m.*, d.ten_danh_muc 
      FROM mon_an m 
      LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc
      WHERE 1=1
    `;
    const params = [];
    
    // Search filter
    if (search) {
      query += ` AND (m.ten_mon LIKE ? OR m.mo_ta_chi_tiet LIKE ?)`;
      params.push(`%${search}%`, `%${search}%`);
    }
    
    // Category filter
    if (category) {
      query += ` AND m.ma_danh_muc = ?`;
      params.push(category);
    }
    
    // Price range filter
    if (minPrice) {
      query += ` AND m.gia_tien >= ?`;
      params.push(minPrice);
    }
    if (maxPrice) {
      query += ` AND m.gia_tien <= ?`;
      params.push(maxPrice);
    }
    
    // Sorting
    switch(sortBy) {
      case 'newest':
        query += ` ORDER BY m.ma_mon DESC`;
        break;
      case 'price-asc':
        query += ` ORDER BY m.gia_tien ASC`;
        break;
      case 'price-desc':
        query += ` ORDER BY m.gia_tien DESC`;
        break;
      case 'popular':
        query += ` ORDER BY m.so_luong_ton ASC`;
        break;
      default:
        query += ` ORDER BY m.ma_mon DESC`;
    }
    
    const [rows] = await db.query(query, params);
    res.json({ success: true, data: rows, count: rows.length });
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
