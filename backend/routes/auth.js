const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const db = require('../config/database');
const { sendVerificationEmail, sendWelcomeEmail } = require('../config/email');

// Secret key cho JWT (nên đặt trong .env)
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-change-this';

// Hàm tạo mã xác thực 6 số
function generateVerificationCode() {
    return Math.floor(100000 + Math.random() * 900000).toString();
}

// Cấu hình multer để upload ảnh
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        const uploadDir = path.join(__dirname, '../images/avatars');
        // Tạo thư mục nếu chưa tồn tại
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }
        cb(null, uploadDir);
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, 'avatar-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const fileFilter = (req, file, cb) => {
    // Chỉ chấp nhận file ảnh
    if (file.mimetype.startsWith('image/')) {
        cb(null, true);
    } else {
        cb(new Error('Chỉ chấp nhận file ảnh!'), false);
    }
};

const upload = multer({
    storage: storage,
    fileFilter: fileFilter,
    limits: {
        fileSize: 5 * 1024 * 1024 // 5MB
    }
});

// Upload ảnh đại diện
router.post('/upload-avatar', upload.single('avatar'), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng chọn file ảnh'
            });
        }

        const avatarPath = '/images/avatars/' + req.file.filename;

        res.json({
            success: true,
            message: 'Upload ảnh thành công',
            data: {
                anh_dai_dien: avatarPath
            }
        });

    } catch (error) {
        console.error('Lỗi upload ảnh:', error);
        res.status(500).json({
            success: false,
            message: error.message || 'Lỗi upload ảnh',
            error: error.message
        });
    }
});

