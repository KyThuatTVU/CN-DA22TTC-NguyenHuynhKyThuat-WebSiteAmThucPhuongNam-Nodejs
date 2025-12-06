const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Tự động tạo các bảng mục tiêu nếu chưa tồn tại
async function initTables() {
    try {
        // Bảng mục tiêu tháng (cũ)
        await db.query(`
            CREATE TABLE IF NOT EXISTS muc_tieu_thang (
                id INT NOT NULL AUTO_INCREMENT,
                thang INT NOT NULL,
                nam INT NOT NULL,
                muc_tieu_doanh_thu DECIMAL(15,2) NOT NULL DEFAULT 0,
                muc_tieu_don_hang INT NOT NULL DEFAULT 0,
                muc_tieu_khach_hang INT DEFAULT 0,
                muc_tieu_dat_ban INT DEFAULT 0,
                ghi_chu TEXT,
                ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                PRIMARY KEY (id),
                UNIQUE KEY thang_nam (thang, nam)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        `);
        
        // Bảng mục tiêu chi tiết (5 mục tiêu)
        await db.query(`
            CREATE TABLE IF NOT EXISTS muc_tieu_chi_tiet (
                id INT NOT NULL AUTO_INCREMENT,
                thang INT NOT NULL,
                nam INT NOT NULL,
                loai_muc_tieu ENUM('doanh_thu', 'don_hang', 'khach_hang_moi', 'dat_ban', 'danh_gia') NOT NULL,
                ten_muc_tieu VARCHAR(255) NOT NULL,
                mo_ta TEXT,
                gia_tri_muc_tieu DECIMAL(15,2) NOT NULL DEFAULT 0,
                don_vi VARCHAR(50) DEFAULT 'đơn vị',
                icon VARCHAR(50) DEFAULT '🎯',
                thu_tu INT DEFAULT 1,
                ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                PRIMARY KEY (id),
                UNIQUE KEY thang_nam_loai (thang, nam, loai_muc_tieu)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        `);
        
        console.log('✅ Các bảng mục tiêu đã sẵn sàng');
    } catch (error) {
        console.error('❌ Lỗi tạo bảng:', error.message);
    }
}

// Gọi hàm khởi tạo khi module được load
initTables();

// Middleware kiểm tra admin
const requireAdmin = (req, res, next) => {
    if (req.session && req.session.admin) {
        next();
    } else {
        res.status(401).json({ success: false, message: 'Unauthorized' });
    }
};

