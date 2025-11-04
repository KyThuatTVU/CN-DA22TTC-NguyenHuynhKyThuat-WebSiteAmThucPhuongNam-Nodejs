# 📧 HƯỚNG DẪN CẤU HÌNH EMAIL CHI TIẾT (CÓ HÌNH ẢNH)

## 🎯 Mục đích:
Cấu hình Gmail để hệ thống có thể **GỬI EMAIL XÁC THỰC** khi người dùng đăng ký tài khoản.

## ⚠️ Lỗi hiện tại:
```
Error: Invalid login: 535-5.7.8 Username and Password not accepted
```

**Nguyên nhân:** Chưa cấu hình App Password từ Google

---

## ✅ HƯỚNG DẪN CHI TIẾT (3 BƯỚC - 5 PHÚT):

### 🔐 BƯỚC 1: Bật 2-Step Verification (Xác thực 2 bước)

**Thời gian:** 2-3 phút

#### 1.1. Truy cập Google Account Security
```
🔗 Link: https://myaccount.google.com/security
```

Hoặc:
- Vào Gmail → Click vào avatar (góc phải trên)
- Chọn **"Manage your Google Account"**
- Click tab **"Security"** (Bảo mật)

#### 1.2. Tìm mục "2-Step Verification"
- Scroll xuống phần **"How you sign in to Google"**
- Tìm **"2-Step Verification"** (Xác minh 2 bước)
- Nếu thấy **"OFF"** → Click vào để bật

#### 1.3. Bật 2-Step Verification
1. Click **"Get started"** (Bắt đầu)
2. Đăng nhập lại nếu được yêu cầu
3. Nhập số điện thoại của bạn
4. Chọn nhận mã qua **SMS** hoặc **Phone call**
5. Nhập mã xác thực nhận được
6. Click **"Turn on"** (Bật)

✅ **Hoàn tất!** Bạn sẽ thấy trạng thái **"ON"**

---

### 🔑 BƯỚC 2: Tạo App Password (Mật khẩu ứng dụng)

**Thời gian:** 1-2 phút

#### 2.1. Truy cập App Passwords

**Cách 1 - Link trực tiếp:**
```
🔗 Link: https://myaccount.google.com/apppasswords
```

**Cách 2 - Từ Security:**
1. Vào: https://myaccount.google.com/security
2. Scroll xuống phần **"How you sign in to Google"**
3. Tìm **"App passwords"** (Mật khẩu ứng dụng)
4. Click vào **"App passwords"**

⚠️ **Lưu ý:** Nếu không thấy "App passwords":
- Kiểm tra đã bật 2-Step Verification chưa (Bước 1)
- Đăng xuất và đăng nhập lại

#### 2.2. Tạo App Password mới

1. **Đăng nhập lại** nếu được yêu cầu

2. Bạn sẽ thấy trang **"App passwords"**

3. Ở phần **"Select app"** (Chọn ứng dụng):
   - Click vào dropdown
   - Chọn **"Mail"**

4. Ở phần **"Select device"** (Chọn thiết bị):
   - Click vào dropdown
   - Chọn **"Other (Custom name)"** (Khác - Tên tùy chỉnh)
   - Nhập tên: `Nha Hang Phuong Nam` hoặc `Restaurant Website`

5. Click nút **"Generate"** (Tạo)

#### 2.3. Copy App Password

Google sẽ hiển thị một popup với:
```
┌─────────────────────────────────────┐
│  Your app password for your device  │
│                                     │
│     abcd efgh ijkl mnop            │
│                                     │
│  [Copy]                    [Done]   │
└─────────────────────────────────────┘
```

**MÃ 16 KÝ TỰ** (có dấu cách) dạng: `abcd efgh ijkl mnop`

⚠️ **QUAN TRỌNG:**
- **COPY MÃ NÀY NGAY** (chỉ hiển thị 1 lần!)
- Có thể click nút **"Copy"** để copy tự động
- Lưu vào Notepad tạm thời
- Không chia sẻ mã này với ai

