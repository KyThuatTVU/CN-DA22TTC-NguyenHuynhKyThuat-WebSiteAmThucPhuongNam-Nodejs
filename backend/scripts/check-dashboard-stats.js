const db = require('../config/database');

async function checkDashboardStats() {
    try {
        const today = new Date().toISOString().split('T')[0];
        console.log('===================================');
        console.log('KIỂM TRA DỮ LIỆU DASHBOARD');
        console.log('===================================');
        console.log('Ngày hôm nay:', today);
        console.log('');

        // 1. Đơn hàng hôm nay
        const [ordersToday] = await db.query(`
            SELECT COUNT(*) as count 
            FROM don_hang 
            WHERE DATE(thoi_gian_tao) = CURDATE()
        `);
        console.log('📦 Đơn hàng hôm nay:', ordersToday[0].count);

        // 2. Doanh thu hôm nay (chỉ đơn đã giao)
        const [revenueToday] = await db.query(`
            SELECT SUM(tong_tien) as total 
            FROM don_hang 
            WHERE DATE(thoi_gian_tao) = CURDATE() AND trang_thai = 'delivered'
        `);
        console.log('💰 Doanh thu hôm nay (delivered):', revenueToday[0].total || 0, 'VND');

        // 3. Đặt bàn hôm nay
        const [reservations] = await db.query(`
            SELECT COUNT(*) as count 
            FROM dat_ban 
            WHERE DATE(ngay_dat) = CURDATE()
        `).catch(() => [{ count: 0 }]);
        console.log('🍽️  Đặt bàn hôm nay:', reservations[0]?.count || 0);

        // 4. Khách hàng mới tháng này
        const startOfMonth = new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString().split('T')[0];
        const [newCustomers] = await db.query(`
            SELECT COUNT(*) as count 
            FROM nguoi_dung 
            WHERE DATE(ngay_tao) >= ?
        `, [startOfMonth]);
        console.log('👥 Khách hàng mới tháng này:', newCustomers[0].count);

        console.log('');
        console.log('===================================');
        console.log('5 ĐỠN HÀNG GẦN NHẤT');
        console.log('===================================');

        const [recentOrders] = await db.query(`
            SELECT ma_don_hang, DATE(thoi_gian_tao) as ngay, tong_tien, trang_thai
            FROM don_hang 
            ORDER BY thoi_gian_tao DESC 
            LIMIT 5
        `);

        recentOrders.forEach(order => {
            console.log(`#${order.ma_don_hang} | ${order.ngay} | ${order.tong_tien} VND | ${order.trang_thai}`);
        });

        console.log('');
        console.log('===================================');
        console.log('THỐNG KÊ THEO TRẠNG THÁI');
        console.log('===================================');

        const [statusStats] = await db.query(`
            SELECT trang_thai, COUNT(*) as count 
            FROM don_hang 
            GROUP BY trang_thai
        `);

        statusStats.forEach(stat => {
            console.log(`${stat.trang_thai}: ${stat.count} đơn`);
        });

        process.exit(0);
    } catch (error) {
        console.error('Lỗi:', error);
        process.exit(1);
    }
}

checkDashboardStats();