// Lấy dữ liệu thống kê tổng hợp cho AI phân tích
async function getBusinessStats() {
    const currentDate = new Date();
    const currentMonth = currentDate.getMonth() + 1;
    const currentYear = currentDate.getFullYear();
    
    // Tháng trước
    let prevMonth = currentMonth - 1;
    let prevYear = currentYear;
    if (prevMonth === 0) {
        prevMonth = 12;
        prevYear = currentYear - 1;
    }

    try {
        // Doanh thu tháng này
        const [revenueThisMonth] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [currentMonth, currentYear]);

        // Doanh thu tháng trước
        const [revenueLastMonth] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [prevMonth, prevYear]);

        // Số đơn hàng tháng này
        const [ordersThisMonth] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [currentMonth, currentYear]);

        // Số đơn hàng tháng trước
        const [ordersLastMonth] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [prevMonth, prevYear]);

        // Khách hàng mới tháng này
        const [customersThisMonth] = await db.query(`
            SELECT COUNT(*) as total FROM nguoi_dung 
            WHERE MONTH(ngay_tao) = ? AND YEAR(ngay_tao) = ?
        `, [currentMonth, currentYear]);

        // Đặt bàn tháng này
        const [reservationsThisMonth] = await db.query(`
            SELECT COUNT(*) as total FROM dat_ban 
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
        `, [currentMonth, currentYear]);

        // Top 5 món bán chạy tháng này
        const [topProducts] = await db.query(`
            SELECT m.ten_mon, SUM(ct.so_luong) as so_luong_ban
            FROM chi_tiet_don_hang ct
            JOIN mon_an m ON ct.ma_mon = m.ma_mon
            JOIN don_hang dh ON ct.ma_don_hang = dh.ma_don_hang
            WHERE MONTH(dh.thoi_gian_tao) = ? AND YEAR(dh.thoi_gian_tao) = ? AND dh.trang_thai = 'delivered'
            GROUP BY m.ma_mon, m.ten_mon
            ORDER BY so_luong_ban DESC
            LIMIT 5
        `, [currentMonth, currentYear]);

        // Món ít bán nhất
        const [lowProducts] = await db.query(`
            SELECT m.ten_mon, COALESCE(SUM(ct.so_luong), 0) as so_luong_ban
            FROM mon_an m
            LEFT JOIN chi_tiet_don_hang ct ON m.ma_mon = ct.ma_mon
            LEFT JOIN don_hang dh ON ct.ma_don_hang = dh.ma_don_hang 
                AND MONTH(dh.thoi_gian_tao) = ? AND YEAR(dh.thoi_gian_tao) = ? AND dh.trang_thai = 'delivered'
            WHERE m.trang_thai = 1
            GROUP BY m.ma_mon, m.ten_mon
            ORDER BY so_luong_ban ASC
            LIMIT 5
        `, [currentMonth, currentYear]);

        // Đánh giá trung bình
        const [avgRating] = await db.query(`
            SELECT AVG(so_sao) as avg_rating, COUNT(*) as total_reviews FROM danh_gia_san_pham
            WHERE trang_thai = 'approved'
        `);

        // Đơn hàng theo trạng thái
        const [ordersByStatus] = await db.query(`
            SELECT trang_thai, COUNT(*) as count FROM don_hang
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
            GROUP BY trang_thai
        `, [currentMonth, currentYear]);

        // Giờ cao điểm đặt bàn
        const [peakHours] = await db.query(`
            SELECT HOUR(gio_den) as hour, COUNT(*) as count FROM dat_ban
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
            GROUP BY HOUR(gio_den)
            ORDER BY count DESC
            LIMIT 3
        `, [currentMonth, currentYear]);

        // Lấy mục tiêu tháng hiện tại (xử lý trường hợp bảng chưa tồn tại)
        let targetData = [null];
        try {
            const [target] = await db.query(`
                SELECT * FROM muc_tieu_thang 
                WHERE thang = ? AND nam = ?
            `, [currentMonth, currentYear]);
            targetData = target;
        } catch (err) {
            console.log('Bảng muc_tieu_thang chưa tồn tại, bỏ qua...');
            targetData = [];
        }
        
        // Lấy 5 mục tiêu chi tiết
        let goalsData = [];
        try {
            const [goals] = await db.query(`
                SELECT * FROM muc_tieu_chi_tiet 
                WHERE thang = ? AND nam = ?
                ORDER BY thu_tu ASC
            `, [currentMonth, currentYear]);
            
            // Tính tiến độ cho từng mục tiêu
            const actualData = {
                doanh_thu: revenueThisMonth[0].total,
                don_hang: ordersThisMonth[0].total,
                khach_hang_moi: customersThisMonth[0].total,
                dat_ban: reservationsThisMonth[0].total,
                danh_gia: avgRating[0].total_reviews || 0
            };
            
            goalsData = goals.map(goal => {
                const actual = actualData[goal.loai_muc_tieu] || 0;
                const target = parseFloat(goal.gia_tri_muc_tieu) || 1;
                const progress = Math.min(100, Math.round((actual / target) * 100));
                
                return {
                    ...goal,
                    gia_tri_hien_tai: actual,
                    tien_do: progress
                };
            });
        } catch (err) {
            console.log('Bảng muc_tieu_chi_tiet chưa tồn tại, bỏ qua...');
            goalsData = [];
        }

        return {
            currentMonth,
            currentYear,
            revenue: {
                thisMonth: revenueThisMonth[0].total,
                lastMonth: revenueLastMonth[0].total,
                change: revenueLastMonth[0].total > 0 
                    ? ((revenueThisMonth[0].total - revenueLastMonth[0].total) / revenueLastMonth[0].total * 100).toFixed(1)
                    : 0
            },
            orders: {
                thisMonth: ordersThisMonth[0].total,
                lastMonth: ordersLastMonth[0].total
            },
            customers: {
                newThisMonth: customersThisMonth[0].total
            },
            reservations: {
                thisMonth: reservationsThisMonth[0].total
            },
            topProducts,
            lowProducts,
            avgRating: avgRating[0].avg_rating || 0,
            totalReviews: avgRating[0].total_reviews || 0,
            ordersByStatus,
            peakHours,
            target: (targetData && targetData[0]) || null,
            goals: goalsData
        };
    } catch (error) {
        console.error('Error getting business stats:', error);
        return null;
    }
}