✅ Click **"Done"** sau khi đã copy

---

### 📝 BƯỚC 3: Cập nhật file .env

**Thời gian:** 1 phút

#### 3.1. Mở file cấu hình

Trong VS Code hoặc editor của bạn:
1. Mở file: `backend/.env`
2. Tìm 2 dòng:
```env
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password-here
```

#### 3.2. Thay đổi thông tin

**Thay đổi EMAIL_USER:**
```env
EMAIL_USER=email-cua-ban@gmail.com
```
👆 Thay bằng **email Gmail thật** của bạn (email đã tạo App Password)

**Thay đổi EMAIL_PASSWORD:**
```env
EMAIL_PASSWORD=abcd efgh ijkl mnop
```
👆 **Paste App Password** vừa copy từ Bước 2

#### 3.3. Ví dụ thực tế

**TRƯỚC KHI SỬA:**
```env
# Email Configuration (Gmail)
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password-here
```

**SAU KHI SỬA:**
```env
# Email Configuration (Gmail)
EMAIL_USER=phuongnam.restaurant@gmail.com
EMAIL_PASSWORD=abcd efgh ijkl mnop
```

⚠️ **Lưu ý:**
- Giữ nguyên **dấu cách** trong App Password
- Không thêm dấu ngoặc kép `""`
- Không có khoảng trắng thừa

#### 3.4. Lưu file

- Nhấn **Ctrl + S** (Windows) hoặc **Cmd + S** (Mac)
- Đảm bảo file đã được lưu

---

### BƯỚC 4: Khởi động lại server

```bash
# Dừng server hiện tại (Ctrl + C)
# Sau đó chạy lại:
cd backend
npm start
```

Nếu thành công, bạn sẽ thấy:
```
✅ Email server sẵn sàng gửi mail
```

---

## 🎯 KIỂM TRA NHANH:

### Test 1: Kiểm tra file .env
```bash
cd backend
type .env | findstr EMAIL
```

Phải thấy:
```
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=xxxx xxxx xxxx xxxx
```

### Test 2: Test gửi email
Mở `frontend/test-register.html` và thử đăng ký

---

## ❌ CÁC LỖI THƯỜNG GẶP:

### 1. "App passwords" không hiển thị
**Nguyên nhân:** Chưa bật 2-Step Verification
**Giải pháp:** Bật 2FA trước (Bước 1)

### 2. Vẫn lỗi sau khi cập nhật
**Nguyên nhân:** 
- App Password sai
- Chưa khởi động lại server
- Email không đúng

**Giải pháp:**
1. Xóa App Password cũ trên Google
2. Tạo App Password mới
3. Copy chính xác (bao gồm cả dấu cách)
4. Khởi động lại server

### 3. "Less secure app access"
**Lưu ý:** Google đã TẮT tính năng này từ 2022
**Giải pháp:** PHẢI dùng App Password (không thể dùng mật khẩu thường)

---

## 🔐 BẢO MẬT:

- ✅ App Password chỉ dùng cho ứng dụng này
- ✅ Có thể thu hồi bất cứ lúc nào
- ✅ Không ảnh hưởng đến tài khoản Gmail chính
- ✅ Không chia sẻ App Password với ai

---

## 📱 NẾU KHÔNG DÙNG GMAIL:

### Outlook/Hotmail:
```javascript
service: 'hotmail',
auth: {
    user: 'your-email@outlook.com',
    pass: 'your-password'
}
```

### Yahoo:
```javascript
service: 'yahoo',
auth: {
    user: 'your-email@yahoo.com',
    pass: 'app-password'
}
```

### SMTP tùy chỉnh:
```javascript
host: 'smtp.example.com',
port: 587,
secure: false,
auth: {
    user: 'your-email@example.com',
    pass: 'your-password'
}
```

---

## 🆘 VẪN GẶP VẤN ĐỀ?

