const nodemailer = require('nodemailer');
require('dotenv').config();

console.log('🔍 Kiểm tra cấu hình email...\n');

// Hiển thị cấu hình (ẩn password)
console.log('📧 Email User:', process.env.EMAIL_USER || '❌ CHƯA CẤU HÌNH');
console.log('🔑 Email Password:', process.env.EMAIL_PASSWORD ? '✅ Đã cấu hình' : '❌ CHƯA CẤU HÌNH');
console.log('');

if (!process.env.EMAIL_USER || !process.env.EMAIL_PASSWORD) {
    console.log('❌ VUI LÒNG CẤU HÌNH EMAIL TRONG FILE .env\n');
    console.log('Mở file backend/.env và thêm:');
    console.log('EMAIL_USER=your-email@gmail.com');
    console.log('EMAIL_PASSWORD=your-app-password\n');
    console.log('📖 Xem hướng dẫn chi tiết trong file HUONG_DAN_EMAIL.md');
    process.exit(1);
}

// Tạo transporter
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD
    }
});

console.log('🔄 Đang kiểm tra kết nối...\n');

// Test connection
transporter.verify(function (error, success) {
    if (error) {
        console.log('❌ LỖI KẾT NỐI EMAIL:\n');
        console.log(error.message);
        console.log('\n📖 HƯỚNG DẪN KHẮC PHỤC:');
        console.log('1. Truy cập: https://myaccount.google.com/security');
        console.log('2. Bật "2-Step Verification"');
        console.log('3. Tạo "App Password" cho Mail');
        console.log('4. Copy mã 16 ký tự vào file .env');
        console.log('5. Khởi động lại server\n');
        console.log('📄 Xem chi tiết trong file: HUONG_DAN_EMAIL.md');
        process.exit(1);
    } else {
        console.log('✅ KẾT NỐI EMAIL THÀNH CÔNG!\n');
        console.log('📧 Đang gửi email test...\n');
        
        // Gửi email test
        const mailOptions = {
            from: `"Nhà hàng Phương Nam" <${process.env.EMAIL_USER}>`,
            to: process.env.EMAIL_USER, // Gửi cho chính mình
            subject: '✅ Test Email - Nhà hàng Phương Nam',
            html: `
                <div style="font-family: Arial, sans-serif; padding: 20px; background-color: #f9f9f9;">
                    <div style="max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px;">
                        <h2 style="color: #ea580c;">🎉 Email đã được cấu hình thành công!</h2>
                        <p>Hệ thống email của <strong>Nhà hàng Phương Nam</strong> đã sẵn sàng hoạt động.</p>
                        <p>Bạn có thể bắt đầu sử dụng chức năng xác thực email khi đăng ký tài khoản.</p>
                        <hr style="border: 1px solid #eee; margin: 20px 0;">
                        <p style="color: #666; font-size: 14px;">
                            Email này được gửi tự động từ hệ thống test.<br>
                            Thời gian: ${new Date().toLocaleString('vi-VN')}
                        </p>
                    </div>
                </div>
            `
        };
        
        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.log('❌ Lỗi gửi email:', error.message);
                process.exit(1);
            } else {
                console.log('✅ GỬI EMAIL TEST THÀNH CÔNG!');
                console.log('📬 Message ID:', info.messageId);
                console.log('📧 Kiểm tra hộp thư:', process.env.EMAIL_USER);
                console.log('\n🎉 HỆ THỐNG EMAIL ĐÃ SẴN SÀNG!\n');
                process.exit(0);
            }
        });
    }
});