// Phân tích và tạo phản hồi AI
function generateAIResponse(query, stats) {
    const queryLower = query.toLowerCase();
    
    // Format số tiền
    const formatMoney = (amount) => new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
    
    // Phân tích câu hỏi và tạo phản hồi
    
    // Báo cáo tổng quan
    if (queryLower.includes('báo cáo') || queryLower.includes('tổng quan') || queryLower.includes('tình hình')) {
        const revenueChange = parseFloat(stats.revenue.change);
        const trend = revenueChange >= 0 ? '📈 tăng' : '📉 giảm';
        
        return {
            type: 'report',
            message: `📊 **BÁO CÁO THÁNG ${stats.currentMonth}/${stats.currentYear}**\n\n` +
                `💰 **Doanh thu:** ${formatMoney(stats.revenue.thisMonth)}\n` +
                `   → ${trend} ${Math.abs(revenueChange)}% so với tháng trước\n\n` +
                `📦 **Đơn hàng:** ${stats.orders.thisMonth} đơn\n` +
                `👥 **Khách hàng mới:** ${stats.customers.newThisMonth} người\n` +
                `🍽️ **Đặt bàn:** ${stats.reservations.thisMonth} lượt\n` +
                `⭐ **Đánh giá TB:** ${parseFloat(stats.avgRating).toFixed(1)}/5 (${stats.totalReviews} đánh giá)\n\n` +
                `🏆 **Top món bán chạy:**\n` +
                stats.topProducts.map((p, i) => `   ${i+1}. ${p.ten_mon} (${p.so_luong_ban} phần)`).join('\n'),
            suggestions: ['Đề xuất chiến lược', 'Phân tích chi tiết', 'Đặt mục tiêu tháng']
        };
    }
    
    // Doanh thu
    if (queryLower.includes('doanh thu')) {
        const revenueChange = parseFloat(stats.revenue.change);
        let analysis = '';
        
        if (revenueChange > 20) {
            analysis = '🎉 Doanh thu tăng trưởng xuất sắc! Hãy duy trì chiến lược hiện tại.';
        } else if (revenueChange > 0) {
            analysis = '👍 Doanh thu tăng nhẹ. Có thể đẩy mạnh marketing để tăng tốc.';
        } else if (revenueChange > -10) {
            analysis = '⚠️ Doanh thu giảm nhẹ. Cần xem xét các chương trình khuyến mãi.';
        } else {
            analysis = '🚨 Doanh thu giảm đáng kể. Cần có chiến lược cải thiện ngay!';
        }
        
        return {
            type: 'revenue',
            message: `💰 **PHÂN TÍCH DOANH THU**\n\n` +
                `Tháng này: ${formatMoney(stats.revenue.thisMonth)}\n` +
                `Tháng trước: ${formatMoney(stats.revenue.lastMonth)}\n` +
                `Thay đổi: ${revenueChange >= 0 ? '+' : ''}${revenueChange}%\n\n` +
                `📝 **Nhận xét:** ${analysis}`,
            suggestions: ['Đề xuất tăng doanh thu', 'Xem món bán chạy', 'Đặt mục tiêu']
        };
    }
    
    // Chiến lược / Đề xuất
    if (queryLower.includes('chiến lược') || queryLower.includes('đề xuất') || queryLower.includes('tăng doanh thu')) {
        const strategies = [];
        
        // Phân tích và đề xuất dựa trên dữ liệu
        if (stats.lowProducts && stats.lowProducts.length > 0) {
            const lowSelling = stats.lowProducts.filter(p => p.so_luong_ban < 5);
            if (lowSelling.length > 0) {
                strategies.push(`🍽️ **Khuyến mãi món ít bán:** ${lowSelling.map(p => p.ten_mon).join(', ')} - Giảm giá 20-30% hoặc combo với món bán chạy`);
            }
        }
        
        if (stats.peakHours && stats.peakHours.length > 0) {
            const peakHour = stats.peakHours[0].hour;
            strategies.push(`⏰ **Tối ưu giờ cao điểm:** Khung giờ ${peakHour}h-${peakHour+2}h có nhiều khách nhất. Tăng nhân viên và chuẩn bị nguyên liệu.`);
        }
        
        if (stats.customers.newThisMonth < 10) {
            strategies.push(`👥 **Thu hút khách mới:** Chạy chương trình "Giới thiệu bạn bè" - Tặng voucher 50k cho cả người giới thiệu và người mới.`);
        }
        
        if (stats.avgRating < 4) {
            strategies.push(`⭐ **Cải thiện đánh giá:** Đánh giá TB ${parseFloat(stats.avgRating).toFixed(1)}/5 cần cải thiện. Tập trung chất lượng món ăn và dịch vụ.`);
        }
        
        strategies.push(`📱 **Marketing online:** Đăng bài thường xuyên trên Facebook/TikTok với hình ảnh món ăn hấp dẫn.`);
        strategies.push(`🎁 **Chương trình thành viên:** Tích điểm đổi quà, giảm giá cho khách quen.`);
        
        return {
            type: 'strategy',
            message: `🎯 **ĐỀ XUẤT CHIẾN LƯỢC THÁNG ${stats.currentMonth}**\n\n` +
                strategies.join('\n\n'),
            suggestions: ['Đặt mục tiêu cụ thể', 'Xem báo cáo chi tiết', 'Phân tích đối thủ']
        };
    }
    
    // Mục tiêu - hiển thị 5 mục tiêu chi tiết
    if (queryLower.includes('mục tiêu') || queryLower.includes('target') || queryLower.includes('kpi') || queryLower.includes('tiến độ')) {
        // Nếu có goals chi tiết
        if (stats.goals && stats.goals.length > 0) {
            const goalsText = stats.goals.map(g => {
                const statusIcon = g.tien_do >= 100 ? '✅' : g.tien_do >= 70 ? '🔥' : g.tien_do >= 40 ? '⚡' : '🎯';
                const valueText = g.loai_muc_tieu === 'doanh_thu' 
                    ? `${formatMoney(g.gia_tri_hien_tai)} / ${formatMoney(g.gia_tri_muc_tieu)}`
                    : `${g.gia_tri_hien_tai} / ${g.gia_tri_muc_tieu} ${g.don_vi}`;
                return `${g.icon} **${g.ten_muc_tieu}:** ${valueText} (${statusIcon} ${g.tien_do}%)`;
            }).join('\n');
            
            const totalProgress = Math.round(stats.goals.reduce((sum, g) => sum + g.tien_do, 0) / stats.goals.length);
            const completedCount = stats.goals.filter(g => g.tien_do >= 100).length;
            
            return {
                type: 'goals',
                message: `🎯 **5 MỤC TIÊU THÁNG ${stats.currentMonth}/${stats.currentYear}**\n\n` +
                    goalsText + `\n\n` +
                    `📊 **Tổng tiến độ:** ${totalProgress}%\n` +
                    `✅ **Hoàn thành:** ${completedCount}/5 mục tiêu\n\n` +
                    `💡 *Mục tiêu đã được tạo cho tháng này. Hãy hỏi "đề xuất chiến lược" để cải thiện!*`,
                suggestions: ['Đề xuất chiến lược', 'Xem báo cáo', 'Món bán chạy']
            };
        }
        
        // Nếu chưa có goals, đề xuất tạo mới
        return {
            type: 'no_goals',
            message: `🎯 **CHƯA CÓ MỤC TIÊU THÁNG ${stats.currentMonth}**\n\n` +
                `Bạn chưa đặt mục tiêu cho tháng này.\n\n` +
                `Tôi có thể tự động tạo 5 mục tiêu dựa trên dữ liệu tháng trước:\n` +
                `💰 Doanh thu (tăng 15%)\n` +
                `📦 Số đơn hàng (tăng 20%)\n` +
                `👥 Khách hàng mới (tăng 25%)\n` +
                `🍽️ Lượt đặt bàn (tăng 15%)\n` +
                `⭐ Đánh giá tích cực (tăng 30%)\n\n` +
                `Nhấn nút "AI Tạo mục tiêu" trên dashboard hoặc nói "tạo mục tiêu" để bắt đầu!`,
            suggestions: ['Tạo mục tiêu', 'Xem báo cáo', 'Đề xuất chiến lược'],
            action: 'generate_goals'
        };
    }
    
    // Tạo mục tiêu - kiểm tra xem đã có chưa
    if (queryLower.includes('tạo mục tiêu') || queryLower.includes('đặt mục tiêu')) {
        // Nếu đã có mục tiêu, không cho tạo mới
        if (stats.goals && stats.goals.length > 0) {
            return {
                type: 'info',
                message: `⚠️ **MỤC TIÊU ĐÃ ĐƯỢC TẠO**\n\n` +
                    `Tháng ${stats.currentMonth}/${stats.currentYear} đã có 5 mục tiêu.\n` +
                    `Mỗi tháng chỉ được tạo mục tiêu 1 lần để đảm bảo tính nhất quán.\n\n` +
                    `Bạn có thể:\n` +
                    `• Xem tiến độ hiện tại\n` +
                    `• Nhờ AI đề xuất chiến lược cải thiện\n` +
                    `• Chờ sang tháng mới để tạo mục tiêu mới`,
                suggestions: ['Xem tiến độ mục tiêu', 'Đề xuất chiến lược', 'Báo cáo tháng này']
            };
        }
        
        return {
            type: 'action',
            message: `🎯 **TẠO MỤC TIÊU TỰ ĐỘNG**\n\n` +
                `Tôi sẽ phân tích dữ liệu tháng trước và tạo 5 mục tiêu phù hợp cho tháng ${stats.currentMonth}.\n\n` +
                `⚠️ **Lưu ý:** Mỗi tháng chỉ được tạo mục tiêu 1 lần!\n\n` +
                `Nhấn nút bên dưới để bắt đầu:`,
            suggestions: ['Xem báo cáo', 'Đề xuất chiến lược'],
            action: 'generate_goals',
            showGenerateButton: true
        };
    }
    
    // Đề xuất chiến lược dựa trên tình hình thực tế
    if (queryLower.includes('chiến lược') || queryLower.includes('đề xuất') || queryLower.includes('cải thiện') || queryLower.includes('strategy')) {
        const strategies = [];
        
        if (stats.goals && stats.goals.length > 0) {
            // Phân tích từng mục tiêu và đề xuất
            const lowGoals = stats.goals.filter(g => g.tien_do < 50);
            const mediumGoals = stats.goals.filter(g => g.tien_do >= 50 && g.tien_do < 80);
            const highGoals = stats.goals.filter(g => g.tien_do >= 80);
            
            strategies.push(`📊 **PHÂN TÍCH TÌNH HÌNH THÁNG ${stats.currentMonth}**`);
            
            if (lowGoals.length > 0) {
                strategies.push(`\n🔴 **Cần cải thiện gấp (< 50%):**`);
                lowGoals.forEach(g => {
                    strategies.push(`• ${g.icon} ${g.ten_muc_tieu}: ${g.tien_do}%`);
                    // Đề xuất cụ thể cho từng loại
                    if (g.loai_muc_tieu === 'doanh_thu') {
                        strategies.push(`  → Tăng cường khuyến mãi, combo tiết kiệm`);
                        strategies.push(`  → Đẩy mạnh marketing trên mạng xã hội`);
                    } else if (g.loai_muc_tieu === 'don_hang') {
                        strategies.push(`  → Giảm giá ship, miễn phí ship đơn từ 200k`);
                        strategies.push(`  → Tạo flash sale vào giờ cao điểm`);
                    } else if (g.loai_muc_tieu === 'khach_hang_moi') {
                        strategies.push(`  → Chương trình giới thiệu bạn bè`);
                        strategies.push(`  → Ưu đãi khách hàng mới lần đầu`);
                    } else if (g.loai_muc_tieu === 'dat_ban') {
                        strategies.push(`  → Ưu đãi đặt bàn trước 2 ngày`);
                        strategies.push(`  → Combo đặt bàn + món đặc biệt`);
                    } else if (g.loai_muc_tieu === 'danh_gia') {
                        strategies.push(`  → Tặng voucher cho khách đánh giá`);
                        strategies.push(`  → Nhắc nhở khách sau khi hoàn thành đơn`);
                    }
                });
            }
            
            if (mediumGoals.length > 0) {
                strategies.push(`\n🟡 **Đang tiến triển (50-80%):**`);
                mediumGoals.forEach(g => {
                    strategies.push(`• ${g.icon} ${g.ten_muc_tieu}: ${g.tien_do}% - Tiếp tục duy trì!`);
                });
            }
            
            if (highGoals.length > 0) {
                strategies.push(`\n🟢 **Sắp hoàn thành (> 80%):**`);
                highGoals.forEach(g => {
                    strategies.push(`• ${g.icon} ${g.ten_muc_tieu}: ${g.tien_do}% - Tuyệt vời! 🎉`);
                });
            }
            
            // Đề xuất tổng hợp
            const totalProgress = Math.round(stats.goals.reduce((sum, g) => sum + g.tien_do, 0) / stats.goals.length);
            strategies.push(`\n💡 **TỔNG KẾT:**`);
            strategies.push(`Tiến độ tổng: ${totalProgress}%`);
            
            if (totalProgress < 50) {
                strategies.push(`\n⚡ **Hành động ngay:**`);
                strategies.push(`1. Tập trung vào ${lowGoals.length} mục tiêu đang thấp`);
                strategies.push(`2. Chạy chương trình khuyến mãi cuối tháng`);
                strategies.push(`3. Tăng cường quảng cáo trên Facebook/Zalo`);
            } else if (totalProgress < 80) {
                strategies.push(`\n📈 **Đề xuất:**`);
                strategies.push(`1. Duy trì đà tăng trưởng hiện tại`);
                strategies.push(`2. Tập trung cải thiện các mục tiêu dưới 70%`);
            } else {
                strategies.push(`\n🎯 **Xuất sắc!** Tiếp tục phát huy!`);
            }
        } else {
            strategies.push(`📊 **CHƯA CÓ MỤC TIÊU**\n`);
            strategies.push(`Hãy tạo mục tiêu trước để AI có thể đề xuất chiến lược phù hợp.`);
        }
        
        return {
            type: 'strategy',
            message: strategies.join('\n'),
            suggestions: ['Xem tiến độ mục tiêu', 'Báo cáo doanh thu', 'Món bán chạy']
        };
    }
    
    // Món bán chạy
    if (queryLower.includes('món bán chạy') || queryLower.includes('top') || queryLower.includes('best seller')) {
        return {
            type: 'products',
            message: `🏆 **TOP MÓN BÁN CHẠY THÁNG ${stats.currentMonth}**\n\n` +
                stats.topProducts.map((p, i) => {
                    const medal = i === 0 ? '🥇' : i === 1 ? '🥈' : i === 2 ? '🥉' : `${i+1}.`;
                    return `${medal} ${p.ten_mon}: ${p.so_luong_ban} phần`;
                }).join('\n') +
                `\n\n📉 **Món cần đẩy mạnh:**\n` +
                stats.lowProducts.slice(0, 3).map(p => `   • ${p.ten_mon} (${p.so_luong_ban} phần)`).join('\n'),
            suggestions: ['Đề xuất khuyến mãi', 'Xem doanh thu', 'Chiến lược marketing']
        };
    }
    
    // Mặc định - hướng dẫn
    return {
        type: 'help',
        message: `👋 **Xin chào! Tôi là trợ lý AI của bạn.**\n\n` +
            `Tôi có thể giúp bạn:\n` +
            `📊 Xem báo cáo tổng quan\n` +
            `💰 Phân tích doanh thu\n` +
            `🎯 Đặt và theo dõi mục tiêu\n` +
            `📈 Đề xuất chiến lược kinh doanh\n` +
            `🍽️ Phân tích món ăn bán chạy\n\n` +
            `Hãy hỏi tôi bất cứ điều gì!`,
        suggestions: ['Báo cáo tháng này', 'Đề xuất chiến lược', 'Đặt mục tiêu', 'Món bán chạy']
    };
}

