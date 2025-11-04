# ⚡ HƯỚNG DẪN NHANH - 3 BƯỚC (5 PHÚT)

## 🎯 Mục tiêu: Cấu hình Gmail để gửi email xác thực

---

## 📋 BƯỚC 1: TẠO APP PASSWORD (2 phút)

### 1️⃣ Truy cập link này:
```
https://myaccount.google.com/apppasswords
```

### 2️⃣ Nếu chưa bật 2FA:
- Bật "2-Step Verification" trước
- Link: https://myaccount.google.com/security

### 3️⃣ Tạo App Password:
```
┌─────────────────────────────────────┐
│  Select app:    [Mail ▼]           │
│  Select device: [Other ▼]          │
│  Name: Nha Hang Phuong Nam         │
│                                     │
│         [Generate]                  │
└─────────────────────────────────────┘
```

### 4️⃣ Copy mã 16 ký tự:
```
┌─────────────────────────────────────┐
│     abcd efgh ijkl mnop            │
│                                     │
│  [Copy]                    [Done]   │
└─────────────────────────────────────┘
```

⚠️ **COPY NGAY** - Chỉ hiển thị 1 lần!

---

## 📝 BƯỚC 2: CẬP NHẬT FILE .ENV (1 phút)

### Mở file: `backend/.env`

### Tìm và sửa 2 dòng:

**TRƯỚC:**
```env
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password-here
```

**SAU:**
```env
EMAIL_USER=email-cua-ban@gmail.com
EMAIL_PASSWORD=abcd efgh ijkl mnop
```

### Ví dụ thực tế:
```env
EMAIL_USER=phuongnam.restaurant@gmail.com
EMAIL_PASSWORD=abcd efgh ijkl mnop
```

⚠️ **Lưu ý:**
- Thay `email-cua-ban@gmail.com` bằng Gmail thật của bạn
- Paste App Password vừa copy (giữ nguyên dấu cách)
- Nhấn **Ctrl + S** để lưu

---

## ✅ BƯỚC 3: TEST (2 phút)

### 1️⃣ Mở Terminal và chạy:
```bash
cd backend
node scripts/test-email.js
```

### 2️⃣ Kết quả mong đợi:
```
✅ KẾT NỐI EMAIL THÀNH CÔNG!
✅ GỬI EMAIL TEST THÀNH CÔNG!
🎉 HỆ THỐNG EMAIL ĐÃ SẴN SÀNG!
```

### 3️⃣ Kiểm tra email:
- Mở Gmail của bạn
- Tìm email test từ "Nhà hàng Phương Nam"

---

## 🚀 HOÀN TẤT! BẮT ĐẦU SỬ DỤNG

### Khởi động server:
```bash
cd backend
npm start
```

### Test đăng ký:
1. Mở: `frontend/test-register.html`
2. Điền thông tin
3. Click "Đăng ký"
4. Kiểm tra email → Nhận mã 6 số
5. Nhập mã → Hoàn tất!

---

## ❌ NẾU GẶP LỖI

### Lỗi: "Invalid login"
→ App Password sai hoặc email sai
→ Làm lại Bước 1 và 2

### Không nhận được email
→ Kiểm tra thư mục Spam
→ Chạy lại: `node scripts/test-email.js`

### Không thấy "App passwords"
→ Chưa bật 2-Step Verification
→ Bật tại: https://myaccount.google.com/security

---

## 📖 HƯỚNG DẪN CHI TIẾT

Xem file: `HUONG_DAN_EMAIL.md`

---

## 🎯 TÓM TẮT

```
1. Tạo App Password    → Copy mã 16 ký tự
2. Cập nhật .env       → Paste email + mã
3. Test                → Chạy script test
4. Hoàn tất!           → Bắt đầu sử dụng
```

**Thời gian:** 5 phút
**Độ khó:** ⭐⭐☆☆☆ (Dễ)

---

## 💡 MẸO

- Lưu App Password vào Notepad tạm thời
- Có thể tạo nhiều App Password cho nhiều ứng dụng
- Có thể thu hồi App Password bất cứ lúc nào
- Không ảnh hưởng đến tài khoản Gmail chính

---

**Chúc bạn thành công! 🎉**
