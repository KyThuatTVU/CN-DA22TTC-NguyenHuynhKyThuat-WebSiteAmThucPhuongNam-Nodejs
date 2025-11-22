const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function checkUserAvatars() {
    try {
        console.log('🔍 Kiểm tra ảnh đại diện người dùng...\n');

        // Lấy danh sách người dùng
        const [users] = await db.query(
            'SELECT ma_nguoi_dung, ten_nguoi_dung, email, anh_dai_dien FROM nguoi_dung LIMIT 20'
        );

        if (users.length === 0) {
            console.log('❌ Không tìm thấy người dùng nào trong database');
            process.exit(0);
        }

        console.log(`📊 Tìm thấy ${users.length} người dùng\n`);
        console.log('═'.repeat(80));

        for (const user of users) {
            console.log(`\n👤 User: ${user.ten_nguoi_dung} (ID: ${user.ma_nguoi_dung})`);
            console.log(`   Email: ${user.email}`);
            console.log(`   Avatar DB: ${user.anh_dai_dien || 'NULL'}`);

            if (user.anh_dai_dien) {
                // Kiểm tra file có tồn tại không
                const avatarPath = path.join(__dirname, '..', user.anh_dai_dien);
                const exists = fs.existsSync(avatarPath);
                
                if (exists) {
                    const stats = fs.statSync(avatarPath);
                    const fileSizeKB = (stats.size / 1024).toFixed(2);
                    console.log(`   ✅ File tồn tại: ${avatarPath}`);
                    console.log(`   📏 Kích thước: ${fileSizeKB} KB`);
                } else {
                    console.log(`   ❌ File KHÔNG tồn tại: ${avatarPath}`);
                }
                
                console.log(`   🌐 URL: http://localhost:3000${user.anh_dai_dien}`);
            } else {
                console.log(`   ℹ️  Chưa có ảnh đại diện`);
            }
        }

        console.log('\n' + '═'.repeat(80));
        
        // Thống kê
        const withAvatar = users.filter(u => u.anh_dai_dien).length;
        const withoutAvatar = users.length - withAvatar;
        
        console.log('\n📈 Thống kê:');
        console.log(`   - Có ảnh đại diện: ${withAvatar}/${users.length}`);
        console.log(`   - Chưa có ảnh: ${withoutAvatar}/${users.length}`);

        // Kiểm tra thư mục avatars
        console.log('\n📁 Kiểm tra thư mục avatars...');
        const avatarsDir = path.join(__dirname, '../images/avatars');
        if (fs.existsSync(avatarsDir)) {
            const files = fs.readdirSync(avatarsDir);
            console.log(`   ✅ Thư mục tồn tại: ${avatarsDir}`);
            console.log(`   📄 Số file: ${files.length}`);
            if (files.length > 0) {
                console.log(`   📝 Danh sách file:`);
                files.slice(0, 10).forEach(file => {
                    const filePath = path.join(avatarsDir, file);
                    const stats = fs.statSync(filePath);
                    const fileSizeKB = (stats.size / 1024).toFixed(2);
                    console.log(`      - ${file} (${fileSizeKB} KB)`);
                });
                if (files.length > 10) {
                    console.log(`      ... và ${files.length - 10} file khác`);
                }
            }
        } else {
            console.log(`   ❌ Thư mục không tồn tại: ${avatarsDir}`);
            console.log(`   💡 Tạo thư mục bằng lệnh: mkdir -p "${avatarsDir}"`);
        }

        console.log('\n✅ Hoàn thành kiểm tra!\n');
        process.exit(0);

    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        console.error(error);
        process.exit(1);
    }
}

// Chạy script
checkUserAvatars();
