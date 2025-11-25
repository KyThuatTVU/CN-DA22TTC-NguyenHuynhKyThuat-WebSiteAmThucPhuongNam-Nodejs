const mysql = require('mysql2/promise');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

(async () => {
    try {
        const connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME
        });

        console.log('🔌 Đã kết nối database:', process.env.DB_NAME);
        console.log('');

        // Kiểm tra cấu trúc bảng admin
        console.log('📋 Cấu trúc bảng admin:');
        const [columns] = await connection.query('DESCRIBE admin');
        console.table(columns.map(col => ({
            Field: col.Field,
            Type: col.Type,
            Null: col.Null,
            Key: col.Key,
            Default: col.Default
        })));

        console.log('');
        console.log('👥 Dữ liệu admin hiện tại:');
        const [admins] = await connection.query('SELECT ma_admin, tai_khoan, ten_hien_thi, email, anh_dai_dien, quyen, ngay_tao FROM admin');
        
        if (admins.length === 0) {
            console.log('⚠️ Không có admin nào trong database');
        } else {
            console.table(admins.map(admin => ({
                ID: admin.ma_admin,
                'Tài khoản': admin.tai_khoan,
                'Tên hiển thị': admin.ten_hien_thi || '(chưa có)',
                'Email': admin.email || '(chưa có)',
                'Avatar': admin.anh_dai_dien ? '✅ Có' : '❌ Chưa có',
                'Quyền': admin.quyen,
                'Ngày tạo': admin.ngay_tao
            })));
        }

        await connection.end();
        console.log('');
        console.log('✅ Hoàn thành!');
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
})();
