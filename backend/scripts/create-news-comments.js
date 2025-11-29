const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function createNewsCommentsTable() {
    try {
        console.log('🔄 Đang tạo bảng bình luận tin tức...');

        const sqlFile = path.join(__dirname, 'create-news-comments-table.sql');
        const sql = fs.readFileSync(sqlFile, 'utf8');

        // Split by semicolon and execute each statement
        const statements = sql.split(';').filter(stmt => stmt.trim());

        for (const statement of statements) {
            if (statement.trim()) {
                await db.query(statement);
            }
        }

        console.log('✅ Tạo bảng bình luận tin tức thành công!');
        
        // Kiểm tra dữ liệu
        const [comments] = await db.query('SELECT COUNT(*) as total FROM binh_luan_tin_tuc');
        console.log(`📊 Số lượng bình luận: ${comments[0].total}`);

        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
}

createNewsCommentsTable();
