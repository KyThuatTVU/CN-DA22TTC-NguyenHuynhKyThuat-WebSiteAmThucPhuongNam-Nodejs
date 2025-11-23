const db = require('../config/database');

(async () => {
    try {
        console.log('🔍 Kiểm tra bảng lich_su_trang_thai_don_hang...\n');
        
        const [tables] = await db.query('SHOW TABLES LIKE "lich_su_trang_thai_don_hang"');
        
        if (tables.length === 0) {
            console.log('❌ Bảng KHÔNG tồn tại!\n');
            console.log('Chạy lệnh sau để tạo bảng:');
            console.log('node scripts/create-order-status-history-table.js\n');
        } else {
            console.log('✅ Bảng đã tồn tại!\n');
            
            const [structure] = await db.query('DESCRIBE lich_su_trang_thai_don_hang');
            console.log('📋 Cấu trúc bảng:');
            console.table(structure);
            
            const [count] = await db.query('SELECT COUNT(*) as total FROM lich_su_trang_thai_don_hang');
            console.log(`\n📊 Tổng số bản ghi: ${count[0].total}\n`);
        }
    } catch(e) {
        console.error('❌ Lỗi:', e.message);
    }
    process.exit(0);
})();
