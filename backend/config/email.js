const nodemailer = require('nodemailer');
require('dotenv').config();

// Cấu hình transporter
const transporter = nodemailer.createTransport({
    service: 'gmail', // hoặc 'smtp.gmail.com'
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD // App Password từ Google
    }
});

// Verify connection
transporter.verify(function (error, success) {
    if (error) {
        console.log('❌ Lỗi kết nối email:', error);
    } else {
        console.log('✅ Email server sẵn sàng gửi mail');
    }
});

// Gửi email xác thực
async function sendVerificationEmail(email, verificationCode, userName) {
    const mailOptions = {
        from: `"Nhà hàng Phương Nam" <${process.env.EMAIL_USER}>`,
        to: email,
        subject: 'Xác thực tài khoản - Nhà hàng Phương Nam',
        html: `
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        line-height: 1.6;
                        color: #333;
                    }
                    .container {
                        max-width: 600px;
                        margin: 0 auto;
                        padding: 20px;
                        background-color: #f9f9f9;
                    }
                    .header {
                        background: linear-gradient(135deg, #ea580c 0%, #dc2626 100%);
                        color: white;
                        padding: 30px;
                        text-align: center;
                        border-radius: 10px 10px 0 0;
                    }
                    .content {
                        background: white;
                        padding: 30px;
                        border-radius: 0 0 10px 10px;
                    }
                    .code-box {
                        background: #fff5f0;
                        border: 2px dashed #ea580c;
                        padding: 20px;
                        text-align: center;
                        margin: 20px 0;
                        border-radius: 8px;
                    }
                    .code {
                        font-size: 32px;
                        font-weight: bold;
                        color: #ea580c;
                        letter-spacing: 5px;
                    }
                    .button {
                        display: inline-block;
                        background: linear-gradient(135deg, #ea580c 0%, #dc2626 100%);
                        color: white;
                        padding: 12px 30px;
                        text-decoration: none;
                        border-radius: 5px;
                        margin: 20px 0;
                    }
                    .footer {
                        text-align: center;
                        margin-top: 20px;
                        color: #666;
                        font-size: 12px;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>🍽️ Nhà hàng Phương Nam</h1>
                        <p>Xác thực tài khoản của bạn</p>
                    </div>
                    <div class="content">
                        <h2>Xin chào ${userName}!</h2>
                        <p>Cảm ơn bạn đã đăng ký tài khoản tại <strong>Nhà hàng Phương Nam</strong>.</p>
                        <p>Để hoàn tất quá trình đăng ký, vui lòng nhập mã xác thực bên dưới:</p>
                        
                        <div class="code-box">
                            <p style="margin: 0; color: #666;">Mã xác thực của bạn:</p>
                            <div class="code">${verificationCode}</div>
                            <p style="margin: 10px 0 0 0; color: #999; font-size: 14px;">Mã có hiệu lực trong 10 phút</p>
                        </div>
                        
                        <p><strong>Lưu ý:</strong></p>
                        <ul>
                            <li>Mã xác thực chỉ có hiệu lực trong <strong>10 phút</strong></li>
                            <li>Không chia sẻ mã này với bất kỳ ai</li>
                            <li>Nếu bạn không yêu cầu đăng ký, vui lòng bỏ qua email này</li>
                        </ul>
                        
                        <p>Trân trọng,<br><strong>Đội ngũ Nhà hàng Phương Nam</strong></p>
                    </div>
                    <div class="footer">
                        <p>Email này được gửi tự động, vui lòng không trả lời.</p>
                        <p>© 2025 Nhà hàng Phương Nam - Vĩnh Long</p>
                    </div>
                </div>
            </body>
            </html>
        `
    };

    try {
        const info = await transporter.sendMail(mailOptions);
        console.log('✅ Email đã gửi:', info.messageId);
        return { success: true, messageId: info.messageId };
    } catch (error) {
        console.error('❌ Lỗi gửi email:', error);
        return { success: false, error: error.message };
    }
}

// Gửi email chào mừng sau khi xác thực thành công
async function sendWelcomeEmail(email, userName) {
    const mailOptions = {
        from: `"Nhà hàng Phương Nam" <${process.env.EMAIL_USER}>`,
        to: email,
        subject: 'Chào mừng đến với Nhà hàng Phương Nam! 🎉',
        html: `
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        line-height: 1.6;
                        color: #333;
                    }
                    .container {
                        max-width: 600px;
                        margin: 0 auto;
                        padding: 20px;
                        background-color: #f9f9f9;
                    }
                    .header {
                        background: linear-gradient(135deg, #ea580c 0%, #dc2626 100%);
                        color: white;
                        padding: 30px;
                        text-align: center;
                        border-radius: 10px 10px 0 0;
                    }
                    .content {
                        background: white;
                        padding: 30px;
                        border-radius: 0 0 10px 10px;
                    }
                    .button {
                        display: inline-block;
                        background: linear-gradient(135deg, #ea580c 0%, #dc2626 100%);
                        color: white;
                        padding: 12px 30px;
                        text-decoration: none;
                        border-radius: 5px;
                        margin: 20px 0;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>🎉 Chào mừng bạn!</h1>
                    </div>
                    <div class="content">
                        <h2>Xin chào ${userName}!</h2>
                        <p>Tài khoản của bạn đã được kích hoạt thành công! 🎊</p>
                        <p>Bạn đã trở thành thành viên của <strong>Nhà hàng Phương Nam</strong>.</p>
                        
                        <p><strong>Bạn có thể:</strong></p>
                        <ul>
                            <li>🍽️ Đặt món ăn trực tuyến</li>
                            <li>📅 Đặt bàn trước</li>
                            <li>🎁 Nhận ưu đãi đặc biệt</li>
                            <li>⭐ Đánh giá và bình luận món ăn</li>
                        </ul>
                        
                        <div style="text-align: center;">
                            <a href="http://localhost:3000" class="button">Khám phá thực đơn ngay</a>
                        </div>
                        
                        <p>Cảm ơn bạn đã tin tưởng và lựa chọn chúng tôi!</p>
                        <p>Trân trọng,<br><strong>Đội ngũ Nhà hàng Phương Nam</strong></p>
                    </div>
                </div>
            </body>
            </html>
        `
    };

    try {
        const info = await transporter.sendMail(mailOptions);
        console.log('✅ Email chào mừng đã gửi:', info.messageId);
        return { success: true, messageId: info.messageId };
    } catch (error) {
        console.error('❌ Lỗi gửi email chào mừng:', error);
        return { success: false, error: error.message };
    }
}

module.exports = {
    sendVerificationEmail,
    sendWelcomeEmail
};
