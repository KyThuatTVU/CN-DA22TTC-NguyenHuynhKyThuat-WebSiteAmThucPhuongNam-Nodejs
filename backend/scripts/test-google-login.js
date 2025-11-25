const mysql = require('mysql2/promise');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

// Mô phỏng dữ liệu từ Google OAuth
const mockGoogleData = {
    email: 'nguyenhuynhkithuat84tv@gmail.com',
    displayName: 'Nguyễn Huỳnh Kĩ Thuật',
    avatar: 'https://lh3.googleusercontent.com/a/ACg8ocKExample123456789'
};

(async () => {
    try {
        const connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME
        });

        console.log('🔌 Đã kết nối database');
        console.log('');

        // Tìm admin với email Google
        console.log('🔍 Tìm admin với email:', mockGoogleData.email);
        const [admins] = await connection.query(
            'SELECT * FROM admin WHERE email = ?',
            [mockGoogleData.email]
        );

        if (admins.length === 0) {
            console.log('❌ Không tìm thấy admin với email này');
            console.log('💡 Bạn cần thêm email này vào bảng admin trước');
            await connection.end();
            return;
        }

        const admin = admins[0];
        console.log('✅ Tìm thấy admin:', admin.tai_khoan);
        console.log('');

        // Cập nhật thông tin từ Google
        console.log('📝 Cập nhật thông tin từ Google...');
        const updateFields = [];
        const updateValues = [];

        if (mockGoogleData.displayName && admin.ten_hien_thi !== mockGoogleData.displayName) {
            updateFields.push('ten_hien_thi = ?');
            updateValues.push(mockGoogleData.displayName);
            console.log('  - Tên hiển thị:', mockGoogleData.displayName);
        }

        if (mockGoogleData.avatar && admin.anh_dai_dien !== mockGoogleData.avatar) {
            updateFields.push('anh_dai_dien = ?');
            updateValues.push(mockGoogleData.avatar);
            console.log('  - Avatar:', mockGoogleData.avatar);
        }

        if (updateFields.length > 0) {
            updateValues.push(admin.ma_admin);
            const updateQuery = `UPDATE admin SET ${updateFields.join(', ')} WHERE ma_admin = ?`;
            await connection.query(updateQuery, updateValues);
            console.log('');
            console.log('✅ Đã cập nhật thông tin admin từ Google');
        } else {
            console.log('ℹ️ Không có thông tin mới để cập nhật');
        }

        console.log('');
        console.log('👤 Thông tin admin sau khi cập nhật:');
        const [updatedAdmins] = await connection.query(
            'SELECT ma_admin, tai_khoan, ten_hien_thi, email, anh_dai_dien, quyen FROM admin WHERE ma_admin = ?',
            [admin.ma_admin]
        );
        console.table(updatedAdmins);

        await connection.end();
        console.log('✅ Hoàn thành!');
    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        process.exit(1);
    }
})();
