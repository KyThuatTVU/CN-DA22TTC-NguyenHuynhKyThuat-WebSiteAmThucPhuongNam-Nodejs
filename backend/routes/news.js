const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Lấy tất cả tin tức (có phân trang)
router.get('/', async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const offset = (page - 1) * limit;

        // Đếm tổng số tin tức
        const [countResult] = await db.query(
            'SELECT COUNT(*) as total FROM tin_tuc WHERE trang_thai = 1'
        );
        const total = countResult[0].total;

        // Lấy danh sách tin tức với thông tin admin
        const [news] = await db.query(`
            SELECT 
                t.ma_tin_tuc,
                t.tieu_de,
                t.tom_tat,
                t.anh_dai_dien,
                t.ngay_dang,
                t.luot_xem,
                a.ten_hien_thi as tac_gia
            FROM tin_tuc t
            LEFT JOIN admin a ON t.ma_admin_dang = a.ma_admin
            WHERE t.trang_thai = 1
            ORDER BY t.ngay_dang DESC
            LIMIT ? OFFSET ?
        `, [parseInt(limit), offset]);

        res.json({
            success: true,
            data: news,
            pagination: {
                page,
                limit,
                total,
                totalPages: Math.ceil(total / limit)
            }
        });

    } catch (error) {
        console.error('Lỗi lấy tin tức:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Lấy tin tức nổi bật (mới nhất)
router.get('/featured', async (req, res) => {
    try {
        const limit = parseInt(req.query.limit) || 3;

        const [news] = await db.query(
            `SELECT 
                t.ma_tin_tuc,
                t.tieu_de,
                t.tom_tat,
                t.anh_dai_dien,
                t.ngay_dang,
                t.luot_xem,
                a.ten_hien_thi as tac_gia
            FROM tin_tuc t
            LEFT JOIN admin a ON t.ma_admin_dang = a.ma_admin
            WHERE t.trang_thai = 1
            ORDER BY t.ngay_dang DESC
            LIMIT ?`,
            [limit]
        );

        res.json({
            success: true,
            data: news
        });

    } catch (error) {
        console.error('Lỗi lấy tin nổi bật:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Lấy tin tức phổ biến (nhiều lượt xem nhất)
router.get('/popular', async (req, res) => {
    try {
        const limit = parseInt(req.query.limit) || 5;

        const [news] = await db.query(
            `SELECT 
                t.ma_tin_tuc,
                t.tieu_de,
                t.tom_tat,
                t.anh_dai_dien,
                t.ngay_dang,
                t.luot_xem
            FROM tin_tuc t
            WHERE t.trang_thai = 1
            ORDER BY t.luot_xem DESC, t.ngay_dang DESC
            LIMIT ?`,
            [limit]
        );

        res.json({
            success: true,
            data: news
        });

    } catch (error) {
        console.error('Lỗi lấy tin phổ biến:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Lấy chi tiết tin tức theo ID
router.get('/:id', async (req, res) => {
    try {
        const { id } = req.params;

        // Lấy thông tin tin tức
        const [news] = await db.query(
            `SELECT 
                t.ma_tin_tuc,
                t.tieu_de,
                t.tom_tat,
                t.noi_dung,
                t.anh_dai_dien,
                t.ngay_dang,
                t.luot_xem,
                a.ten_hien_thi as tac_gia
            FROM tin_tuc t
            LEFT JOIN admin a ON t.ma_admin_dang = a.ma_admin
            WHERE t.ma_tin_tuc = ? AND t.trang_thai = 1`,
            [id]
        );

        if (news.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy tin tức'
            });
        }

        // Tăng lượt xem
        await db.query(
            'UPDATE tin_tuc SET luot_xem = luot_xem + 1 WHERE ma_tin_tuc = ?',
            [id]
        );

        // Lấy tin liên quan (cùng thời gian hoặc cùng tác giả)
        const [relatedNews] = await db.query(
            `SELECT 
                t.ma_tin_tuc,
                t.tieu_de,
                t.tom_tat,
                t.anh_dai_dien,
                t.ngay_dang,
                t.luot_xem
            FROM tin_tuc t
            WHERE t.ma_tin_tuc != ? AND t.trang_thai = 1
            ORDER BY t.ngay_dang DESC
            LIMIT 3`,
            [id]
        );

        res.json({
            success: true,
            data: {
                ...news[0],
                luot_xem: news[0].luot_xem + 1, // Cập nhật luôn số lượt xem
                related: relatedNews
            }
        });

    } catch (error) {
        console.error('Lỗi lấy chi tiết tin tức:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Tìm kiếm tin tức
router.get('/search/query', async (req, res) => {
    try {
        const { q } = req.query;
        
        if (!q) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng nhập từ khóa tìm kiếm'
            });
        }

        const searchTerm = `%${q}%`;

        const [news] = await db.query(
            `SELECT 
                t.ma_tin_tuc,
                t.tieu_de,
                t.tom_tat,
                t.anh_dai_dien,
                t.ngay_dang,
                t.luot_xem,
                a.ten_hien_thi as tac_gia
            FROM tin_tuc t
            LEFT JOIN admin a ON t.ma_admin_dang = a.ma_admin
            WHERE t.trang_thai = 1 
            AND (t.tieu_de LIKE ? OR t.tom_tat LIKE ? OR t.noi_dung LIKE ?)
            ORDER BY t.ngay_dang DESC
            LIMIT 20`,
            [searchTerm, searchTerm, searchTerm]
        );

        res.json({
            success: true,
            data: news,
            count: news.length
        });

    } catch (error) {
        console.error('Lỗi tìm kiếm tin tức:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Middleware kiểm tra admin
const requireAdmin = (req, res, next) => {
    if (req.session && req.session.admin) {
        next();
    } else {
        res.status(401).json({ success: false, message: 'Unauthorized' });
    }
};

// Thêm tin tức mới (Admin)
router.post('/', requireAdmin, async (req, res) => {
    try {
        const { tieu_de, tom_tat, noi_dung, anh_dai_dien, tac_gia, trang_thai } = req.body;
        const ma_admin_dang = req.session.admin?.ma_admin || null;
        
        const [result] = await db.query(
            `INSERT INTO tin_tuc (tieu_de, tom_tat, noi_dung, anh_dai_dien, ma_admin_dang, trang_thai, ngay_dang, luot_xem) 
             VALUES (?, ?, ?, ?, ?, ?, NOW(), 0)`,
            [tieu_de, tom_tat || '', noi_dung, anh_dai_dien, ma_admin_dang, trang_thai || 1]
        );
        
        res.json({ success: true, message: 'Thêm tin tức thành công', id: result.insertId });
    } catch (error) {
        console.error('Error adding news:', error);
        res.status(500).json({ success: false, message: error.message });
    }
});

// Cập nhật tin tức (Admin)
router.put('/:id', requireAdmin, async (req, res) => {
    try {
        const { tieu_de, tom_tat, noi_dung, anh_dai_dien, trang_thai } = req.body;
        
        const [result] = await db.query(
            `UPDATE tin_tuc 
             SET tieu_de = ?, tom_tat = ?, noi_dung = ?, 
                 anh_dai_dien = COALESCE(?, anh_dai_dien), trang_thai = ?
             WHERE ma_tin_tuc = ?`,
            [tieu_de, tom_tat, noi_dung, anh_dai_dien, trang_thai, req.params.id]
        );
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ success: false, message: 'Không tìm thấy tin tức' });
        }
        
        res.json({ success: true, message: 'Cập nhật tin tức thành công' });
    } catch (error) {
        console.error('Error updating news:', error);
        res.status(500).json({ success: false, message: error.message });
    }
});

// Xóa tin tức (Admin)
router.delete('/:id', requireAdmin, async (req, res) => {
    try {
        const [result] = await db.query('DELETE FROM tin_tuc WHERE ma_tin_tuc = ?', [req.params.id]);
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ success: false, message: 'Không tìm thấy tin tức' });
        }
        
        res.json({ success: true, message: 'Xóa tin tức thành công' });
    } catch (error) {
        console.error('Error deleting news:', error);
        res.status(500).json({ success: false, message: error.message });
    }
});

module.exports = router;
