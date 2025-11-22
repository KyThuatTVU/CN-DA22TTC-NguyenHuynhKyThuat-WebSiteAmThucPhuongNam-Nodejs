const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function fixMissingAvatars() {
    try {
        console.log('🔧 Sửa lỗi ảnh đại diện bị mất...\n');

        // Lấy danh sách người dùng có avatar trong DB
        const [users] = await db.query(
            'SELECT ma_nguoi_dung, ten_nguoi_dung, email, anh_dai_dien FROM nguoi_dung WHERE anh_dai_dien IS NOT NULL AND anh_dai_dien != ""'
        );

        if (users.length === 0) {
            console.log('✅ Không có người dùng nào có avatar path trong database');
            process.exit(0);
        }

        console.log(`📊 Tìm thấy ${users.length} người dùng có avatar path\n`);

        let fixedCount = 0;
        const avatarsDir = path.join(__dirname, '../images/avatars');

        for (const user of users) {
            console.log(`\n👤 ${user.ten_nguoi_dung} (${user.email})`);
            console.log(`   Avatar DB: ${user.anh_dai_dien}`);

            // Kiểm tra file có tồn tại không
            const avatarPath = path.join(__dirname, '..', user.anh_dai_dien);
            const exists = fs.existsSync(avatarPath);

            if (!exists) {
                console.log(`   ❌ File không tồn tại! Đang xóa path trong DB...`);
                
                // Xóa avatar path trong database
                await db.query(
                    'UPDATE nguoi_dung SET anh_dai_dien = NULL WHERE ma_nguoi_dung = ?',
                    [user.ma_nguoi_dung]
                );
                
                console.log(`   ✅ Đã xóa avatar path trong DB`);
                fixedCount++;
            } else {
                console.log(`   ✅ File tồn tại, không cần sửa`);
            }
        }

        console.log('\n' + '═'.repeat(80));
        console.log(`\n✅ Hoàn thành! Đã sửa ${fixedCount}/${users.length} bản ghi`);
        console.log('\n💡 Người dùng giờ có thể upload lại ảnh đại diện mới\n');

        process.exit(0);

    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        console.error(error);
        process.exit(1);
    }
}

// Chạy script
fixMissingAvatars();
