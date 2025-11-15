const db = require('../config/database');

async function checkTables() {
    try {
        console.log('🔍 Đang kiểm tra các bảng trong database...\n');
        
        // Lấy danh sách tất cả các bảng
        const [tables] = await db.query('SHOW TABLES');
        
        console.log('=== DANH SÁCH CÁC BẢNG ===');
        tables.forEach(table => {
            const tableName = Object.values(table)[0];
            console.log(`✓ ${tableName}`);
        });
        
        console.log(`\n📊 Tổng số: ${tables.length} bảng\n`);
        
        // Kiểm tra bảng album_anh có tồn tại không
        const albumTable = tables.find(table => 
            Object.values(table)[0] === 'album_anh'
        );
        
        if (albumTable) {
            console.log('✅ Bảng "album_anh" TỒN TẠI\n');
            
            // Kiểm tra cấu trúc bảng
            const [structure] = await db.query('DESCRIBE album_anh');
            console.log('=== CẤU TRÚC BẢNG album_anh ===');
            structure.forEach(col => {
                console.log(`- ${col.Field} (${col.Type}) ${col.Null === 'NO' ? 'NOT NULL' : 'NULL'}`);
            });
            
            // Đếm số lượng ảnh
            const [count] = await db.query('SELECT COUNT(*) as total FROM album_anh');
            console.log(`\n📸 Số lượng ảnh hiện có: ${count[0].total}`);
            
        } else {
            console.log('❌ Bảng "album_anh" KHÔNG TỒN TẠI\n');
            console.log('💡 Bạn cần tạo bảng album_anh bằng cách:');
            console.log('   1. Chạy file init.sql');
            console.log('   2. Hoặc chạy script tạo bảng\n');
        }
        
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
    } finally {
        process.exit();
    }
}

checkTables();
