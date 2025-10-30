const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files (images)
app.use('/images', express.static(path.join(__dirname, 'images')));

// Serve frontend files
app.use(express.static(path.join(__dirname, '../frontend')));

// Import database connection để kiểm tra
const db = require('./config/database');

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

app.use('/api/menu', menuRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/albums', albumRoutes);

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
