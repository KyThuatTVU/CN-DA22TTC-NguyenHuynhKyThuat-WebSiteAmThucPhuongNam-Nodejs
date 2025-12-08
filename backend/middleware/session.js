/**
 * Session Middleware Configuration
 * Cấu hình Express Session
 */

const session = require('express-session');

const sessionMiddleware = session({
    secret: process.env.SESSION_SECRET || 'your-session-secret-change-this',
    resave: true, // Quan trọng: lưu lại session mỗi request
    saveUninitialized: false,
    cookie: {
        secure: false, // false cho localhost (không dùng HTTPS)
        httpOnly: true,
        sameSite: 'lax', // Quan trọng: cho phép cookie cross-site
        maxAge: 24 * 60 * 60 * 1000 // 24 giờ
    }
});

module.exports = sessionMiddleware;