// Bước 1: Gửi mã xác thực email
router.post('/send-verification', async (req, res) => {
    try {
        const { ten_nguoi_dung, email, so_dien_thoai, mat_khau, dia_chi, gioi_tinh, anh_dai_dien } = req.body;

        // Validate
        if (!ten_nguoi_dung || !email || !mat_khau) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng điền đầy đủ thông tin bắt buộc'
            });
        }

        // Kiểm tra email đã tồn tại trong bảng nguoi_dung
        const [existingUser] = await db.query(
            'SELECT ma_nguoi_dung FROM nguoi_dung WHERE email = ?',
            [email]
        );

        if (existingUser.length > 0) {
            return res.status(400).json({
                success: false,
                message: 'Email đã được sử dụng'
            });
        }

        // Kiểm tra số điện thoại đã tồn tại (nếu có)
        if (so_dien_thoai) {
            const [existingPhone] = await db.query(
                'SELECT ma_nguoi_dung FROM nguoi_dung WHERE so_dien_thoai = ?',
                [so_dien_thoai]
            );

            if (existingPhone.length > 0) {
                return res.status(400).json({
                    success: false,
                    message: 'Số điện thoại đã được sử dụng'
                });
            }
        }

        // Tạo mã xác thực 6 số
        const verificationCode = generateVerificationCode();

        // Hash mật khẩu
        const mat_khau_hash = await bcrypt.hash(mat_khau, 10);

        // Xóa mã xác thực cũ của email này (nếu có)
        await db.query('DELETE FROM xac_thuc_email WHERE email = ?', [email]);

        // Lưu thông tin tạm vào bảng xac_thuc_email
        const ngay_het_han = new Date(Date.now() + 10 * 60 * 1000); // Hết hạn sau 10 phút

        await db.query(
            `INSERT INTO xac_thuc_email 
            (email, ma_code, ten_nguoi_dung, so_dien_thoai, mat_khau_hash, dia_chi, gioi_tinh, anh_dai_dien, ngay_het_han) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [email, verificationCode, ten_nguoi_dung, so_dien_thoai || null, mat_khau_hash, dia_chi || null, gioi_tinh || 'khac', anh_dai_dien || null, ngay_het_han]
        );

        // Gửi email xác thực
        const emailResult = await sendVerificationEmail(email, verificationCode, ten_nguoi_dung);

        if (!emailResult.success) {
            return res.status(500).json({
                success: false,
                message: 'Không thể gửi email xác thực. Vui lòng thử lại sau.'
            });
        }

        res.status(200).json({
            success: true,
            message: 'Mã xác thực đã được gửi đến email của bạn',
            data: {
                email,
                expires_in: '10 phút'
            }
        });

    } catch (error) {
        console.error('Lỗi gửi mã xác thực:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Bước 2: Xác thực mã và hoàn tất đăng ký
router.post('/verify-email', async (req, res) => {
    try {
        const { email, ma_code } = req.body;

        // Validate
        if (!email || !ma_code) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng nhập email và mã xác thực'
            });
        }

        // Tìm mã xác thực
        const [verifications] = await db.query(
            `SELECT * FROM xac_thuc_email 
             WHERE email = ? AND ma_code = ? AND trang_thai = 'pending' AND ngay_het_han > NOW()`,
            [email, ma_code]
        );

        if (verifications.length === 0) {
            return res.status(400).json({
                success: false,
                message: 'Mã xác thực không đúng hoặc đã hết hạn'
            });
        }

        const verification = verifications[0];

        // Thêm người dùng vào bảng nguoi_dung
        const [result] = await db.query(
            `INSERT INTO nguoi_dung (ten_nguoi_dung, email, so_dien_thoai, mat_khau_hash, dia_chi, gioi_tinh, anh_dai_dien) 
             VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [
                verification.ten_nguoi_dung,
                verification.email,
                verification.so_dien_thoai,
                verification.mat_khau_hash,
                verification.dia_chi,
                verification.gioi_tinh,
                verification.anh_dai_dien
            ]
        );

        // Cập nhật trạng thái xác thực
        await db.query(
            'UPDATE xac_thuc_email SET trang_thai = ? WHERE ma_xac_thuc = ?',
            ['verified', verification.ma_xac_thuc]
        );

        // Gửi email chào mừng
        await sendWelcomeEmail(email, verification.ten_nguoi_dung);

        // Tạo JWT token
        const token = jwt.sign(
            { ma_nguoi_dung: result.insertId, email },
            JWT_SECRET,
            { expiresIn: '7d' }
        );

        res.status(201).json({
            success: true,
            message: 'Xác thực thành công! Tài khoản đã được tạo.',
            data: {
                ma_nguoi_dung: result.insertId,
                ten_nguoi_dung: verification.ten_nguoi_dung,
                email: verification.email,
                anh_dai_dien: verification.anh_dai_dien,
                token
            }
        });

    } catch (error) {
        console.error('Lỗi xác thực email:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Gửi lại mã xác thực
router.post('/resend-verification', async (req, res) => {
    try {
        const { email } = req.body;

        if (!email) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng nhập email'
            });
        }

        // Tìm thông tin xác thực pending
        const [verifications] = await db.query(
            'SELECT * FROM xac_thuc_email WHERE email = ? AND trang_thai = ? ORDER BY ngay_tao DESC LIMIT 1',
            [email, 'pending']
        );

        if (verifications.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy yêu cầu đăng ký cho email này'
            });
        }

        const verification = verifications[0];

        // Tạo mã mới
        const newCode = generateVerificationCode();
        const ngay_het_han = new Date(Date.now() + 10 * 60 * 1000);

        // Cập nhật mã mới
        await db.query(
            'UPDATE xac_thuc_email SET ma_code = ?, ngay_het_han = ?, ngay_tao = NOW() WHERE ma_xac_thuc = ?',
            [newCode, ngay_het_han, verification.ma_xac_thuc]
        );

        // Gửi email
        const emailResult = await sendVerificationEmail(email, newCode, verification.ten_nguoi_dung);

        if (!emailResult.success) {
            return res.status(500).json({
                success: false,
                message: 'Không thể gửi email. Vui lòng thử lại sau.'
            });
        }

        res.json({
            success: true,
            message: 'Mã xác thực mới đã được gửi đến email của bạn'
        });

    } catch (error) {
        console.error('Lỗi gửi lại mã:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Đăng nhập
router.post('/login', async (req, res) => {
    try {
        const { email, mat_khau } = req.body;

        // Validate
        if (!email || !mat_khau) {
            return res.status(400).json({
                success: false,
                message: 'Vui lòng nhập email và mật khẩu'
            });
        }

        // Tìm người dùng
        const [users] = await db.query(
            'SELECT * FROM nguoi_dung WHERE email = ? AND trang_thai = 1',
            [email]
        );

        if (users.length === 0) {
            return res.status(401).json({
                success: false,
                message: 'Email hoặc mật khẩu không đúng'
            });
        }

        const user = users[0];

        // Kiểm tra mật khẩu
        const isValidPassword = await bcrypt.compare(mat_khau, user.mat_khau_hash);

        if (!isValidPassword) {
            return res.status(401).json({
                success: false,
                message: 'Email hoặc mật khẩu không đúng'
            });
        }

        // Tạo JWT token
        const token = jwt.sign(
            { ma_nguoi_dung: user.ma_nguoi_dung, email: user.email },
            JWT_SECRET,
            { expiresIn: '7d' }
        );

        // Trả về thông tin người dùng (không bao gồm mật khẩu)
        const { mat_khau_hash, ...userData } = user;

        res.json({
            success: true,
            message: 'Đăng nhập thành công',
            data: {
                ...userData,
                token
            }
        });

    } catch (error) {
        console.error('Lỗi đăng nhập:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Middleware xác thực token
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({
            success: false,
            message: 'Không có token xác thực'
        });
    }

    jwt.verify(token, JWT_SECRET, (err, user) => {
        if (err) {
            return res.status(403).json({
                success: false,
                message: 'Token không hợp lệ'
            });
        }
        req.user = user;
        next();
    });
};

// Lấy thông tin người dùng hiện tại
router.get('/me', authenticateToken, async (req, res) => {
    try {
        const [users] = await db.query(
            'SELECT ma_nguoi_dung, ten_nguoi_dung, email, so_dien_thoai, dia_chi, gioi_tinh, anh_dai_dien, ngay_tao FROM nguoi_dung WHERE ma_nguoi_dung = ?',
            [req.user.ma_nguoi_dung]
        );

        if (users.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy người dùng'
            });
        }

        res.json({
            success: true,
            data: users[0]
        });

    } catch (error) {
        console.error('Lỗi lấy thông tin:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Cập nhật thông tin người dùng
router.put('/update', authenticateToken, async (req, res) => {
    try {
        const { ten_nguoi_dung, so_dien_thoai, dia_chi, gioi_tinh, anh_dai_dien } = req.body;
        const ma_nguoi_dung = req.user.ma_nguoi_dung;

        await db.query(
            `UPDATE nguoi_dung 
             SET ten_nguoi_dung = ?, so_dien_thoai = ?, dia_chi = ?, gioi_tinh = ?, anh_dai_dien = ?
             WHERE ma_nguoi_dung = ?`,
            [ten_nguoi_dung, so_dien_thoai, dia_chi, gioi_tinh, anh_dai_dien, ma_nguoi_dung]
        );

        res.json({
            success: true,
            message: 'Cập nhật thông tin thành công'
        });

    } catch (error) {
        console.error('Lỗi cập nhật:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Đổi mật khẩu
router.post('/change-password', authenticateToken, async (req, res) => {
    try {
        const { mat_khau_cu, mat_khau_moi } = req.body;
        const ma_nguoi_dung = req.user.ma_nguoi_dung;

        // Lấy mật khẩu hiện tại
        const [users] = await db.query(
            'SELECT mat_khau_hash FROM nguoi_dung WHERE ma_nguoi_dung = ?',
            [ma_nguoi_dung]
        );

        if (users.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy người dùng'
            });
        }

        // Kiểm tra mật khẩu cũ
        const isValidPassword = await bcrypt.compare(mat_khau_cu, users[0].mat_khau_hash);

        if (!isValidPassword) {
            return res.status(401).json({
                success: false,
                message: 'Mật khẩu cũ không đúng'
            });
        }

        // Hash mật khẩu mới
        const mat_khau_hash = await bcrypt.hash(mat_khau_moi, 10);

        // Cập nhật mật khẩu
        await db.query(
            'UPDATE nguoi_dung SET mat_khau_hash = ? WHERE ma_nguoi_dung = ?',
            [mat_khau_hash, ma_nguoi_dung]
        );

        res.json({
            success: true,
            message: 'Đổi mật khẩu thành công'
        });

    } catch (error) {
        console.error('Lỗi đổi mật khẩu:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

module.exports = router;
module.exports.authenticateToken = authenticateToken;
