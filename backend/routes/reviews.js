const express = require('express');
const router = express.Router();
const db = require('../config/database');
const jwt = require('jsonwebtoken');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

// Cấu hình multer để upload ảnh đánh giá
const reviewImageStorage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadDir = path.join(__dirname, '../images/reviews');
    // Tạo thư mục nếu chưa tồn tại
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'review-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const uploadReviewImages = multer({
  storage: reviewImageStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB max
  fileFilter: function (req, file, cb) {
    const filetypes = /jpeg|jpg|png|gif|webp/;
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    const mimetype = filetypes.test(file.mimetype);
    if (mimetype && extname) {
      return cb(null, true);
    } else {
      cb(new Error('Chỉ chấp nhận file ảnh (jpg, png, gif, webp)!'));
    }
  }
}).array('images', 5); // Tối đa 5 ảnh

// Middleware xác thực JWT token
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    req.user = null;
    return next();
  }

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) {
      req.user = null;
    } else {
      req.user = user;
    }
    next();
  });
}

// Lấy đánh giá của món ăn (public) - có thêm thông tin user để hiển thị nút sửa/xóa
router.get('/product/:productId', authenticateToken, async (req, res) => {
  try {
    const productId = parseInt(req.params.productId);
    const currentUserId = req.user ? req.user.ma_nguoi_dung : null;
    
    // Lấy danh sách bình luận đã duyệt
    const [reviews] = await db.query(`
      SELECT dg.ma_danh_gia, dg.ma_nguoi_dung, dg.so_sao, dg.binh_luan, dg.ngay_danh_gia,
             dg.hinh_anh,
             nd.ten_nguoi_dung, nd.anh_dai_dien
      FROM danh_gia_san_pham dg
      JOIN nguoi_dung nd ON dg.ma_nguoi_dung = nd.ma_nguoi_dung
      WHERE dg.ma_mon = ? AND dg.trang_thai = 'approved'
      ORDER BY dg.ngay_danh_gia DESC
    `, [productId]);
    
    // Đánh dấu đánh giá nào là của user hiện tại và parse ảnh
    const reviewsWithOwnership = reviews.map(r => ({
      ...r,
      is_owner: currentUserId && r.ma_nguoi_dung === currentUserId,
      images: r.hinh_anh ? JSON.parse(r.hinh_anh) : []
    }));

    // Tính điểm trung bình và thống kê
    const [stats] = await db.query(`
      SELECT 
        COUNT(*) as total_reviews,
        AVG(so_sao) as average_rating,
        SUM(CASE WHEN so_sao = 5 THEN 1 ELSE 0 END) as star_5,
        SUM(CASE WHEN so_sao = 4 THEN 1 ELSE 0 END) as star_4,
        SUM(CASE WHEN so_sao = 3 THEN 1 ELSE 0 END) as star_3,
        SUM(CASE WHEN so_sao = 2 THEN 1 ELSE 0 END) as star_2,
        SUM(CASE WHEN so_sao = 1 THEN 1 ELSE 0 END) as star_1
      FROM danh_gia_san_pham
      WHERE ma_mon = ? AND trang_thai = 'approved'
    `, [productId]);

    res.json({
      success: true,
      data: {
        reviews: reviewsWithOwnership,
        stats: {
          totalReviews: stats[0].total_reviews || 0,
          averageRating: parseFloat(stats[0].average_rating) || 0,
          distribution: {
            5: stats[0].star_5 || 0,
            4: stats[0].star_4 || 0,
            3: stats[0].star_3 || 0,
            2: stats[0].star_2 || 0,
            1: stats[0].star_1 || 0
          }
        }
      }
    });
  } catch (error) {
    console.error('Error fetching reviews:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Kiểm tra user có thể bình luận không (cho phép nhiều bình luận)
router.get('/check/:productId', authenticateToken, async (req, res) => {
  try {
    if (!req.user) {
      return res.json({ success: true, canReview: false, reason: 'not_logged_in' });
    }

    const productId = parseInt(req.params.productId);
    const userId = req.user.ma_nguoi_dung;

    // Đếm số bình luận của user cho sản phẩm này
    const [countResult] = await db.query(`
      SELECT COUNT(*) as total FROM danh_gia_san_pham 
      WHERE ma_mon = ? AND ma_nguoi_dung = ?
    `, [productId, userId]);

    // Kiểm tra đã mua món này chưa (tùy chọn)
    const [purchased] = await db.query(`
      SELECT ct.ma_ct_don FROM chi_tiet_don_hang ct
      JOIN don_hang dh ON ct.ma_don_hang = dh.ma_don_hang
      WHERE ct.ma_mon = ? AND dh.ma_nguoi_dung = ? AND dh.trang_thai = 'delivered'
      LIMIT 1
    `, [productId, userId]);

    // Cho phép bình luận nhiều lần
    res.json({ 
      success: true, 
      canReview: true,
      hasPurchased: purchased.length > 0,
      reviewCount: countResult[0].total
    });
  } catch (error) {
    console.error('Error checking review status:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Thêm bình luận mới với ảnh (yêu cầu đăng nhập, cho phép nhiều bình luận)
router.post('/', authenticateToken, (req, res) => {
  uploadReviewImages(req, res, async function (err) {
    try {
      if (err instanceof multer.MulterError) {
        return res.status(400).json({ success: false, message: 'Lỗi upload: ' + err.message });
      } else if (err) {
        return res.status(400).json({ success: false, message: err.message });
      }

      if (!req.user) {
        return res.status(401).json({ success: false, message: 'Vui lòng đăng nhập để bình luận' });
      }

      const { ma_mon, so_sao, binh_luan } = req.body;
      const userId = req.user.ma_nguoi_dung;

      // Validate
      if (!ma_mon || !so_sao || so_sao < 1 || so_sao > 5) {
        return res.status(400).json({ success: false, message: 'Dữ liệu không hợp lệ' });
      }

      // Xử lý ảnh upload
      let imagesJson = null;
      if (req.files && req.files.length > 0) {
        const imagePaths = req.files.map(file => '/images/reviews/' + file.filename);
        imagesJson = JSON.stringify(imagePaths);
      }

      // Thêm bình luận (cho phép nhiều bình luận từ 1 user)
      const [result] = await db.query(`
        INSERT INTO danh_gia_san_pham (ma_mon, ma_nguoi_dung, so_sao, binh_luan, hinh_anh, trang_thai)
        VALUES (?, ?, ?, ?, ?, 'approved')
      `, [ma_mon, userId, so_sao, binh_luan || null, imagesJson]);

      res.json({ 
        success: true, 
        message: 'Bình luận thành công!',
        data: { ma_danh_gia: result.insertId }
      });
    } catch (error) {
      console.error('Error adding review:', error);
      res.status(500).json({ success: false, message: error.message });
    }
  });
});

// Cập nhật đánh giá với ảnh (chỉ chủ sở hữu)
router.put('/:reviewId', authenticateToken, (req, res) => {
  uploadReviewImages(req, res, async function (err) {
    try {
      if (err instanceof multer.MulterError) {
        return res.status(400).json({ success: false, message: 'Lỗi upload: ' + err.message });
      } else if (err) {
        return res.status(400).json({ success: false, message: err.message });
      }

      if (!req.user) {
        return res.status(401).json({ success: false, message: 'Vui lòng đăng nhập' });
      }

      const reviewId = parseInt(req.params.reviewId);
      const userId = req.user.ma_nguoi_dung;
      const { so_sao, binh_luan, keep_images } = req.body;

      // Validate
      if (!so_sao || so_sao < 1 || so_sao > 5) {
        return res.status(400).json({ success: false, message: 'Số sao không hợp lệ' });
      }

      // Kiểm tra đánh giá có thuộc về user không
      const [existing] = await db.query(`
        SELECT ma_danh_gia, hinh_anh FROM danh_gia_san_pham 
        WHERE ma_danh_gia = ? AND ma_nguoi_dung = ?
      `, [reviewId, userId]);

      if (existing.length === 0) {
        return res.status(403).json({ success: false, message: 'Bạn không có quyền sửa đánh giá này' });
      }

      // Xử lý ảnh
      let imagesJson = null;
      const keptImages = keep_images ? JSON.parse(keep_images) : [];
      const newImages = req.files ? req.files.map(file => '/images/reviews/' + file.filename) : [];
      const allImages = [...keptImages, ...newImages];
      
      if (allImages.length > 0) {
        imagesJson = JSON.stringify(allImages);
      }

      // Cập nhật đánh giá
      await db.query(`
        UPDATE danh_gia_san_pham 
        SET so_sao = ?, binh_luan = ?, hinh_anh = ?, ngay_danh_gia = NOW()
        WHERE ma_danh_gia = ?
      `, [so_sao, binh_luan || null, imagesJson, reviewId]);

      res.json({ success: true, message: 'Cập nhật đánh giá thành công!' });
    } catch (error) {
      console.error('Error updating review:', error);
      res.status(500).json({ success: false, message: error.message });
    }
  });
});

// Xóa đánh giá (chỉ chủ sở hữu)
router.delete('/:reviewId', authenticateToken, async (req, res) => {
  try {
    if (!req.user) {
      return res.status(401).json({ success: false, message: 'Vui lòng đăng nhập' });
    }

    const reviewId = parseInt(req.params.reviewId);
    const userId = req.user.ma_nguoi_dung;

    // Kiểm tra đánh giá có thuộc về user không
    const [existing] = await db.query(`
      SELECT ma_danh_gia FROM danh_gia_san_pham 
      WHERE ma_danh_gia = ? AND ma_nguoi_dung = ?
    `, [reviewId, userId]);

    if (existing.length === 0) {
      return res.status(403).json({ success: false, message: 'Bạn không có quyền xóa đánh giá này' });
    }

    // Xóa đánh giá
    await db.query('DELETE FROM danh_gia_san_pham WHERE ma_danh_gia = ?', [reviewId]);

    res.json({ success: true, message: 'Xóa đánh giá thành công!' });
  } catch (error) {
    console.error('Error deleting review:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lấy đánh giá của user cho món ăn cụ thể (để edit)
router.get('/my-review/:productId', authenticateToken, async (req, res) => {
  try {
    if (!req.user) {
      return res.status(401).json({ success: false, message: 'Vui lòng đăng nhập' });
    }

    const productId = parseInt(req.params.productId);
    const userId = req.user.ma_nguoi_dung;

    const [reviews] = await db.query(`
      SELECT ma_danh_gia, so_sao, binh_luan, ngay_danh_gia
      FROM danh_gia_san_pham 
      WHERE ma_mon = ? AND ma_nguoi_dung = ?
    `, [productId, userId]);

    if (reviews.length === 0) {
      return res.json({ success: true, data: null });
    }

    res.json({ success: true, data: reviews[0] });
  } catch (error) {
    console.error('Error fetching user review:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
