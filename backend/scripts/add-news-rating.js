const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function addNewsRating() {
    try {
        console.log('🔄 Đang thêm chức năng đánh giá tin tức...');

        const sqlFile = path.join(__dirname, 'add-news-rating.sql');
        const sql = fs.readFileSync(sqlFile, 'utf8');

        const statements = sql.split(';').filter(stmt => stmt.trim());

        for (const statement of statements) {
            if (statement.trim()) {
                await db.query(statement);
            }
        }

        console.log('✅ Thêm chức năng đánh giá thành công!');
        
        // Kiểm tra
        const [comments] = await db.query('SELECT ma_binh_luan, so_sao FROM binh_luan_tin_tuc WHERE so_sao IS NOT NULL');
        console.log(`📊 Số bình luận có đánh giá: ${comments.length}`);

        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
}

addNewsRating();
