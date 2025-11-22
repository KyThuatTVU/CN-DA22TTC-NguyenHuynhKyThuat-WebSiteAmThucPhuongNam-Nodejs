const db = require('../config/database');

(async () => {
    try {
        console.log('🔄 Đang tạo bảng lich_su_trang_thai_don_hang...');
        
        // Drop table if exists
        await db.query('DROP TABLE IF EXISTS lich_su_trang_thai_don_hang');
        
        // Create table
        await db.query(`
            CREATE TABLE lich_su_trang_thai_don_hang (
                id INT AUTO_INCREMENT PRIMARY KEY,
                ma_don_hang INT NOT NULL,
                trang_thai ENUM('pending', 'confirmed', 'preparing', 'delivered', 'cancelled') NOT NULL,
                ghi_chu TEXT,
                thoi_gian DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (ma_don_hang) REFERENCES don_hang(ma_don_hang) ON DELETE CASCADE,
                INDEX idx_ma_don_hang (ma_don_hang),
                INDEX idx_thoi_gian (thoi_gian)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        `);
        
        console.log('✅ Tạo bảng thành công');
        
        // Insert history for existing orders
        await db.query(`
            INSERT INTO lich_su_trang_thai_don_hang (ma_don_hang, trang_thai, ghi_chu, thoi_gian)
            SELECT 
                ma_don_hang,
                trang_thai,
                'Trạng thái ban đầu',
                thoi_gian_tao
            FROM don_hang
        `);
        
        console.log('✅ Đã thêm lịch sử cho các đơn hàng hiện có');
        
        // Show count
        const [rows] = await db.query('SELECT COUNT(*) as count FROM lich_su_trang_thai_don_hang');
        console.log(`📊 Tổng số bản ghi: ${rows[0].count}`);
        
        process.exit(0);
    } catch (err) {
        console.error('❌ Lỗi:', err.message);
        process.exit(1);
    }
})();
