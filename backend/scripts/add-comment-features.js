// Script chạy migration cho tính năng reactions và replies bình luận
const mysql = require('mysql2/promise');
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

async function runMigration() {
    const connection = await mysql.createConnection({
        host: process.env.DB_HOST || 'localhost',
        user: process.env.DB_USER || 'root',
        password: process.env.DB_PASSWORD || '',
        database: process.env.DB_NAME || 'amthuc_phuongnam'
    });

    try {
        console.log('🚀 Bắt đầu migration...');

        // 1. Kiểm tra và thêm cột ma_binh_luan_cha
        const [columns] = await connection.query(`
            SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'binh_luan_tin_tuc' AND COLUMN_NAME = 'ma_binh_luan_cha'
        `, [process.env.DB_NAME || 'amthuc_phuongnam']);

        if (columns.length === 0) {
            console.log('📝 Thêm cột ma_binh_luan_cha...');
            await connection.query(`
                ALTER TABLE binh_luan_tin_tuc 
                ADD COLUMN ma_binh_luan_cha int DEFAULT NULL
            `);
            
            // Thêm foreign key
            await connection.query(`
                ALTER TABLE binh_luan_tin_tuc
                ADD CONSTRAINT fk_binh_luan_cha FOREIGN KEY (ma_binh_luan_cha) 
                REFERENCES binh_luan_tin_tuc(ma_binh_luan) ON DELETE CASCADE
            `);
            console.log('✅ Đã thêm cột ma_binh_luan_cha');
        } else {
            console.log('⏭️ Cột ma_binh_luan_cha đã tồn tại');
        }

        // 2. Tạo bảng cam_xuc_binh_luan
        console.log('📝 Tạo bảng cam_xuc_binh_luan...');
        await connection.query(`
            CREATE TABLE IF NOT EXISTS cam_xuc_binh_luan (
                ma_cam_xuc int NOT NULL AUTO_INCREMENT,
                ma_binh_luan int NOT NULL,
                ma_nguoi_dung int NOT NULL,
                loai_cam_xuc enum('like','love','haha','wow','sad','angry') NOT NULL DEFAULT 'like',
                ngay_tao datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (ma_cam_xuc),
                UNIQUE KEY unique_user_comment_reaction (ma_binh_luan, ma_nguoi_dung),
                KEY ma_binh_luan (ma_binh_luan),
                KEY ma_nguoi_dung (ma_nguoi_dung),
                CONSTRAINT cam_xuc_binh_luan_ibfk_1 FOREIGN KEY (ma_binh_luan) REFERENCES binh_luan_tin_tuc(ma_binh_luan) ON DELETE CASCADE,
                CONSTRAINT cam_xuc_binh_luan_ibfk_2 FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(ma_nguoi_dung) ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        `);
        console.log('✅ Đã tạo bảng cam_xuc_binh_luan');

        console.log('🎉 Migration hoàn tất!');

    } catch (error) {
        console.error('❌ Lỗi migration:', error.message);
    } finally {
        await connection.end();
    }
}

runMigration();
