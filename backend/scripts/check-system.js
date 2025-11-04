const db = require('../config/database');
require('dotenv').config();

console.log('🔍 KIỂM TRA HỆ THỐNG\n');
console.log('='.repeat(50));

let hasError = false;

// 1. Kiểm tra Database
console.log('\n1️⃣ KIỂM TRA DATABASE');
console.log('-'.repeat(50));

db.query('SELECT 1')
    .then(() => {
        console.log('✅ Kết nối database: OK');
        return db.query('SELECT COUNT(*) as count FROM nguoi_dung');
    })
    .then(([rows]) => {
        console.log(`✅ Bảng nguoi_dung: OK (${rows[0].count} người dùng)`);
        return db.query('SELECT COUNT(*) as count FROM xac_thuc_email');
    })
    .then(([rows]) => {
        console.log(`✅ Bảng xac_thuc_email: OK (${rows[0].count} bản ghi)`);
    })
    .catch(err => {
        console.log('❌ Lỗi database:', err.message);
        hasError = true;
    })
    .finally(() => {
        // 2. Kiểm tra Email Config
        console.log('\n2️⃣ KIỂM TRA CẤU HÌNH EMAIL');
        console.log('-'.repeat(50));
        
        if (!process.env.EMAIL_USER || process.env.EMAIL_USER === 'your-email@gmail.com') {
            console.log('❌ EMAIL_USER: Chưa cấu hình');
            console.log('   → Cần cập nhật trong file .env');
            hasError = true;
        } else {
            console.log('✅ EMAIL_USER:', process.env.EMAIL_USER);
        }
        
        if (!process.env.EMAIL_PASSWORD || process.env.EMAIL_PASSWORD === 'your-app-password-here') {
            console.log('❌ EMAIL_PASSWORD: Chưa cấu hình');
            console.log('   → Cần tạo App Password từ Google');
            hasError = true;
        } else {
            console.log('✅ EMAIL_PASSWORD: Đã cấu hình');
        }
        
        // 3. Kiểm tra JWT Secret
        console.log('\n3️⃣ KIỂM TRA JWT SECRET');
        console.log('-'.repeat(50));
        
        if (process.env.JWT_SECRET && process.env.JWT_SECRET !== 'your-secret-key-change-this') {
            console.log('✅ JWT_SECRET: OK');
        } else {
            console.log('⚠️  JWT_SECRET: Nên thay đổi để bảo mật hơn');
        }
        
        // 4. Kiểm tra thư mục upload
        console.log('\n4️⃣ KIỂM TRA THƯ MỤC UPLOAD');
        console.log('-'.repeat(50));
        
        const fs = require('fs');
        const path = require('path');
        
        const avatarDir = path.join(__dirname, '../images/avatars');
        if (fs.existsSync(avatarDir)) {
            console.log('✅ Thư mục avatars: OK');
        } else {
            console.log('❌ Thư mục avatars: Không tồn tại');
            hasError = true;
        }
        
        // Tổng kết
        console.log('\n' + '='.repeat(50));
        console.log('📊 TỔNG KẾT');
        console.log('='.repeat(50));
        
        if (hasError) {
            console.log('\n❌ HỆ THỐNG CHƯA SẴN SÀNG\n');
            console.log('📋 CẦN LÀM:');
            
            if (!process.env.EMAIL_USER || process.env.EMAIL_USER === 'your-email@gmail.com') {
                console.log('1. Cập nhật EMAIL_USER trong file .env');
            }
            
            if (!process.env.EMAIL_PASSWORD || process.env.EMAIL_PASSWORD === 'your-app-password-here') {
                console.log('2. Tạo App Password và cập nhật EMAIL_PASSWORD');
                console.log('   Link: https://myaccount.google.com/apppasswords');
            }
            
            console.log('\n📖 Xem hướng dẫn chi tiết:');
            console.log('   - CHECKLIST_CAU_HINH.md');
            console.log('   - QUICK_START_EMAIL.md');
            console.log('   - HUONG_DAN_EMAIL.md\n');
        } else {
            console.log('\n✅ HỆ THỐNG ĐÃ SẴN SÀNG!\n');
            console.log('🚀 Bạn có thể:');
            console.log('   1. Khởi động server: npm start');
            console.log('   2. Test email: node scripts/test-email.js');
            console.log('   3. Mở trang đăng ký: frontend/dang-ky.html\n');
        }
        
        process.exit(hasError ? 1 : 0);
    });