// API: Chat với AI
router.post('/chat', requireAdmin, async (req, res) => {
    try {
        const { message } = req.body;
        
        if (!message) {
            return res.status(400).json({ success: false, message: 'Thiếu nội dung tin nhắn' });
        }
        
        // Lấy dữ liệu thống kê
        const stats = await getBusinessStats();
        
        if (!stats) {
            return res.status(500).json({ success: false, message: 'Không thể lấy dữ liệu thống kê' });
        }
        
        // Tạo phản hồi AI
        const response = generateAIResponse(message, stats);
        
        res.json({
            success: true,
            data: response
        });
    } catch (error) {
        console.error('Error in admin chatbot:', error);
        res.status(500).json({ success: false, message: 'Lỗi xử lý tin nhắn' });
    }
});

// API: Lấy mục tiêu tháng hiện tại
router.get('/target', requireAdmin, async (req, res) => {
    try {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        // Xử lý trường hợp bảng chưa tồn tại
        let target = [];
        try {
            const [result] = await db.query(`
                SELECT * FROM muc_tieu_thang WHERE thang = ? AND nam = ?
            `, [currentMonth, currentYear]);
            target = result;
        } catch (err) {
            console.log('Bảng muc_tieu_thang chưa tồn tại');
            target = [];
        }
        
        // Lấy doanh thu và đơn hàng hiện tại
        const [revenue] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [currentMonth, currentYear]);
        
        const [orders] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [currentMonth, currentYear]);
        
        res.json({
            success: true,
            data: {
                target: target[0] || null,
                current: {
                    revenue: revenue[0].total,
                    orders: orders[0].total
                },
                month: currentMonth,
                year: currentYear
            }
        });
    } catch (error) {
        console.error('Error getting target:', error);
        res.status(500).json({ success: false, message: 'Lỗi lấy mục tiêu' });
    }
});

