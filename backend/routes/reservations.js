const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Middleware kiểm tra admin
const requireAdmin = (req, res, next) => {
    if (req.session && req.session.admin) {
        next();
    } else {
        res.status(401).json({ success: false, message: 'Unauthorized' });
    }
};

// Tạo đặt bàn mới (Public - không cần đăng nhập)
router.post('/create', async (req, res) => {
    try {
        const { ten_nguoi_dat, so_dien_thoai, email, ngay_dat, gio_den, so_luong, khu_vuc, ghi_chu } = req.body;

        // Validate dữ liệu bắt buộc
        if (!ten_nguoi_dat || !so_dien_thoai || !ngay_dat || !gio_den || !so_luong) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng điền đầy đủ thông tin bắt buộc'
            });
        }

        // Validate thời gian đặt bàn (phải trước ít nhất 3 tiếng)
        const MIN_HOURS_ADVANCE = 3;
        const bookingDateTime = new Date(`${ngay_dat}T${gio_den}`);
        const now = new Date();
        const minBookingTime = new Date(now.getTime() + MIN_HOURS_ADVANCE * 60 * 60 * 1000);

        if (bookingDateTime < minBookingTime) {
            return res.status(400).json({
                success: false,
                message: `Vui lòng đặt bàn trước ít nhất ${MIN_HOURS_ADVANCE} tiếng`
            });
        }

        // Validate giờ mở cửa (7:00 - 23:00)
        const hours = bookingDateTime.getHours();
        if (hours < 7 || hours >= 23) {
            return res.status(400).json({
                success: false,
                message: 'Nhà hàng mở cửa từ 7:00 đến 23:00'
            });
        }

        // Thêm ghi chú về khu vực nếu có
        let fullGhiChu = ghi_chu || '';
        if (khu_vuc) {
            const khuVucMap = {
                'indoor': 'Khu vực trong nhà',
                'outdoor': 'Khu vực sân vườn',
                'vip': 'Phòng VIP'
            };
            fullGhiChu = `[${khuVucMap[khu_vuc] || khu_vuc}] ${fullGhiChu}`.trim();
        }

        // Insert vào database
        const [result] = await db.query(
            `INSERT INTO dat_ban (ten_nguoi_dat, so_dien_thoai, so_luong, ngay_dat, gio_den, ghi_chu, trang_thai)
             VALUES (?, ?, ?, ?, ?, ?, 'pending')`,
            [ten_nguoi_dat, so_dien_thoai, parseInt(so_luong), ngay_dat, gio_den, fullGhiChu || null]
        );

        res.json({
            success: true,
            message: 'Đặt bàn thành công! Nhà hàng sẽ liên hệ xác nhận.',
            data: {
                ma_dat_ban: result.insertId,
                ten_nguoi_dat,
                so_dien_thoai,
                ngay_dat,
                gio_den,
                so_luong
            }
        });
    } catch (error) {
        console.error('Error creating reservation:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi khi tạo đặt bàn'
        });
    }
});

