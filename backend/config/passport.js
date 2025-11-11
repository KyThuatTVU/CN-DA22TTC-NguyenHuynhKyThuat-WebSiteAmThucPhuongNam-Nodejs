const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const db = require('./database');
require('dotenv').config();

// Serialize user (hỗ trợ cả admin và user)
passport.serializeUser((user, done) => {
    // Kiểm tra xem là admin hay user
    if (user.ma_admin) {
        done(null, { type: 'admin', id: user.ma_admin });
    } else {
        done(null, { type: 'user', id: user.ma_nguoi_dung });
    }
});

// Deserialize user (hỗ trợ cả admin và user)
passport.deserializeUser(async (data, done) => {
    try {
        if (data.type === 'admin') {
            const [admins] = await db.query(
                'SELECT ma_admin, tai_khoan, ten_hien_thi, email, quyen FROM admin WHERE ma_admin = ?',
                [data.id]
            );
            done(null, admins[0]);
        } else {
            const [users] = await db.query(
                'SELECT ma_nguoi_dung, ten_nguoi_dung, email, anh_dai_dien FROM nguoi_dung WHERE ma_nguoi_dung = ?',
                [data.id]
            );
            done(null, users[0]);
        }
    } catch (error) {
        done(error, null);
    }
});

// Google OAuth Strategy (Chỉ dành cho Admin)
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: process.env.GOOGLE_CALLBACK_URL
},
async (accessToken, refreshToken, profile, done) => {
    try {
        const email = profile.emails[0].value;
        const ten_hien_thi = profile.displayName;
        const anh_dai_dien = profile.photos[0]?.value || null;

        // Chỉ kiểm tra trong bảng admin, không tạo mới
        const [existingAdmins] = await db.query(
            'SELECT * FROM admin WHERE email = ?',
            [email]
        );

        if (existingAdmins.length > 0) {
            // Admin đã tồn tại, cho phép đăng nhập
            return done(null, {
                ...existingAdmins[0],
                email,
                ten_hien_thi: existingAdmins[0].ten_hien_thi || ten_hien_thi
            });
        }

        // Không tìm thấy admin với email này
        // Trả về null để từ chối đăng nhập
        return done(null, false, { message: 'Email không phải là admin' });

    } catch (error) {
        console.error('Lỗi Google OAuth:', error);
        return done(error, null);
    }
}));

module.exports = passport;
