const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function createNewsReactions() {
    try {
        console.log('🔄 Đang tạo bảng cảm xúc tin tức...');

        const sqlFile = path.join(__dirname, 'create-news-reactions.sql');
        const sql = fs.readFileSync(sqlFile, 'utf8');

        const statements = sql.split(';').filter(stmt => stmt.trim());

        for (const statement of statements) {
            if (statement.trim()) {
                await db.query(statement);
            }
        }

        console.log('✅ Tạo bảng cảm xúc tin tức thành công!');
        
        // Kiểm tra dữ liệu
        const [reactions] = await db.query('SELECT COUNT(*) as total FROM cam_xuc_tin_tuc');
        console.log(`📊 Số lượng cảm xúc: ${reactions[0].total}`);

        // Thống kê theo loại
        const [stats] = await db.query(`
            SELECT loai_cam_xuc, COUNT(*) as count 
            FROM cam_xuc_tin_tuc 
            GROUP BY loai_cam_xuc
        `);
        console.log('\n📈 Thống kê theo loại cảm xúc:');
        stats.forEach(stat => {
            console.log(`   ${stat.loai_cam_xuc}: ${stat.count}`);
        });

        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
}

createNewsReactions();
