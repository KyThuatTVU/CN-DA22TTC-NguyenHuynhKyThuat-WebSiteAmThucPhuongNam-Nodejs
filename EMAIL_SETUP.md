# Hướng dẫn cấu hình Email Verification

## 📧 Cấu hình Gmail để gửi email

### Bước 1: Tạo App Password từ Google

1. Đăng nhập vào tài khoản Google của bạn
2. Truy cập: https://myaccount.google.com/security
3. Bật **2-Step Verification** (nếu chưa bật)
4. Sau khi bật 2FA, quay lại Security settings
5. Tìm và click vào **App passwords**
6. Chọn app: **Mail**
7. Chọn device: **Other (Custom name)** → Nhập "Nha Hang Phuong Nam"
8. Click **Generate**
9. Copy mã 16 ký tự (dạng: xxxx xxxx xxxx xxxx)

### Bước 2: Cập nhật file .env

Mở file `backend/.env` và cập nhật:

```env
# Email Configuration (Gmail)
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=xxxx xxxx xxxx xxxx
```

**Lưu ý:** 
- Thay `your-email@gmail.com` bằng email Gmail của bạn
- Thay `xxxx xxxx xxxx xxxx` bằng App Password vừa tạo (giữ nguyên dấu cách)

### Bước 3: Khởi động lại server

```bash
cd backend
npm start
```

Nếu cấu hình đúng, bạn sẽ thấy:
```
✅ Email server sẵn sàng gửi mail
```

## 🔄 Luồng hoạt động Email Verification

### 1. User điền form đăng ký
- Họ tên, email, mật khẩu, v.v.
- Upload avatar (tùy chọn)

### 2. Click "Đăng ký"
- Frontend gọi API `/api/auth/send-verification`
- Backend kiểm tra email đã tồn tại chưa
- Tạo mã xác thực 6 số ngẫu nhiên
- Lưu thông tin tạm vào bảng `xac_thuc_email`
- Gửi email chứa mã xác thực
- Redirect user đến trang xác thực

### 3. User nhận email
- Email chứa mã 6 số
- Mã có hiệu lực 10 phút
- Email có thiết kế đẹp, chuyên nghiệp

### 4. User nhập mã xác thực
- Nhập 6 số vào form
- Auto-focus và move giữa các ô
- Có thể paste cả 6 số cùng lúc
- Countdown timer 10 phút

### 5. Xác thực thành công
- Backend kiểm tra mã
- Tạo tài khoản trong bảng `nguoi_dung`
- Gửi email chào mừng
- Tạo JWT token
- Redirect về trang chủ (đã đăng nhập)

## 📊 Database Schema

### Bảng `xac_thuc_email`:
```sql
CREATE TABLE xac_thuc_email (
    ma_xac_thuc INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    ma_code VARCHAR(6) NOT NULL,
    ten_nguoi_dung VARCHAR(150) NOT NULL,
    so_dien_thoai VARCHAR(20),
    mat_khau_hash VARCHAR(255) NOT NULL,
    dia_chi VARCHAR(300),
    gioi_tinh ENUM('khac','nam','nu') DEFAULT 'khac',
    anh_dai_dien VARCHAR(500),
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_het_han DATETIME NOT NULL,
    trang_thai ENUM('pending', 'verified', 'expired') DEFAULT 'pending',
    INDEX (email),
    INDEX (ma_code),
    INDEX (ngay_het_han)
);
```

### Event tự động xóa mã hết hạn:
```sql
CREATE EVENT clean_expired_verification_codes
ON SCHEDULE EVERY 1 HOUR
DO
DELETE FROM xac_thuc_email 
WHERE ngay_het_han < NOW() OR trang_thai = 'expired';
```

## 🔌 API Endpoints

### 1. Gửi mã xác thực
```
POST /api/auth/send-verification
Content-Type: application/json

Body:
{
  "ten_nguoi_dung": "Nguyễn Văn A",
  "email": "test@example.com",
  "so_dien_thoai": "0123456789",
  "mat_khau": "123456",
  "dia_chi": "123 ABC",
  "gioi_tinh": "nam",
  "anh_dai_dien": "/images/avatars/avatar-123.jpg"
}

Response:
{
  "success": true,
  "message": "Mã xác thực đã được gửi đến email của bạn",
  "data": {
    "email": "test@example.com",
    "expires_in": "10 phút"
  }
}
```

### 2. Xác thực email
```
POST /api/auth/verify-email
Content-Type: application/json

Body:
{
  "email": "test@example.com",
  "ma_code": "123456"
}

Response:
{
  "success": true,
  "message": "Xác thực thành công! Tài khoản đã được tạo.",
  "data": {
    "ma_nguoi_dung": 1,
    "ten_nguoi_dung": "Nguyễn Văn A",
    "email": "test@example.com",
    "anh_dai_dien": "/images/avatars/avatar-123.jpg",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 3. Gửi lại mã xác thực
```
POST /api/auth/resend-verification
Content-Type: application/json

Body:
{
  "email": "test@example.com"
}

Response:
{
  "success": true,
  "message": "Mã xác thực mới đã được gửi đến email của bạn"
}
```

## ✨ Features

### Email Template:
- ✅ Thiết kế đẹp, responsive
- ✅ Hiển thị mã xác thực rõ ràng
- ✅ Countdown timer
- ✅ Hướng dẫn sử dụng
- ✅ Branding nhà hàng

### Verification Page:
- ✅ 6 ô input riêng biệt
- ✅ Auto-focus giữa các ô
- ✅ Paste cả 6 số cùng lúc
- ✅ Countdown timer 10 phút
- ✅ Nút gửi lại mã (cooldown 60s)
- ✅ Validation real-time

### Security:
- ✅ Mã hết hạn sau 10 phút
- ✅ Mã chỉ dùng được 1 lần
- ✅ Tự động xóa mã hết hạn
- ✅ Kiểm tra email unique
- ✅ Hash mật khẩu trước khi lưu

## 🧪 Test

### 1. Tạo bảng xác thực:
```bash
cd backend
node scripts/create-verification-table.js
```

### 2. Khởi động server:
```bash
npm start
```

### 3. Test flow:
1. Mở `frontend/dang-ky.html`
2. Điền thông tin đăng ký
3. Click "Đăng ký"
4. Kiểm tra email (cả Inbox và Spam)
5. Nhập mã 6 số
6. Click "Xác thực"
7. Kiểm tra đã đăng nhập thành công

## ⚠️ Troubleshooting

### Không nhận được email:
1. Kiểm tra email có trong Spam không
2. Kiểm tra App Password đã đúng chưa
3. Kiểm tra 2FA đã bật chưa
4. Xem log server có lỗi không

### Lỗi "Invalid login":
- App Password sai hoặc hết hạn
- Tạo lại App Password mới

### Mã xác thực không đúng:
- Kiểm tra đã hết hạn chưa (10 phút)
- Gửi lại mã mới
- Kiểm tra database bảng `xac_thuc_email`

## 📝 Notes

- Mã xác thực có hiệu lực 10 phút
- Cooldown gửi lại mã: 60 giây
- Event tự động xóa mã hết hạn: mỗi 1 giờ
- Email chào mừng gửi sau khi xác thực thành công