// API: Đặt/Cập nhật mục tiêu tháng
router.post('/target', requireAdmin, async (req, res) => {
    try {
        const { muc_tieu_doanh_thu, muc_tieu_don_hang, ghi_chu } = req.body;
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        // Upsert mục tiêu
        await db.query(`
            INSERT INTO muc_tieu_thang (thang, nam, muc_tieu_doanh_thu, muc_tieu_don_hang, ghi_chu)
            VALUES (?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE 
                muc_tieu_doanh_thu = VALUES(muc_tieu_doanh_thu),
                muc_tieu_don_hang = VALUES(muc_tieu_don_hang),
                ghi_chu = VALUES(ghi_chu),
                ngay_cap_nhat = CURRENT_TIMESTAMP
        `, [currentMonth, currentYear, muc_tieu_doanh_thu, muc_tieu_don_hang, ghi_chu || null]);
        
        res.json({
            success: true,
            message: 'Đã cập nhật mục tiêu tháng'
        });
    } catch (error) {
        console.error('Error setting target:', error);
        res.status(500).json({ success: false, message: 'Lỗi đặt mục tiêu: ' + error.message });
    }
});

// API: Lấy dữ liệu cho biểu đồ gauge (tỷ lệ hoàn thành)
router.get('/gauge-data', requireAdmin, async (req, res) => {
    try {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        // Lấy mục tiêu (xử lý trường hợp bảng chưa tồn tại)
        let target = [];
        try {
            const [result] = await db.query(`
                SELECT * FROM muc_tieu_thang WHERE thang = ? AND nam = ?
            `, [currentMonth, currentYear]);
            target = result;
        } catch (err) {
            console.log('Bảng muc_tieu_thang chưa tồn tại');
            target = [];
        }
        
        // Lấy doanh thu hiện tại
        const [revenue] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [currentMonth, currentYear]);
        
        let percentage = 0;
        let targetAmount = 100000000; // Mặc định 100 triệu
        
        if (target[0] && target[0].muc_tieu_doanh_thu > 0) {
            targetAmount = target[0].muc_tieu_doanh_thu;
            percentage = Math.min(100, Math.round((revenue[0].total / targetAmount) * 100));
        } else {
            percentage = Math.min(100, Math.round((revenue[0].total / targetAmount) * 100));
        }
        
        res.json({
            success: true,
            data: {
                percentage,
                current: revenue[0].total,
                target: targetAmount,
                hasTarget: !!target[0]
            }
        });
    } catch (error) {
        console.error('Error getting gauge data:', error);
        res.status(500).json({ success: false, message: 'Lỗi lấy dữ liệu' });
    }
});