1. Kiểm tra kết nối internet
2. Thử email khác
3. Xem log chi tiết trong terminal
4. Kiểm tra Gmail có bị khóa không

---

## ✅ SAU KHI CẤU HÌNH XONG:

1. Server khởi động thành công
2. Test đăng ký tài khoản
3. Kiểm tra email (cả Inbox và Spam)
4. Nhập mã xác thực
5. Hoàn tất!

**Chúc bạn thành công! 🎉**


---

## 🧪 BƯỚC 4: KIỂM TRA CẤU HÌNH

### 4.1. Test kết nối email

Mở Terminal/Command Prompt và chạy:

```bash
cd backend
node scripts/test-email.js
```

### 4.2. Kết quả mong đợi

**✅ THÀNH CÔNG:**
```
🔍 Kiểm tra cấu hình email...

📧 Email User: phuongnam.restaurant@gmail.com
🔑 Email Password: ✅ Đã cấu hình

🔄 Đang kiểm tra kết nối...

✅ KẾT NỐI EMAIL THÀNH CÔNG!

📧 Đang gửi email test...

✅ GỬI EMAIL TEST THÀNH CÔNG!
📬 Message ID: <abc123@gmail.com>
📧 Kiểm tra hộp thư: phuongnam.restaurant@gmail.com

🎉 HỆ THỐNG EMAIL ĐÃ SẴN SÀNG!
```

**❌ THẤT BẠI:**
```
❌ LỖI KẾT NỐI EMAIL:
Invalid login: 535-5.7.8 Username and Password not accepted
```

→ Quay lại kiểm tra Bước 2 và 3

### 4.3. Kiểm tra email

1. Mở Gmail của bạn
2. Kiểm tra **Inbox** (Hộp thư đến)
3. Nếu không thấy, kiểm tra **Spam** (Thư rác)
4. Bạn sẽ thấy email test với tiêu đề: **"✅ Test Email - Nhà hàng Phương Nam"**

---

## 🎯 BƯỚC 5: TEST ĐĂNG KÝ THẬT

### 5.1. Khởi động server

```bash
cd backend
npm start
```

Đợi đến khi thấy:
```
✅ Kết nối database thành công!
✅ Email server sẵn sàng gửi mail
🚀 Server đang chạy tại http://localhost:3000
```

### 5.2. Mở trang đăng ký

**Cách 1 - Test đơn giản:**
```
Mở file: frontend/test-register.html
```

**Cách 2 - Trang đăng ký đầy đủ:**
```
Mở file: frontend/dang-ky.html
```

### 5.3. Điền thông tin và đăng ký

1. Điền **họ tên**
2. Điền **email** (email thật của bạn để nhận mã)
3. Điền **mật khẩu**
4. Click **"Đăng ký"**

### 5.4. Kiểm tra email

1. Hệ thống sẽ hiển thị: **"Mã xác thực đã được gửi đến email của bạn!"**
2. Mở email của bạn
3. Tìm email từ **"Nhà hàng Phương Nam"**
4. Bạn sẽ thấy **MÃ 6 SỐ** trong email

### 5.5. Nhập mã xác thực

1. Trang sẽ tự động chuyển đến `xac-thuc-email.html`
2. Nhập **6 số** từ email
3. Click **"Xác thực"**
4. Nếu đúng → Tài khoản được tạo → Đăng nhập tự động

---

## 📊 TỔNG KẾT LUỒNG HOẠT ĐỘNG

