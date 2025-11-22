const mysql = require('mysql2/promise');
require('dotenv').config();

async function createOrderHistoryTable() {
    const connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
    });

    try {
        console.log('🔄 Creating order history table...');

        // Create table
        await connection.query(`
            CREATE TABLE IF NOT EXISTS lich_su_trang_thai_don_hang (
                id INT AUTO_INCREMENT PRIMARY KEY,
                ma_don_hang VARCHAR(50) NOT NULL,
                trang_thai ENUM('cho_xac_nhan', 'da_xac_nhan', 'dang_chuan_bi', 'dang_giao', 'hoan_thanh', 'da_huy') NOT NULL,
                ghi_chu TEXT,
                thoi_gian DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (ma_don_hang) REFERENCES don_hang(ma_don_hang) ON DELETE CASCADE,
                INDEX idx_ma_don_hang (ma_don_hang),
                INDEX idx_thoi_gian (thoi_gian)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        `);

        console.log('✅ Table created successfully');

        // Insert initial history for existing orders
        const [result] = await connection.query(`
            INSERT INTO lich_su_trang_thai_don_hang (ma_don_hang, trang_thai, ghi_chu, thoi_gian)
            SELECT 
                ma_don_hang,
                trang_thai,
                'Trạng thái ban đầu',
                ngay_dat
            FROM don_hang
            WHERE NOT EXISTS (
                SELECT 1 FROM lich_su_trang_thai_don_hang 
                WHERE lich_su_trang_thai_don_hang.ma_don_hang = don_hang.ma_don_hang
            )
        `);

        console.log(`✅ Inserted ${result.affectedRows} initial history records`);

    } catch (error) {
        console.error('❌ Error:', error.message);
        throw error;
    } finally {
        await connection.end();
    }
}

createOrderHistoryTable()
    .then(() => {
        console.log('✅ Done!');
        process.exit(0);
    })
    .catch((error) => {
        console.error('❌ Failed:', error);
        process.exit(1);
    });