// API: Lấy 5 mục tiêu chi tiết với tiến độ thực tế
router.get('/goals', requireAdmin, async (req, res) => {
    try {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        // Lấy mục tiêu đã lưu
        let goals = [];
        try {
            const [result] = await db.query(`
                SELECT * FROM muc_tieu_chi_tiet 
                WHERE thang = ? AND nam = ?
                ORDER BY thu_tu ASC
            `, [currentMonth, currentYear]);
            goals = result;
        } catch (err) {
            goals = [];
        }
        
        // Lấy dữ liệu thực tế từ database
        const [revenueData] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [currentMonth, currentYear]);
        
        const [ordersData] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [currentMonth, currentYear]);
        
        const [customersData] = await db.query(`
            SELECT COUNT(*) as total FROM nguoi_dung 
            WHERE MONTH(ngay_tao) = ? AND YEAR(ngay_tao) = ?
        `, [currentMonth, currentYear]);
        
        const [reservationsData] = await db.query(`
            SELECT COUNT(*) as total FROM dat_ban 
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
        `, [currentMonth, currentYear]);
        
        const [reviewsData] = await db.query(`
            SELECT COUNT(*) as total FROM danh_gia_san_pham 
            WHERE MONTH(ngay_danh_gia) = ? AND YEAR(ngay_danh_gia) = ? AND trang_thai = 'approved'
        `, [currentMonth, currentYear]);
        
        // Map dữ liệu thực tế
        const actualData = {
            doanh_thu: parseFloat(revenueData[0].total) || 0,
            don_hang: parseInt(ordersData[0].total) || 0,
            khach_hang_moi: parseInt(customersData[0].total) || 0,
            dat_ban: parseInt(reservationsData[0].total) || 0,
            danh_gia: parseInt(reviewsData[0].total) || 0
        };
        
        // Nếu chưa có mục tiêu, trả về mảng rỗng với dữ liệu thực tế
        if (goals.length === 0) {
            res.json({
                success: true,
                data: {
                    goals: [],
                    actual: actualData,
                    totalProgress: 0,
                    month: currentMonth,
                    year: currentYear,
                    hasGoals: false
                }
            });
            return;
        }
        
        // Tính tiến độ cho từng mục tiêu
        const goalsWithProgress = goals.map(goal => {
            const actual = actualData[goal.loai_muc_tieu] || 0;
            const target = parseFloat(goal.gia_tri_muc_tieu) || 1;
            const progress = Math.min(100, Math.round((actual / target) * 100));
            
            return {
                ...goal,
                gia_tri_hien_tai: actual,
                tien_do: progress,
                hoan_thanh: progress >= 100
            };
        });
        
        // Tính tổng tiến độ
        const totalProgress = goalsWithProgress.length > 0 
            ? Math.round(goalsWithProgress.reduce((sum, g) => sum + g.tien_do, 0) / goalsWithProgress.length)
            : 0;
        
        res.json({
            success: true,
            data: {
                goals: goalsWithProgress,
                actual: actualData,
                totalProgress,
                month: currentMonth,
                year: currentYear,
                hasGoals: true
            }
        });
    } catch (error) {
        console.error('Error getting goals:', error);
        res.status(500).json({ success: false, message: 'Lỗi lấy mục tiêu: ' + error.message });
    }
});

