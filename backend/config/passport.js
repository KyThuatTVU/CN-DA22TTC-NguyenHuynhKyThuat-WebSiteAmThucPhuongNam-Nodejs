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

// Google OAuth Strategy cho Admin
passport.use('google-admin', new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: process.env.GOOGLE_CALLBACK_URL
},
    async (accessToken, refreshToken, profile, done) => {
        try {
            const email = profile.emails[0].value;
            const ten_hien_thi = profile.displayName;

            // Lấy URL ảnh và thay đổi size để có ảnh lớn hơn
            let anh_dai_dien = profile.photos[0]?.value || null;
            if (anh_dai_dien) {
                const originalUrl = anh_dai_dien;
                console.log('📸 Original Admin Google Avatar URL:', originalUrl);
                
                if (originalUrl.includes('googleusercontent.com')) {
                    // Thay thế size parameter
                    anh_dai_dien = originalUrl.replace(/=s\d+(-c)?$/, '=s200-c');
                    if (!anh_dai_dien.includes('=s')) {
                        anh_dai_dien = originalUrl + '=s200-c';
                    }
                }
                console.log('📸 Processed Admin Google Avatar URL:', anh_dai_dien);
            }

            // Chỉ kiểm tra trong bảng admin, không tạo mới
            const [existingAdmins] = await db.query(
                'SELECT * FROM admin WHERE email = ?',
                [email]
            );

            if (existingAdmins.length > 0) {
                return done(null, {
                    ...existingAdmins[0],
                    email,
                    ten_hien_thi: existingAdmins[0].ten_hien_thi || ten_hien_thi,
                    anh_dai_dien: anh_dai_dien || existingAdmins[0].anh_dai_dien
                });
            }

            return done(null, false, { message: 'Email không phải là admin' });

        } catch (error) {
            console.error('Lỗi Google OAuth Admin:', error);
            return done(error, null);
        }
    }));

