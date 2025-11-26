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

// Thống kê đặt bàn - PHẢI ĐẶT TRƯỚC /:id
router.get('/stats', requireAdmin, async (req, res) => {
    try {
        // Tổng số đặt bàn
        const [totalCount] = await db.query(`SELECT COUNT(*) as total FROM dat_ban`);
        
        // Đặt bàn hôm nay
        const [todayCount] = await db.query(`
            SELECT COUNT(*) as count FROM dat_ban WHERE DATE(ngay_dat) = CURDATE()
        `);

        // Đặt bàn theo trạng thái
        const [statusStats] = await db.query(`
            SELECT trang_thai, COUNT(*) as count FROM dat_ban GROUP BY trang_thai
        `);

        // Đặt bàn tuần này
        const [weekStats] = await db.query(`
            SELECT COUNT(*) as count FROM dat_ban 
            WHERE YEARWEEK(ngay_dat, 1) = YEARWEEK(CURDATE(), 1)
        `);

        res.json({
            success: true,
            totalReservations: totalCount[0].total,
            today: todayCount[0].count,
            thisWeek: weekStats[0].count,
            byStatus: statusStats
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