// API: AI tự động tạo 5 mục tiêu dựa trên dữ liệu tháng trước
// CHỈ CHO PHÉP TẠO 1 LẦN/THÁNG
router.post('/goals/generate', requireAdmin, async (req, res) => {
    try {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        // Kiểm tra xem đã có mục tiêu cho tháng này chưa
        const [existingGoals] = await db.query(`
            SELECT COUNT(*) as count FROM muc_tieu_chi_tiet 
            WHERE thang = ? AND nam = ?
        `, [currentMonth, currentYear]);
        
        if (existingGoals[0].count > 0) {
            return res.status(400).json({
                success: false,
                message: `Mục tiêu tháng ${currentMonth}/${currentYear} đã được tạo. Mỗi tháng chỉ được tạo mục tiêu 1 lần. Bạn có thể xem tiến độ hoặc nhờ AI đề xuất chiến lược cải thiện.`,
                alreadyExists: true
            });
        }
        
        // Tháng trước
        let prevMonth = currentMonth - 1;
        let prevYear = currentYear;
        if (prevMonth === 0) {
            prevMonth = 12;
            prevYear = currentYear - 1;
        }
        
        // Lấy dữ liệu tháng trước
        const [prevRevenue] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [prevMonth, prevYear]);
        
        const [prevOrders] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [prevMonth, prevYear]);
        
        const [prevCustomers] = await db.query(`
            SELECT COUNT(*) as total FROM nguoi_dung 
            WHERE MONTH(ngay_tao) = ? AND YEAR(ngay_tao) = ?
        `, [prevMonth, prevYear]);
        
        const [prevReservations] = await db.query(`
            SELECT COUNT(*) as total FROM dat_ban 
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
        `, [prevMonth, prevYear]);
        
        const [prevReviews] = await db.query(`
            SELECT COUNT(*) as total FROM danh_gia_san_pham 
            WHERE MONTH(ngay_danh_gia) = ? AND YEAR(ngay_danh_gia) = ? AND trang_thai = 'approved'
        `, [prevMonth, prevYear]);
        
        // Lấy dữ liệu hiện tại của tháng này để phân tích
        const [currentRevenue] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [currentMonth, currentYear]);
        
        const [currentOrders] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [currentMonth, currentYear]);
        
        // Tính số ngày đã qua trong tháng và số ngày còn lại
        const dayOfMonth = currentDate.getDate();
        const daysInMonth = new Date(currentYear, currentMonth, 0).getDate();
        const daysRemaining = daysInMonth - dayOfMonth;
        const progressRatio = dayOfMonth / daysInMonth; // Tỷ lệ thời gian đã qua
        
        // Phân tích dữ liệu tháng trước
        const prevRevenueVal = parseFloat(prevRevenue[0].total) || 0;
        const prevOrdersVal = parseInt(prevOrders[0].total) || 0;
        const prevCustomersVal = parseInt(prevCustomers[0].total) || 0;
        const prevReservationsVal = parseInt(prevReservations[0].total) || 0;
        const prevReviewsVal = parseInt(prevReviews[0].total) || 0;
        
        // Dữ liệu hiện tại
        const currentRevenueVal = parseFloat(currentRevenue[0].total) || 0;
        const currentOrdersVal = parseInt(currentOrders[0].total) || 0;
        
        // AI phân tích và đề xuất mục tiêu thông minh
        // Nếu có dữ liệu tháng trước -> tăng 10-15%
        // Nếu không có -> dựa trên dữ liệu hiện tại ước tính cả tháng
        // Nếu cả 2 đều không có -> đặt mục tiêu khởi đầu hợp lý
        
        let targetRevenue, targetOrders, targetCustomers, targetReservations, targetReviews;
        let revenueDesc, ordersDesc, customersDesc, reservationsDesc, reviewsDesc;
        
        // Doanh thu
        if (prevRevenueVal > 0) {
            targetRevenue = Math.round(prevRevenueVal * 1.1 / 1000000) * 1000000; // Tăng 10%, làm tròn triệu
            revenueDesc = `Tăng 10% so với tháng trước (${new Intl.NumberFormat('vi-VN').format(prevRevenueVal)}đ)`;
        } else if (currentRevenueVal > 0 && progressRatio > 0.1) {
            // Ước tính doanh thu cả tháng dựa trên hiện tại
            const estimatedRevenue = Math.round(currentRevenueVal / progressRatio);
            targetRevenue = Math.round(estimatedRevenue * 1.05 / 1000000) * 1000000; // Tăng 5%
            revenueDesc = `Dựa trên xu hướng hiện tại (${new Intl.NumberFormat('vi-VN').format(currentRevenueVal)}đ đã đạt)`;
        } else {
            targetRevenue = 5000000; // Mục tiêu khởi đầu 5 triệu
            revenueDesc = 'Mục tiêu khởi đầu cho quán mới';
        }
        
        // Đơn hàng
        if (prevOrdersVal > 0) {
            targetOrders = Math.max(5, Math.round(prevOrdersVal * 1.1)); // Tăng 10%
            ordersDesc = `Tăng 10% so với tháng trước (${prevOrdersVal} đơn)`;
        } else if (currentOrdersVal > 0 && progressRatio > 0.1) {
            const estimatedOrders = Math.round(currentOrdersVal / progressRatio);
            targetOrders = Math.max(5, Math.round(estimatedOrders * 1.05));
            ordersDesc = `Dựa trên xu hướng hiện tại (${currentOrdersVal} đơn đã có)`;
        } else {
            targetOrders = 10; // Mục tiêu khởi đầu
            ordersDesc = 'Mục tiêu khởi đầu cho quán mới';
        }
        
        // Khách hàng mới
        if (prevCustomersVal > 0) {
            targetCustomers = Math.max(3, Math.round(prevCustomersVal * 1.15)); // Tăng 15%
            customersDesc = `Tăng 15% so với tháng trước (${prevCustomersVal} khách)`;
        } else {
            targetCustomers = 5;
            customersDesc = 'Mục tiêu thu hút khách hàng mới';
        }
        
        // Đặt bàn
        if (prevReservationsVal > 0) {
            targetReservations = Math.max(3, Math.round(prevReservationsVal * 1.1)); // Tăng 10%
            reservationsDesc = `Tăng 10% so với tháng trước (${prevReservationsVal} lượt)`;
        } else {
            targetReservations = 5;
            reservationsDesc = 'Mục tiêu đặt bàn cho quán';
        }
        
        // Đánh giá
        if (prevReviewsVal > 0) {
            targetReviews = Math.max(2, Math.round(prevReviewsVal * 1.2)); // Tăng 20%
            reviewsDesc = `Tăng 20% so với tháng trước (${prevReviewsVal} đánh giá)`;
        } else {
            targetReviews = 3;
            reviewsDesc = 'Mục tiêu thu thập đánh giá từ khách';
        }
        
        // 5 mục tiêu được AI đề xuất
        const goals = [
            {
                loai_muc_tieu: 'doanh_thu',
                ten_muc_tieu: 'Doanh thu tháng',
                mo_ta: revenueDesc,
                gia_tri_muc_tieu: targetRevenue,
                don_vi: 'đồng',
                icon: '💰',
                thu_tu: 1
            },
            {
                loai_muc_tieu: 'don_hang',
                ten_muc_tieu: 'Số đơn hàng',
                mo_ta: ordersDesc,
                gia_tri_muc_tieu: targetOrders,
                don_vi: 'đơn',
                icon: '📦',
                thu_tu: 2
            },
            {
                loai_muc_tieu: 'khach_hang_moi',
                ten_muc_tieu: 'Khách hàng mới',
                mo_ta: customersDesc,
                gia_tri_muc_tieu: targetCustomers,
                don_vi: 'người',
                icon: '👥',
                thu_tu: 3
            },
            {
                loai_muc_tieu: 'dat_ban',
                ten_muc_tieu: 'Lượt đặt bàn',
                mo_ta: reservationsDesc,
                gia_tri_muc_tieu: targetReservations,
                don_vi: 'lượt',
                icon: '🍽️',
                thu_tu: 4
            },
            {
                loai_muc_tieu: 'danh_gia',
                ten_muc_tieu: 'Đánh giá tích cực',
                mo_ta: reviewsDesc,
                gia_tri_muc_tieu: targetReviews,
                don_vi: 'đánh giá',
                icon: '⭐',
                thu_tu: 5
            }
        ];
        
        // Lưu vào database (upsert)
        for (const goal of goals) {
            await db.query(`
                INSERT INTO muc_tieu_chi_tiet (thang, nam, loai_muc_tieu, ten_muc_tieu, mo_ta, gia_tri_muc_tieu, don_vi, icon, thu_tu)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                ON DUPLICATE KEY UPDATE 
                    ten_muc_tieu = VALUES(ten_muc_tieu),
                    mo_ta = VALUES(mo_ta),
                    gia_tri_muc_tieu = VALUES(gia_tri_muc_tieu),
                    don_vi = VALUES(don_vi),
                    icon = VALUES(icon),
                    thu_tu = VALUES(thu_tu),
                    ngay_cap_nhat = CURRENT_TIMESTAMP
            `, [currentMonth, currentYear, goal.loai_muc_tieu, goal.ten_muc_tieu, goal.mo_ta, goal.gia_tri_muc_tieu, goal.don_vi, goal.icon, goal.thu_tu]);
        }
        
        res.json({
            success: true,
            message: 'Đã tạo 5 mục tiêu cho tháng ' + currentMonth,
            data: goals
        });
    } catch (error) {
        console.error('Error generating goals:', error);
        res.status(500).json({ success: false, message: 'Lỗi tạo mục tiêu: ' + error.message });
    }
});

