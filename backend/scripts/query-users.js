const db = require('../config/database');

async function queryUsers() {
    try {
        console.log('\n🔍 KIỂM TRA TOÀN BỘ DỮ LIỆU NGƯỜI DÙNG\n');
        console.log('═'.repeat(80));

        // 1. Đếm tổng số người dùng
        const [countResult] = await db.query('SELECT COUNT(*) as total FROM nguoi_dung');
        console.log(`\n📊 Tổng số người dùng: ${countResult[0].total}`);

        // 2. Lấy danh sách tất cả người dùng
        const [users] = await db.query(`
            SELECT 
                ma_nguoi_dung,
                ten_nguoi_dung,
                email,
                so_dien_thoai,
                dia_chi,
                gioi_tinh,
                anh_dai_dien,
                trang_thai,
                DATE_FORMAT(ngay_tao, '%d/%m/%Y %H:%i') as ngay_tao
            FROM nguoi_dung 
            ORDER BY ma_nguoi_dung
        `);

        console.log('\n📋 DANH SÁCH NGƯỜI DÙNG:\n');
        console.log('═'.repeat(80));
        
        users.forEach((user, index) => {
            console.log(`\n👤 User #${index + 1}:`);
            console.log(`   ID: ${user.ma_nguoi_dung}`);
            console.log(`   Tên: ${user.ten_nguoi_dung}`);
            console.log(`   Email: ${user.email}`);
            console.log(`   SĐT: ${user.so_dien_thoai || 'Chưa có'}`);
            console.log(`   Địa chỉ: ${user.dia_chi || 'Chưa có'}`);
            console.log(`   Giới tính: ${user.gioi_tinh}`);
            console.log(`   Ảnh đại diện: ${user.anh_dai_dien || '❌ Chưa có'}`);
            console.log(`   Trạng thái: ${user.trang_thai === 1 ? '✅ Hoạt động' : '❌ Khóa'}`);
            console.log(`   Ngày tạo: ${user.ngay_tao}`);
            console.log('   ' + '─'.repeat(76));
        });

        // 3. Thống kê
        console.log('\n📈 THỐNG KÊ:\n');
        console.log('═'.repeat(80));

        const [stats] = await db.query(`
            SELECT 
                COUNT(*) as total,
                SUM(CASE WHEN trang_thai = 1 THEN 1 ELSE 0 END) as active,
                SUM(CASE WHEN anh_dai_dien IS NOT NULL THEN 1 ELSE 0 END) as has_avatar,
                SUM(CASE WHEN gioi_tinh = 'nam' THEN 1 ELSE 0 END) as male,
                SUM(CASE WHEN gioi_tinh = 'nu' THEN 1 ELSE 0 END) as female
            FROM nguoi_dung
        `);

        const stat = stats[0];
        console.log(`   Tổng số user: ${stat.total}`);
        console.log(`   Đang hoạt động: ${stat.active} (${Math.round(stat.active/stat.total*100)}%)`);
        console.log(`   Có ảnh đại diện: ${stat.has_avatar} (${Math.round(stat.has_avatar/stat.total*100)}%)`);
        console.log(`   Nam: ${stat.male} | Nữ: ${stat.female}`);

        // 4. Kiểm tra mật khẩu
        console.log('\n🔐 KIỂM TRA MẬT KHẨU:\n');
        console.log('═'.repeat(80));
        
        const [passCheck] = await db.query(`
            SELECT 
                ma_nguoi_dung,
                ten_nguoi_dung,
                email,
                CASE 
                    WHEN mat_khau_hash IS NULL THEN '❌ Chưa có'
                    WHEN LENGTH(mat_khau_hash) < 50 THEN '⚠️ Ngắn (có thể lỗi)'
                    ELSE '✅ Có'
                END as trang_thai_password,
                LENGTH(mat_khau_hash) as do_dai_hash
            FROM nguoi_dung
            ORDER BY ma_nguoi_dung
        `);

        passCheck.forEach(user => {
            console.log(`   ${user.ten_nguoi_dung} (${user.email}): ${user.trang_thai_password} - ${user.do_dai_hash || 0} ký tự`);
        });

        console.log('\n' + '═'.repeat(80));
        console.log('✅ Hoàn thành!\n');

        process.exit(0);
    } catch (error) {
        console.error('\n❌ Lỗi:', error.message);
        console.error(error.stack);
        process.exit(1);
    }
}

queryUsers();
