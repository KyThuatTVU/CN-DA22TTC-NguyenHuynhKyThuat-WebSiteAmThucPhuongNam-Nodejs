const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function setupEmailVerification() {
    try {
        console.log('🔧 Đang tạo bảng email_verification...');
        
        const sql = fs.readFileSync(
            path.join(__dirname, 'create-email-verification-table.sql'),
            'utf8'
        );
        
        await db.query(sql);
        
        console.log('✅ Tạo bảng email_verification thành công!');
        
        // Kiểm tra cấu trúc bảng
        const [structure] = await db.query('DESCRIBE email_verification');
        console.log('\n📊 Cấu trúc bảng:');
        console.table(structure);
        
        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
}

setupEmailVerification();