// API: Cập nhật một mục tiêu cụ thể
router.put('/goals/:loai', requireAdmin, async (req, res) => {
    try {
        const { loai } = req.params;
        const { gia_tri_muc_tieu, ten_muc_tieu, mo_ta } = req.body;
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        await db.query(`
            UPDATE muc_tieu_chi_tiet 
            SET gia_tri_muc_tieu = ?, ten_muc_tieu = COALESCE(?, ten_muc_tieu), mo_ta = COALESCE(?, mo_ta), ngay_cap_nhat = CURRENT_TIMESTAMP
            WHERE thang = ? AND nam = ? AND loai_muc_tieu = ?
        `, [gia_tri_muc_tieu, ten_muc_tieu, mo_ta, currentMonth, currentYear, loai]);
        
        res.json({ success: true, message: 'Đã cập nhật mục tiêu' });
    } catch (error) {
        console.error('Error updating goal:', error);
        res.status(500).json({ success: false, message: 'Lỗi cập nhật mục tiêu' });
    }
});

// API: Xóa tất cả mục tiêu tháng hiện tại
router.delete('/goals', requireAdmin, async (req, res) => {
    try {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        await db.query(`
            DELETE FROM muc_tieu_chi_tiet WHERE thang = ? AND nam = ?
        `, [currentMonth, currentYear]);
        
        res.json({ success: true, message: 'Đã xóa tất cả mục tiêu' });
    } catch (error) {
        console.error('Error deleting goals:', error);
        res.status(500).json({ success: false, message: 'Lỗi xóa mục tiêu' });
    }
});

module.exports = router;
