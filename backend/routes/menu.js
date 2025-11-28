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
    const { search, category, minPrice, maxPrice, sortBy, showAll } = req.query;
    
    let query = `
      SELECT m.*, d.ten_danh_muc,
             COALESCE(AVG(dg.so_sao), 0) as avg_rating,
             COUNT(DISTINCT dg.ma_danh_gia) as total_reviews
      FROM mon_an m 
      LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc
      LEFT JOIN danh_gia_san_pham dg ON m.ma_mon = dg.ma_mon AND dg.trang_thai = 'approved'
      WHERE 1=1
    `;
    const params = [];
    
    // Chỉ hiển thị món đang active cho người dùng (trừ khi admin request showAll)
    if (showAll !== 'true') {
      query += ` AND m.trang_thai = 1`;
    }
    
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
    
    // Group by để tính AVG rating
    query += ` GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet, 
               m.so_luong_ton, m.don_vi_tinh, m.trang_thai, m.ma_danh_muc, d.ten_danh_muc`;
    
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
    const [rows] = await db.query(`
      SELECT m.*, d.ten_danh_muc,
             COALESCE(AVG(dg.so_sao), 0) as avg_rating,
             COUNT(DISTINCT dg.ma_danh_gia) as total_reviews
      FROM mon_an m
      LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc
      LEFT JOIN danh_gia_san_pham dg ON m.ma_mon = dg.ma_mon AND dg.trang_thai = 'approved'
      WHERE m.ma_danh_muc = ?
      GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet, 
               m.so_luong_ton, m.don_vi_tinh, m.trang_thai, m.ma_danh_muc, d.ten_danh_muc
    `, [req.params.id]);
    res.json({ success: true, data: rows });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lấy top món ăn bán chạy nhất (public - không cần auth)