```
┌─────────────────────────────────────────────────────────────┐
│  1. User điền form đăng ký                                  │
│     ↓                                                       │
│  2. Click "Đăng ký"                                        │
│     ↓                                                       │
│  3. Hệ thống kiểm tra email đã tồn tại chưa               │
│     ↓                                                       │
│  4. Tạo mã xác thực 6 số ngẫu nhiên                       │
│     ↓                                                       │
│  5. 📧 GỬI EMAIL chứa mã đến user                         │
│     ↓                                                       │
│  6. Lưu thông tin tạm vào bảng xac_thuc_email            │
│     ↓                                                       │
│  7. User mở email → Nhận mã 6 số                          │
│     ↓                                                       │
│  8. User nhập mã vào trang xác thực                       │
│     ↓                                                       │
│  9. Hệ thống kiểm tra mã                                  │
│     ↓                                                       │
│ 10. ✅ Nếu đúng:                                          │
│     - Tạo tài khoản trong bảng nguoi_dung                │
│     - Gửi email chào mừng                                 │
│     - Tạo JWT token                                       │
│     - Đăng nhập tự động                                   │
└─────────────────────────────────────────────────────────────┘
```

---

## ❓ TROUBLESHOOTING (KHẮC PHỤC SỰ CỐ)

### ❌ Vấn đề 1: Không thấy "App passwords"

**Nguyên nhân:**
- Chưa bật 2-Step Verification
- Tài khoản Google Workspace (doanh nghiệp)

**Giải pháp:**
1. Bật 2-Step Verification (Bước 1)
2. Đăng xuất và đăng nhập lại
3. Nếu vẫn không có → Dùng email cá nhân khác

---

### ❌ Vấn đề 2: Vẫn lỗi "Invalid login"

**Nguyên nhân:**
- App Password sai
- Copy thiếu/thừa ký tự
- Email sai

**Giải pháp:**
1. Xóa App Password cũ trên Google
2. Tạo App Password mới
3. Copy chính xác (bao gồm dấu cách)
4. Kiểm tra email đúng chưa
5. Khởi động lại server

---

### ❌ Vấn đề 3: Không nhận được email

**Nguyên nhân:**
- Email vào Spam
- Server chưa chạy
- Cấu hình sai

**Giải pháp:**
1. Kiểm tra thư mục **Spam**
2. Kiểm tra server đang chạy: `npm start`
3. Chạy test: `node scripts/test-email.js`
4. Kiểm tra log trong terminal

---

### ❌ Vấn đề 4: Mã xác thực hết hạn

**Nguyên nhân:**
- Mã có hiệu lực 10 phút
- Đã quá thời gian

**Giải pháp:**
1. Click nút **"Gửi lại"** trên trang xác thực
2. Nhập mã mới từ email mới nhất

---

## 🔐 BẢO MẬT

### ✅ An toàn:
- App Password chỉ dùng cho ứng dụng này
- Có thể thu hồi bất cứ lúc nào
- Không ảnh hưởng đến tài khoản Gmail chính
- Không thể dùng để đăng nhập Gmail

### ⚠️ Lưu ý:
- Không chia sẻ App Password
- Không commit file .env lên Git
- Thêm `.env` vào `.gitignore`

---

## 📞 HỖ TRỢ

### Nếu vẫn gặp vấn đề:

1. **Kiểm tra log server:**
   ```bash
   cd backend
   npm start
   ```
   Xem có lỗi gì trong terminal

2. **Kiểm tra database:**
   ```bash
   node scripts/check-users-table.js
   ```

3. **Test email:**
   ```bash
   node scripts/test-email.js
   ```

4. **Xem file log:**
   - Mở Developer Tools (F12)
   - Tab Console
   - Xem có lỗi JavaScript không

---

## ✅ CHECKLIST HOÀN THÀNH

- [ ] Bật 2-Step Verification
- [ ] Tạo App Password
- [ ] Cập nhật file .env
- [ ] Test email thành công
- [ ] Server chạy không lỗi
- [ ] Test đăng ký thành công
- [ ] Nhận được email xác thực
- [ ] Xác thực mã thành công
- [ ] Tài khoản được tạo

---

## 🎉 HOÀN TẤT!

Sau khi hoàn thành tất cả các bước, hệ thống xác thực email đã sẵn sàng hoạt động!

**Người dùng giờ đây có thể:**
- Đăng ký tài khoản
- Nhận email xác thực
- Xác nhận email hoạt động
- Tạo tài khoản thành công

**Chúc mừng bạn! 🎊**