// Thống kê đặt bàn - PHẢI ĐẶT TRƯỚC /:id
router.get('/stats', requireAdmin, async (req, res) => {
    try {
        const { year, month } = req.query;
        const currentDate = new Date();
        
        // Xác định tháng/năm để thống kê
        const targetMonth = month && parseInt(month) > 0 ? parseInt(month) : (currentDate.getMonth() + 1);
        const targetYear = year ? parseInt(year) : currentDate.getFullYear();
        
        // Tháng trước để so sánh
        let prevMonth = targetMonth - 1;
        let prevYear = targetYear;
        if (prevMonth === 0) {
            prevMonth = 12;
            prevYear = targetYear - 1;
        }

        // Tổng số đặt bàn theo filter
        let totalQuery = `SELECT COUNT(*) as total FROM dat_ban WHERE 1=1`;
        const totalParams = [];
        
        if (year) {
            totalQuery += ` AND YEAR(ngay_dat) = ?`;
            totalParams.push(targetYear);
        }
        if (month && parseInt(month) > 0) {
            totalQuery += ` AND MONTH(ngay_dat) = ?`;
            totalParams.push(targetMonth);
        }
        
        const [totalCount] = await db.query(totalQuery, totalParams);
        
        // Đặt bàn hôm nay
        const [todayCount] = await db.query(`
            SELECT COUNT(*) as count FROM dat_ban WHERE DATE(ngay_dat) = CURDATE()
        `);

        // Đặt bàn theo trạng thái (theo filter)
        let statusQuery = `SELECT trang_thai, COUNT(*) as count FROM dat_ban WHERE 1=1`;
        const statusParams = [];
        if (year) {
            statusQuery += ` AND YEAR(ngay_dat) = ?`;
            statusParams.push(targetYear);
        }
        if (month && parseInt(month) > 0) {
            statusQuery += ` AND MONTH(ngay_dat) = ?`;
            statusParams.push(targetMonth);
        }
        statusQuery += ` GROUP BY trang_thai`;
        
        const [statusStats] = await db.query(statusQuery, statusParams);

        // Đặt bàn tuần này
        const [weekStats] = await db.query(`
            SELECT COUNT(*) as count FROM dat_ban 
            WHERE YEARWEEK(ngay_dat, 1) = YEARWEEK(CURDATE(), 1)
        `);

        // Đặt bàn trong tháng được chọn
        const [thisMonthCount] = await db.query(`
            SELECT COUNT(*) as count FROM dat_ban 
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
        `, [targetMonth, targetYear]);

        // Đặt bàn tháng trước
        const [lastMonthCount] = await db.query(`
            SELECT COUNT(*) as count FROM dat_ban 
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
        `, [prevMonth, prevYear]);

        // Tính phần trăm thay đổi
        const reservationsChange = lastMonthCount[0].count > 0 
            ? ((thisMonthCount[0].count - lastMonthCount[0].count) / lastMonthCount[0].count * 100).toFixed(1)
            : (thisMonthCount[0].count > 0 ? 100 : 0);

        // Tạo label so sánh
        const comparisonLabel = `So với T${prevMonth}/${prevYear}`;

        res.json({
            success: true,
            totalReservations: month && parseInt(month) > 0 ? thisMonthCount[0].count : totalCount[0].total,
            today: todayCount[0].count,
            thisWeek: weekStats[0].count,
            thisMonth: thisMonthCount[0].count,
            lastMonth: lastMonthCount[0].count,
            byStatus: statusStats,
            comparison: {
                reservationsChange: parseFloat(reservationsChange),
                label: comparisonLabel
            },
            filters: { year: targetYear, month: targetMonth }
        });
    } catch (error) {
        console.error('Error fetching reservation stats:', error);
        res.status(500).json({ success: false, message: 'Lỗi khi lấy thống kê' });
    }
});

// Lấy tất cả đặt bàn (Admin)
router.get('/', requireAdmin, async (req, res) => {
    try {
        const [reservations] = await db.query(`
            SELECT * FROM dat_ban
            ORDER BY ngay_dat DESC, gio_den DESC
        `);

        res.json({
            success: true,
            data: reservations
        });
    } catch (error) {
        console.error('Error fetching reservations:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi khi lấy danh sách đặt bàn'
        });
    }
});

// Lấy chi tiết một đặt bàn
router.get('/:id', requireAdmin, async (req, res) => {
    try {
        const { id } = req.params;
        const [reservations] = await db.query(`
            SELECT db.*, nd.ten_nguoi_dung, nd.email as nguoi_dung_email, nd.so_dien_thoai as sdt_nguoi_dung
            FROM dat_ban db
            LEFT JOIN nguoi_dung nd ON db.ma_nguoi_dung = nd.ma_nguoi_dung
            WHERE db.ma_dat_ban = ?
        `, [id]);

        if (reservations.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy đặt bàn'
            });
        }

        res.json({
            success: true,
            data: reservations[0]
        });
    } catch (error) {
        console.error('Error fetching reservation:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi khi lấy thông tin đặt bàn'
        });
    }
});

// Cập nhật trạng thái đặt bàn
router.put('/:id/status', requireAdmin, async (req, res) => {
    try {
        const { id } = req.params;
        const { trang_thai } = req.body;

        // Validate trạng thái
        const validStatuses = ['pending', 'confirmed', 'attended', 'cancelled'];
        if (!validStatuses.includes(trang_thai)) {
            return res.status(400).json({
                success: false,
                message: 'Trạng thái không hợp lệ'
            });
        }

        const [result] = await db.query(
            'UPDATE dat_ban SET trang_thai = ? WHERE ma_dat_ban = ?',
            [trang_thai, id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy đặt bàn'
            });
        }

        res.json({
            success: true,
            message: 'Cập nhật trạng thái thành công'
        });
    } catch (error) {
        console.error('Error updating reservation status:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi khi cập nhật trạng thái'
        });
    }
});

// Xóa đặt bàn
router.delete('/:id', requireAdmin, async (req, res) => {
    try {
        const { id } = req.params;

        const [result] = await db.query(
            'DELETE FROM dat_ban WHERE ma_dat_ban = ?',
            [id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy đặt bàn'
            });
        }

        res.json({
            success: true,
            message: 'Xóa đặt bàn thành công'
        });
    } catch (error) {
        console.error('Error deleting reservation:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi khi xóa đặt bàn'
        });
    }
});

module.exports = router;
