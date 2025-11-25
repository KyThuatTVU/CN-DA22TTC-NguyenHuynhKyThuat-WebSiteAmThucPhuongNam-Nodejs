const db = require('../config/database');
require('dotenv').config();

async function checkAndFixAdminAvatarColumn() {
    try {
        console.log('🔍 Kiểm tra cột anh_dai_dien trong bảng admin...\n');

        // Kiểm tra cột có tồn tại không
        const [columns] = await db.query(`
            SELECT 
                COLUMN_NAME,
                DATA_TYPE,
                CHARACTER_MAXIMUM_LENGTH,
                IS_NULLABLE,
                COLUMN_DEFAULT
            FROM 
                INFORMATION_SCHEMA.COLUMNS
            WHERE 
                TABLE_SCHEMA = DATABASE()
                AND TABLE_NAME = 'admin'
                AND COLUMN_NAME = 'anh_dai_dien'
        `);

        if (columns.length === 0) {
            console.log('⚠️  Cột anh_dai_dien chưa tồn tại. Đang thêm...\n');

            await db.query(`
                ALTER TABLE admin 
                ADD COLUMN anh_dai_dien VARCHAR(500) NULL 
                COMMENT 'URL ảnh đại diện từ Google OAuth'
            `);

            console.log('✅ Đã thêm cột anh_dai_dien thành công!\n');
        } else {
            console.log('✅ Cột anh_dai_dien đã tồn tại:');
            console.log(`   - Type: ${columns[0].DATA_TYPE}`);
            console.log(`   - Max Length: ${columns[0].CHARACTER_MAXIMUM_LENGTH}`);
            console.log(`   - Nullable: ${columns[0].IS_NULLABLE}\n`);
        }

        // Hiển thị cấu trúc bảng admin
        console.log('📋 Cấu trúc bảng admin:\n');
        const [structure] = await db.query('DESCRIBE admin');
        console.table(structure);

        // Hiển thị dữ liệu admin hiện tại
        console.log('\n👥 Dữ liệu admin hiện tại:\n');
        const [admins] = await db.query(`
            SELECT 
                ma_admin,
                tai_khoan,
                email,
                ten_hien_thi,
                anh_dai_dien,
                ngay_tao
            FROM admin
            ORDER BY ngay_tao DESC
            LIMIT 10
        `);

        console.table(admins);

        // Thống kê
        const [stats] = await db.query(`
            SELECT 
                COUNT(*) as total_admins,
                COUNT(anh_dai_dien) as admins_with_avatar,
                COUNT(*) - COUNT(anh_dai_dien) as admins_without_avatar
            FROM admin
        `);

        console.log('\n📊 Thống kê:\n');
        console.table(stats);

        console.log('\n✅ Kiểm tra hoàn tất!\n');

        process.exit(0);

    } catch (error) {
        console.error('❌ Lỗi:', error.message);
        console.error(error);
        process.exit(1);
    }
}

// Chạy script
checkAndFixAdminAvatarColumn();
