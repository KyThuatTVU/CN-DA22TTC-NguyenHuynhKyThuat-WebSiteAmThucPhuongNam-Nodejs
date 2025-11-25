const db = require('../config/database');

async function checkAPIResponse() {
    try {
        console.log('===================================');
        console.log('KIỂM TRA DỮ LIỆU API DASHBOARD');
        console.log('===================================\n');

        const today = new Date().toISOString().split('T')[0];
        const startOfMonth = new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString().split('T')[0];

        // 1. Doanh thu hôm nay
        const [revenueToday] = await db.query(`
            SELECT SUM(tong_tien) as total 
            FROM don_hang 
            WHERE DATE(thoi_gian_tao) = CURDATE() AND trang_thai = 'delivered'
        `);

        // 2. Đơn hàng mới hôm nay
        const [ordersToday] = await db.query(`
            SELECT COUNT(*) as count 
            FROM don_hang 
            WHERE DATE(thoi_gian_tao) = CURDATE()
        `);

        // 3. Đặt bàn hôm nay
        let reservationsCount = 0;
        try {
            const [reservations] = await db.query(`
                SELECT COUNT(*) as count 
                FROM dat_ban 
                WHERE DATE(ngay_dat) = CURDATE()
            `);
            reservationsCount = reservations[0].count;
        } catch (e) {
            console.warn('Bảng dat_ban không tồn tại hoặc lỗi');
        }

        // 4. Khách hàng mới tháng này
        const [newCustomers] = await db.query(`
            SELECT COUNT(*) as count 
            FROM nguoi_dung 
            WHERE DATE(ngay_tao) >= ?
        `, [startOfMonth]);

        // 5. Đơn hàng gần đây (5 đơn)
        const [recentOrders] = await db.query(`
            SELECT dh.ma_don_hang, dh.thoi_gian_tao, dh.tong_tien, dh.trang_thai,
                   COALESCE(nd.ten_nguoi_dung, dh.ten_khach_vang_lai) as ten_khach
            FROM don_hang dh
            LEFT JOIN nguoi_dung nd ON dh.ma_nguoi_dung = nd.ma_nguoi_dung
            ORDER BY dh.thoi_gian_tao DESC
            LIMIT 5
        `);

        console.log('📊 STATS:');
        console.log(JSON.stringify({
            revenueToday: revenueToday[0].total || 0,
            ordersToday: ordersToday[0].count || 0,
            reservationsToday: reservationsCount,
            newCustomersMonth: newCustomers[0].count || 0
        }, null, 2));

        console.log('\n📦 RECENT ORDERS (5 đơn):');
        console.log(JSON.stringify(recentOrders, null, 2));

        // 6. Top món ăn bán chạy
        const [topProducts] = await db.query(`
            SELECT m.ten_mon, m.anh_mon, m.gia_tien, SUM(ct.so_luong) as da_ban
            FROM chi_tiet_don_hang ct
            JOIN mon_an m ON ct.ma_mon = m.ma_mon
            GROUP BY m.ma_mon, m.ten_mon, m.anh_mon, m.gia_tien
            ORDER BY da_ban DESC
            LIMIT 5
        `);

        console.log('\n🔥 TOP PRODUCTS:');
        console.log(JSON.stringify(topProducts, null, 2));

        // 7. Doanh thu 7 ngày qua
        const [revenueChart] = await db.query(`
            SELECT DATE(thoi_gian_tao) as date, SUM(tong_tien) as total
            FROM don_hang
            WHERE thoi_gian_tao >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) 
              AND trang_thai = 'delivered'
            GROUP BY DATE(thoi_gian_tao)
            ORDER BY date ASC
        `);

        console.log('\n📈 REVENUE CHART (7 ngày):');
        console.log(JSON.stringify(revenueChart, null, 2));

        // 8. Trạng thái đơn hàng
        const [orderStatus] = await db.query(`
            SELECT trang_thai, COUNT(*) as count
            FROM don_hang
            GROUP BY trang_thai
        `);

        console.log('\n📊 ORDER STATUS:');
        console.log(JSON.stringify(orderStatus, null, 2));

        console.log('\n===================================');
        console.log('RESPONSE JSON ĐẦY ĐỦ:');
        console.log('===================================');
        const response = {
            success: true,
            data: {
                stats: {
                    revenueToday: revenueToday[0].total || 0,
                    ordersToday: ordersToday[0].count || 0,
                    reservationsToday: reservationsCount,
                    newCustomersMonth: newCustomers[0].count || 0
                },
                recentOrders,
                topProducts,
                charts: {
                    revenue: revenueChart,
                    orderStatus
                }
            }
        };
        console.log(JSON.stringify(response, null, 2));

        process.exit(0);
    } catch (error) {
        console.error('Lỗi:', error);
        process.exit(1);
    }
}

checkAPIResponse();