router.get('/top-selling', async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 4;
    
    const [topProducts] = await db.query(`
      SELECT m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet,
             COALESCE(SUM(ct.so_luong), 0) as da_ban,
             COALESCE(AVG(dg.so_sao), 0) as avg_rating,
             COUNT(DISTINCT dg.ma_danh_gia) as total_reviews
      FROM mon_an m
      LEFT JOIN chi_tiet_don_hang ct ON m.ma_mon = ct.ma_mon
      LEFT JOIN don_hang dh ON ct.ma_don_hang = dh.ma_don_hang
      LEFT JOIN danh_gia_san_pham dg ON m.ma_mon = dg.ma_mon AND dg.trang_thai = 'approved'
      GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet
      ORDER BY da_ban DESC
      LIMIT ?
    `, [limit]);

    res.json({ success: true, data: topProducts });
  } catch (error) {
    console.error('Error fetching top selling products:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Gợi ý món ăn liên quan (Machine Learning - Collaborative Filtering)
// Dựa trên các món thường được mua cùng nhau trong cùng đơn hàng
router.get('/related/:id', async (req, res) => {
  try {
    const productId = parseInt(req.params.id);
    const limit = parseInt(req.query.limit) || 4;

    // Lấy thông tin món hiện tại để biết danh mục
    const [currentProduct] = await db.query(
      'SELECT ma_danh_muc FROM mon_an WHERE ma_mon = ?',
      [productId]
    );

    if (currentProduct.length === 0) {
      return res.status(404).json({ success: false, message: 'Không tìm thấy món ăn' });
    }

    const categoryId = currentProduct[0].ma_danh_muc;

    // Collaborative Filtering: Tìm các món thường được mua cùng
    // Bước 1: Tìm các đơn hàng có chứa món hiện tại
    // Bước 2: Đếm tần suất các món khác xuất hiện trong các đơn hàng đó
    const [relatedByOrders] = await db.query(`
      SELECT 
        m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet,
        m.so_luong_ton, m.trang_thai, m.ma_danh_muc,
        COUNT(ct2.ma_mon) as frequency,
        'bought_together' as recommendation_type,
        COALESCE(AVG(dg.so_sao), 0) as avg_rating
      FROM chi_tiet_don_hang ct1
      JOIN chi_tiet_don_hang ct2 ON ct1.ma_don_hang = ct2.ma_don_hang AND ct1.ma_mon != ct2.ma_mon
      JOIN mon_an m ON ct2.ma_mon = m.ma_mon
      LEFT JOIN danh_gia_san_pham dg ON m.ma_mon = dg.ma_mon AND dg.trang_thai = 'approved'
      WHERE ct1.ma_mon = ?
      GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet, m.so_luong_ton, m.trang_thai, m.ma_danh_muc
      ORDER BY frequency DESC
      LIMIT ?
    `, [productId, limit]);

    let recommendations = relatedByOrders;

    // Nếu không đủ dữ liệu từ collaborative filtering, bổ sung bằng:
    // 1. Món cùng danh mục bán chạy
    // 2. Món bán chạy nhất
    if (recommendations.length < limit) {
      const existingIds = recommendations.map(r => r.ma_mon);
      existingIds.push(productId); // Loại bỏ món hiện tại
      
      const placeholders = existingIds.map(() => '?').join(',');
      const remaining = limit - recommendations.length;

      // Lấy món cùng danh mục bán chạy
      const [sameCategoryProducts] = await db.query(`
        SELECT 
          m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet,
          m.so_luong_ton, m.trang_thai, m.ma_danh_muc,
          COALESCE(SUM(ct.so_luong), 0) as frequency,
          'same_category' as recommendation_type,
          COALESCE(AVG(dg.so_sao), 0) as avg_rating
        FROM mon_an m
        LEFT JOIN chi_tiet_don_hang ct ON m.ma_mon = ct.ma_mon
        LEFT JOIN danh_gia_san_pham dg ON m.ma_mon = dg.ma_mon AND dg.trang_thai = 'approved'
        WHERE m.ma_danh_muc = ? AND m.ma_mon NOT IN (${placeholders})
        GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet, m.so_luong_ton, m.trang_thai, m.ma_danh_muc
        ORDER BY frequency DESC
        LIMIT ?
      `, [categoryId, ...existingIds, remaining]);

      recommendations = [...recommendations, ...sameCategoryProducts];
    }

    // Nếu vẫn không đủ, lấy món bán chạy nhất
    if (recommendations.length < limit) {
      const existingIds = recommendations.map(r => r.ma_mon);
      existingIds.push(productId);
      
      const placeholders = existingIds.map(() => '?').join(',');
      const remaining = limit - recommendations.length;

      const [topSellingProducts] = await db.query(`
        SELECT 
          m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet,
          m.so_luong_ton, m.trang_thai, m.ma_danh_muc,
          COALESCE(SUM(ct.so_luong), 0) as frequency,
          'top_selling' as recommendation_type,
          COALESCE(AVG(dg.so_sao), 0) as avg_rating
        FROM mon_an m
        LEFT JOIN chi_tiet_don_hang ct ON m.ma_mon = ct.ma_mon
        LEFT JOIN danh_gia_san_pham dg ON m.ma_mon = dg.ma_mon AND dg.trang_thai = 'approved'
        WHERE m.ma_mon NOT IN (${placeholders})
        GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien, m.mo_ta_chi_tiet, m.so_luong_ton, m.trang_thai, m.ma_danh_muc
        ORDER BY frequency DESC
        LIMIT ?
      `, [...existingIds, remaining]);

      recommendations = [...recommendations, ...topSellingProducts];
    }

    res.json({ 
      success: true, 
      data: recommendations,
      meta: {
        productId,
        totalRecommendations: recommendations.length,
        types: {
          bought_together: recommendations.filter(r => r.recommendation_type === 'bought_together').length,
          same_category: recommendations.filter(r => r.recommendation_type === 'same_category').length,
          top_selling: recommendations.filter(r => r.recommendation_type === 'top_selling').length
        }
      }
    });
  } catch (error) {
    console.error('Error fetching related products:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Middleware kiểm tra admin (đặt trước các route cần auth)
const requireAdmin = (req, res, next) => {
  if (req.session && req.session.admin) {
    next();
  } else {
    res.status(401).json({ success: false, message: 'Unauthorized' });
  }
};

// Toggle trạng thái hiển thị món ăn (Admin) - ĐẶT TRƯỚC /:id
router.patch('/:id/toggle-status', requireAdmin, async (req, res) => {
  try {
    const productId = req.params.id;
    
    // Lấy trạng thái hiện tại
    const [current] = await db.query('SELECT trang_thai FROM mon_an WHERE ma_mon = ?', [productId]);
    
    if (current.length === 0) {
      return res.status(404).json({ success: false, message: 'Không tìm thấy món ăn' });
    }
    
    // Toggle trạng thái (0 -> 1, 1 -> 0)
    const newStatus = current[0].trang_thai == 1 ? 0 : 1;
    
    await db.query('UPDATE mon_an SET trang_thai = ? WHERE ma_mon = ?', [newStatus, productId]);
    
    res.json({ 
      success: true, 
      message: newStatus == 1 ? 'Đã bật hiển thị món ăn' : 'Đã tắt hiển thị món ăn',
      data: { trang_thai: newStatus }
    });
  } catch (error) {
    console.error('Error toggling product status:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Cập nhật số lượng tồn kho (Admin) - ĐẶT TRƯỚC /:id
router.patch('/:id/stock', requireAdmin, async (req, res) => {
  try {
    const productId = req.params.id;
    const { so_luong_ton } = req.body;
    
    if (so_luong_ton === undefined || so_luong_ton < 0) {
      return res.status(400).json({ success: false, message: 'Số lượng không hợp lệ' });
    }
    
    const [result] = await db.query(
      'UPDATE mon_an SET so_luong_ton = ? WHERE ma_mon = ?', 
      [so_luong_ton, productId]
    );
    
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Không tìm thấy món ăn' });
    }
    
    res.json({ 
      success: true, 
      message: 'Cập nhật số lượng thành công',
      data: { so_luong_ton }
    });
  } catch (error) {
    console.error('Error updating stock:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lấy chi tiết món ăn - ĐẶT SAU các route có path cụ thể hơn
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
