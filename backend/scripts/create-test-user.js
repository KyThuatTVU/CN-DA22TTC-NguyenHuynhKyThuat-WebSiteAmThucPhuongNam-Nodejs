const db = require('../config/database');
const bcrypt = require('bcryptjs');

async function createTestUser() {
    try {
        console.log('🔧 Tạo user test...');

        // Hash password
        const password = '123456';
        const mat_khau_hash = await bcrypt.hash(password, 10);

        // Kiểm tra user đã tồn tại chưa
        const [existing] = await db.query(
            'SELECT ma_nguoi_dung FROM nguoi_dung WHERE email = ?',
            ['test@gmail.com']
        );

        if (existing.length > 0) {
            console.log('⚠️ User test@gmail.com đã tồn tại!');
            console.log('📧 Email: test@gmail.com');
            console.log('🔑 Mật khẩu: 123456');
            
            // Cập nhật mật khẩu nếu cần
            await db.query(
                'UPDATE nguoi_dung SET mat_khau_hash = ? WHERE email = ?',
                [mat_khau_hash, 'test@gmail.com']
            );
            console.log('✅ Đã reset mật khẩu!');
        } else {
            // Tạo user mới
            const [result] = await db.query(
                `INSERT INTO nguoi_dung 
                (ten_nguoi_dung, email, so_dien_thoai, mat_khau_hash, dia_chi, gioi_tinh, anh_dai_dien, trang_thai) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
                [
                    'Nguyễn Văn Test',
                    'test@gmail.com',
                    '0123456789',
                    mat_khau_hash,
                    'Vĩnh Long',
                    'nam',
                    null, // Không có ảnh đại diện
                    1 // Trạng thái active
                ]
            );

            console.log('✅ Tạo user thành công!');
            console.log('📝 ID:', result.insertId);
        }

        console.log('\n📋 Thông tin đăng nhập:');
        console.log('📧 Email: test@gmail.com');
        console.log('🔑 Mật khẩu: 123456');
        console.log('\n🔗 URL đăng nhập: http://localhost:5500/frontend/dang-nhap.html');

        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
}

createTestUser();