// Google OAuth Strategy cho User (đăng nhập/đăng ký)
passport.use('google-user', new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: process.env.GOOGLE_USER_CALLBACK_URL || 'http://localhost:3000/api/auth/google/callback'
},
    async (accessToken, refreshToken, profile, done) => {
        try {
            const email = profile.emails[0].value;
            const ten_nguoi_dung = profile.displayName;
            const google_id = profile.id;

            // Lấy URL ảnh Google - giữ nguyên URL gốc, chỉ thay đổi size
            let google_avatar = null;
            if (profile.photos && profile.photos[0] && profile.photos[0].value) {
                const originalUrl = profile.photos[0].value;
                console.log('📸 Original Google Avatar URL:', originalUrl);
                
                // Giữ nguyên URL gốc, chỉ thay thế size parameter
                // URL Google thường có dạng: https://lh3.googleusercontent.com/a/xxx=s96-c
                if (originalUrl.includes('googleusercontent.com')) {
                    // Thay thế =s96-c hoặc tương tự thành =s200-c
                    google_avatar = originalUrl.replace(/=s\d+(-c)?$/, '=s200-c');
                    // Nếu không có size param, thêm vào
                    if (!google_avatar.includes('=s')) {
                        google_avatar = originalUrl + '=s200-c';
                    }
                } else {
                    google_avatar = originalUrl;
                }
                console.log('📸 Processed Google Avatar URL:', google_avatar);
            }

            // Kiểm tra user đã tồn tại chưa (theo google_id hoặc email)
            const [existingUsers] = await db.query(
                'SELECT * FROM nguoi_dung WHERE google_id = ? OR email = ?',
                [google_id, email]
            );

            if (existingUsers.length > 0) {
                const user = existingUsers[0];
                
                // Kiểm tra tài khoản có bị khóa không
                if (user.trang_thai === 0) {
                    return done(null, false, { message: 'Tài khoản đã bị khóa' });
                }

                console.log('📋 User hiện tại trong DB:', {
                    ma_nguoi_dung: user.ma_nguoi_dung,
                    ten_nguoi_dung: user.ten_nguoi_dung,
                    anh_dai_dien: user.anh_dai_dien,
                    google_id: user.google_id
                });

                // Cập nhật google_id và avatar
                const updates = [];
                const values = [];
                
                // Luôn cập nhật google_id nếu chưa có
                if (!user.google_id) {
                    updates.push('google_id = ?');
                    values.push(google_id);
                }
                
                // Kiểm tra avatar hiện tại
                const currentAvatar = user.anh_dai_dien;
                const isLocalAvatar = currentAvatar && currentAvatar.startsWith('/images/');
                const isGoogleAvatar = currentAvatar && currentAvatar.includes('googleusercontent.com');
                const hasNoAvatar = !currentAvatar || currentAvatar.trim() === '';
                
                console.log('🔍 Avatar check:', { hasNoAvatar, isLocalAvatar, isGoogleAvatar, google_avatar });
                
                // Cập nhật avatar từ Google nếu:
                // 1. User chưa có avatar
                // 2. Avatar hiện tại là từ Google (cập nhật ảnh mới nhất)
                // KHÔNG cập nhật nếu user đã upload avatar local
                if (google_avatar && (hasNoAvatar || isGoogleAvatar)) {
                    updates.push('anh_dai_dien = ?');
                    values.push(google_avatar);
                    console.log('📝 Sẽ cập nhật avatar từ Google:', google_avatar);
                }

                if (updates.length > 0) {
                    values.push(user.ma_nguoi_dung);
                    const updateQuery = `UPDATE nguoi_dung SET ${updates.join(', ')} WHERE ma_nguoi_dung = ?`;
                    console.log('📝 Update query:', updateQuery);
                    console.log('📝 Update values:', values);
                    await db.query(updateQuery, values);
                    console.log('✅ Đã cập nhật thông tin Google cho user:', email);
                }

                // Xác định avatar cuối cùng để trả về
                let finalAvatar;
                if (isLocalAvatar) {
                    // Giữ avatar local nếu user đã upload
                    finalAvatar = currentAvatar;
                } else if (google_avatar) {
                    // Dùng avatar Google mới
                    finalAvatar = google_avatar;
                } else {
                    // Fallback về avatar hiện tại
                    finalAvatar = currentAvatar;
                }

                console.log('✅ User đăng nhập Google thành công:', email);
                console.log('👤 Tên người dùng:', user.ten_nguoi_dung);
                console.log('🖼️ Avatar cuối cùng:', finalAvatar);
                
                return done(null, {
                    ma_nguoi_dung: user.ma_nguoi_dung,
                    ten_nguoi_dung: user.ten_nguoi_dung,
                    email: user.email,
                    anh_dai_dien: finalAvatar,
                    so_dien_thoai: user.so_dien_thoai || null,
                    dia_chi: user.dia_chi || null,
                    gioi_tinh: user.gioi_tinh || 'khac'
                });
            }

            // Tạo user mới nếu chưa tồn tại
            console.log('📝 Tạo user mới từ Google:', email);
            console.log('👤 Tên:', ten_nguoi_dung);
            console.log('🖼️ Avatar:', google_avatar);
            
            const [result] = await db.query(
                `INSERT INTO nguoi_dung (ten_nguoi_dung, email, google_id, anh_dai_dien, trang_thai) 
                 VALUES (?, ?, ?, ?, 1)`,
                [ten_nguoi_dung, email, google_id, google_avatar]
            );

            return done(null, {
                ma_nguoi_dung: result.insertId,
                ten_nguoi_dung,
                email,
                anh_dai_dien: google_avatar,
                so_dien_thoai: null,
                dia_chi: null,
                gioi_tinh: 'khac',
                isNewUser: true
            });

        } catch (error) {
            console.error('Lỗi Google OAuth User:', error);
            return done(error, null);
        }
    }));

module.exports = passport;
