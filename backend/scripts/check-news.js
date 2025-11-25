const db = require('../config/database');

async function checkNews() {
    try {
        // Kiểm tra bảng tin_tuc
        const [rows] = await db.query('SELECT * FROM tin_tuc LIMIT 10');
        console.log('=== Dữ liệu bảng tin_tuc ===');
        console.log('Số lượng tin tức:', rows.length);
        
        if (rows.length > 0) {
            console.log('\nDanh sách tin tức:');
            rows.forEach((row, index) => {
                console.log(`\n${index + 1}. ID: ${row.ma_tin_tuc}`);
                console.log(`   Tiêu đề: ${row.tieu_de}`);
                console.log(`   Trạng thái: ${row.trang_thai}`);
                console.log(`   Ngày đăng: ${row.ngay_dang}`);
                console.log(`   Lượt xem: ${row.luot_xem}`);
            });
        } else {
            console.log('\n⚠️ Bảng tin_tuc trống! Cần thêm dữ liệu mẫu.');
        }

        // Kiểm tra cấu trúc bảng
        const [columns] = await db.query('DESCRIBE tin_tuc');
        console.log('\n=== Cấu trúc bảng tin_tuc ===');
        columns.forEach(col => {
            console.log(`- ${col.Field}: ${col.Type} ${col.Null === 'NO' ? 'NOT NULL' : ''}`);
        });

        process.exit(0);
    } catch (error) {
        console.error('Lỗi:', error.message);
        process.exit(1);
    }
}

checkNews();
