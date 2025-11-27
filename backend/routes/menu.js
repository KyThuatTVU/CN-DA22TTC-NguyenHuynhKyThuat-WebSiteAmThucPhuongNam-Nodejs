const express = require('express');
const router = express.Router();
const db = require('../config/database');
const multer = require('multer');
const path = require('path');

// Cấu hình multer để upload ảnh
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, '../images'));
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, 'product-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const upload = multer({ 
    storage: storage,
    fileFilter: function (req, file, cb) {
        const filetypes = /jpeg|jpg|png|gif|webp/;
        const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
        const mimetype = filetypes.test(file.mimetype);
        if (mimetype && extname) {
            return cb(null, true);
        } else {
            cb(new Error('Chỉ chấp nhận file ảnh!'));
        }
    }
});

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

// Middleware kiểm tra admin
const requireAdmin = (req, res, next) => {
  if (req.session && req.session.admin) {
    next();
  } else {
    res.status(401).json({ success: false, message: 'Unauthorized' });
  }
};

// Thêm món ăn mới (Admin)
router.post('/', requireAdmin, upload.single('anh_mon'), async (req, res) => {
  try {
    const { ten_mon, ma_danh_muc, gia_tien, so_luong_ton, mo_ta_chi_tiet, trang_thai } = req.body;
    const anh_mon = req.file ? req.file.filename : null;
    
    const [result] = await db.query(
      `INSERT INTO mon_an (ten_mon, ma_danh_muc, gia_tien, so_luong_ton, mo_ta_chi_tiet, trang_thai, anh_mon) 
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [ten_mon, ma_danh_muc, gia_tien, so_luong_ton || 0, mo_ta_chi_tiet, trang_thai, anh_mon]
    );
    
    res.json({ success: true, message: 'Thêm món ăn thành công', id: result.insertId });
  } catch (error) {
    console.error('Error adding product:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Cập nhật món ăn (Admin)
router.put('/:id', requireAdmin, upload.single('anh_mon'), async (req, res) => {
  try {
    const { ten_mon, ma_danh_muc, gia_tien, so_luong_ton, mo_ta_chi_tiet, trang_thai } = req.body;
    const anh_mon = req.file ? req.file.filename : null;
    
    const [result] = await db.query(
      `UPDATE mon_an 
       SET ten_mon = ?, ma_danh_muc = ?, gia_tien = ?, so_luong_ton = ?, 
           mo_ta_chi_tiet = ?, trang_thai = ?, anh_mon = COALESCE(?, anh_mon)
       WHERE ma_mon = ?`,
      [ten_mon, ma_danh_muc, gia_tien, so_luong_ton, mo_ta_chi_tiet, trang_thai, anh_mon, req.params.id]
    );
    
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Không tìm thấy món ăn' });
    }
    
    res.json({ success: true, message: 'Cập nhật món ăn thành công' });
  } catch (error) {
    console.error('Error updating product:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Xóa món ăn (Admin)
router.delete('/:id', requireAdmin, async (req, res) => {
  try {
    const [result] = await db.query('DELETE FROM mon_an WHERE ma_mon = ?', [req.params.id]);
    
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Không tìm thấy món ăn' });
    }
    
    res.json({ success: true, message: 'Xóa món ăn thành công' });
  } catch (error) {
    console.error('Error deleting product:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
