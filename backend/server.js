const express = require('express');
const cors = require('cors');
const path = require('path');
const session = require('express-session');
const passport = require('./config/passport');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware - CORS phải cho phép tất cả origins trong development
app.use(cors({
  origin: function(origin, callback) {
    // Cho phép tất cả origins trong development
    console.log('🌐 CORS Origin:', origin);
    callback(null, true);
  },
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session middleware (phải đặt trước passport)
app.use(session({
  secret: process.env.SESSION_SECRET || 'your-session-secret-change-this',
  resave: true, // Quan trọng: lưu lại session mỗi request
  saveUninitialized: false,
  cookie: {
    secure: false, // false cho localhost (không dùng HTTPS)
    httpOnly: true,
    sameSite: 'lax', // Quan trọng: cho phép cookie cross-site
    maxAge: 24 * 60 * 60 * 1000 // 24 giờ
  }
}));

// Debug middleware - log session cho mỗi request
app.use((req, res, next) => {
  console.log('📍 Request:', req.method, req.path);
  console.log('🔑 Session ID:', req.sessionID);
  console.log('👤 Session User:', req.session?.user ? req.session.user.email : 'none');
  next();
});

// Passport middleware
app.use(passport.initialize());
app.use(passport.session());

// Serve static files (images)
app.use('/images', express.static(path.join(__dirname, 'images')));

// Serve frontend files
app.use(express.static(path.join(__dirname, '../frontend')));

// Import database connection để kiểm tra
const db = require('./config/database');

// Tự động tạo bảng cai_dat nếu chưa tồn tại
async function initSettingsTable() {
  try {
    // Tạo bảng nếu chưa có
    await db.query(`
      CREATE TABLE IF NOT EXISTS cai_dat (
        id int NOT NULL AUTO_INCREMENT,
        setting_key varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
        setting_value text COLLATE utf8mb4_unicode_ci,
        mo_ta varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        ngay_tao datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ngay_cap_nhat datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE KEY setting_key (setting_key)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    
    // Kiểm tra xem đã có dữ liệu chưa
    const [existing] = await db.query('SELECT COUNT(*) as count FROM cai_dat');
    if (existing[0].count === 0) {
      // Thêm dữ liệu mặc định
      const defaultSettings = [
        ['ten_nha_hang', 'Nhà hàng Ẩm thực Phương Nam', 'Tên nhà hàng'],
        ['dia_chi', '123 Đường ABC, Phường 1, TP. Vĩnh Long', 'Địa chỉ nhà hàng'],
        ['so_dien_thoai', '0123 456 789', 'Số điện thoại hotline'],
        ['email', 'info@phuongnam.vn', 'Email liên hệ'],
        ['website', 'phuongnam.vn', 'Website'],
        ['gio_mo_cua_t2_t6', '08:00-22:00', 'Giờ mở cửa thứ 2 đến thứ 6'],
        ['gio_mo_cua_t7_cn', '07:00-23:00', 'Giờ mở cửa thứ 7 và chủ nhật'],
        ['phi_giao_hang', '20000', 'Phí giao hàng (VNĐ)'],
        ['mien_phi_giao_hang_tu', '200000', 'Miễn phí giao hàng cho đơn từ (VNĐ)']
      ];
      
      for (const [key, value, desc] of defaultSettings) {
        await db.query(
          'INSERT IGNORE INTO cai_dat (setting_key, setting_value, mo_ta) VALUES (?, ?, ?)',
          [key, value, desc]
        );
      }
      console.log('✅ Đã tạo bảng cai_dat và thêm dữ liệu mặc định');
    } else {
      console.log('✅ Bảng cai_dat đã tồn tại');
    }
  } catch (error) {
    console.error('❌ Lỗi khởi tạo bảng cai_dat:', error.message);
  }
}

// Gọi hàm khởi tạo
initSettingsTable();

// Routes cơ bản
app.get('/', (req, res) => {
  res.json({
    message: 'API Ẩm Thực Phương Nam',
    status: 'running',
    version: '1.0.0'
  });
});

// Test database connection endpoint
app.get('/api/test-db', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT 1 + 1 AS result');
    res.json({
      success: true,
      message: 'Kết nối database thành công!',
      data: rows
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Lỗi kết nối database',
      error: error.message
    });
  }
});

// Import routes
const menuRoutes = require('./routes/menu');
const categoryRoutes = require('./routes/categories');
const albumRoutes = require('./routes/albums');
const authRoutes = require('./routes/auth');
const adminAuthRoutes = require('./routes/admin-auth');
const cartRoutes = require('./routes/cart');
const newsRoutes = require('./routes/news');
const orderRoutes = require('./routes/orders');
const momoPaymentRoutes = require('./routes/momo-payment');
const customerRoutes = require('./routes/customers');
const statsRoutes = require('./routes/stats');
const reservationRoutes = require('./routes/reservations');
const reviewRoutes = require('./routes/reviews');
const contactRoutes = require('./routes/contact');
const chatbotRoutes = require('./routes/chatbot');
const settingsRoutes = require('./routes/settings');
const adminChatbotRoutes = require('./routes/admin-chatbot');

app.use('/api/menu', menuRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/albums', albumRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/admin-auth', adminAuthRoutes);
app.use('/api/cart', cartRoutes);
app.use('/api/news', newsRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/payment', momoPaymentRoutes);
app.use('/api/customers', customerRoutes);
app.use('/api/stats', statsRoutes);
app.use('/api/reservations', reservationRoutes);
app.use('/api/reviews', reviewRoutes);
app.use('/api/contact', contactRoutes);
app.use('/api/chatbot', chatbotRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/admin-chatbot', adminChatbotRoutes);

// 404 handler for API routes - return JSON instead of HTML
app.use('/api/*', (req, res) => {
  res.status(404).json({
    success: false,
    message: 'API endpoint không tồn tại'
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Có lỗi xảy ra!',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server đang chạy tại http://localhost:${PORT}`);
  console.log(`📁 Môi trường: ${process.env.NODE_ENV}`);
});
