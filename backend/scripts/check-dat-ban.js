const db = require('../config/database');

async function checkDatBanTable() {
    try {
        console.log('=== KIỂM TRA BẢNG DAT_BAN ===\n');
        
        // Kiểm tra bảng có tồn tại không
        const [tables] = await db.query("SHOW TABLES LIKE 'dat_ban'");
        
        if (tables.length === 0) {
            console.log('❌ Bảng dat_ban KHÔNG tồn tại trong database!');
            process.exit(1);
        }
        
        console.log('✅ Bảng dat_ban tồn tại\n');
        
        // Lấy cấu trúc bảng
        const [columns] = await db.query('DESCRIBE dat_ban');
        
        console.log('📋 CẤU TRÚC BẢNG:');
        console.log('─'.repeat(60));
        columns.forEach(col => {
            console.log(`${col.Field.padEnd(20)} | ${col.Type.padEnd(20)} | ${col.Null.padEnd(5)} | ${col.Key}`);
        });
        
        console.log('\n📊 DỮ LIỆU:');
        const [data] = await db.query('SELECT * FROM dat_ban LIMIT 5');
        console.log(`Số lượng đặt bàn: ${data.length}`);
        
        if (data.length > 0) {
            console.log('\n5 đặt bàn đầu tiên:');
            data.forEach(d => {
                console.log(`#${d.ma_dat_ban || d.madatban} - ${d.ten_khach_hang || d.tenkhachhang || 'N/A'} - ${d.ngay_dat || d.ngaydat} - ${d.trang_thai || d.trangthai}`);
            });
        } else {
            console.log('Chưa có dữ liệu đặt bàn');
        }
        
        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error);
        process.exit(1);
    }
}

checkDatBanTable();
