const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Middleware kiểm tra admin (có thể tách ra file riêng)
const requireAdmin = (req, res, next) => {
    if (req.session && req.session.admin) {
        next();
    } else {
        res.status(401).json({ success: false, message: 'Unauthorized' });
    }
};

// Lấy danh sách khách hàng
router.get('/', requireAdmin, async (req, res) => {
    try {
        const [customers] = await db.query(`
            SELECT ma_nguoi_dung, ten_nguoi_dung, email, so_dien_thoai, 
                   gioi_tinh, dia_chi, trang_thai, ngay_tao, anh_dai_dien 
            FROM nguoi_dung 
            ORDER BY ngay_tao DESC
        `);
        res.json({ success: true, data: customers });
    } catch (error) {
        console.error('Error fetching customers:', error);
        res.status(500).json({ success: false, message: 'Lỗi server' });
    }
});

// Lấy chi tiết khách hàng
router.get('/:id', requireAdmin, async (req, res) => {
    try {
        const [customers] = await db.query(`
            SELECT * FROM nguoi_dung WHERE ma_nguoi_dung = ?
        `, [req.params.id]);

        if (customers.length === 0) {
            return res.status(404).json({ success: false, message: 'Không tìm thấy khách hàng' });
        }

        res.json({ success: true, data: customers[0] });
    } catch (error) {
        console.error('Error fetching customer detail:', error);
        res.status(500).json({ success: false, message: 'Lỗi server' });
    }
});

// Cập nhật trạng thái khách hàng (khóa/mở khóa)
router.put('/:id/status', requireAdmin, async (req, res) => {
    try {
        const { trang_thai } = req.body;
        await db.query(`
            UPDATE nguoi_dung SET trang_thai = ? WHERE ma_nguoi_dung = ?
        `, [trang_thai, req.params.id]);

        res.json({ success: true, message: 'Cập nhật trạng thái thành công' });
    } catch (error) {
        console.error('Error updating customer status:', error);
        res.status(500).json({ success: false, message: 'Lỗi server' });
    }
});

module.exports = router;
