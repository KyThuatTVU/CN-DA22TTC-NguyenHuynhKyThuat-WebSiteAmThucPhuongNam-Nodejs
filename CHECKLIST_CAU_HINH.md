# ✅ CHECKLIST CẤU HÌNH EMAIL - TỪNG BƯỚC

## 📋 Bạn cần làm theo thứ tự:

### ☑️ Bước 1: Đã bật 2-Step Verification
```
✅ BẠN ĐÃ HOÀN THÀNH BƯỚC NÀY!
(Tôi thấy trong ảnh bạn gửi)
```

---

### ⬜ Bước 2: Tạo App Password

**Link:** https://myaccount.google.com/apppasswords

**Làm gì:**
1. Click link trên
2. Chọn **Mail** → **Other** → Nhập tên `NhaHang`
3. Click **Generate**
4. **COPY MÃ 16 KÝ TỰ** (dạng: abcd efgh ijkl mnop)

**Lưu mã vào đây tạm thời:**
```
Mã của bạn: ____________________
```

---

### ⬜ Bước 3: Cập nhật file .env

**Mở file:** `backend/.env`

**Tìm 2 dòng:**
```env
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password-here
```

**Sửa thành:**
```env
EMAIL_USER=email-cua-ban@gmail.com
EMAIL_PASSWORD=paste-ma-vua-copy
```

**Ví dụ:**
```env
EMAIL_USER=phuongnam.restaurant@gmail.com
EMAIL_PASSWORD=abcd efgh ijkl mnop
```

**Lưu file:** Ctrl + S

---

### ⬜ Bước 4: Test email

**Mở Terminal và chạy:**
```bash
cd backend
node scripts/test-email.js
```

**Kết quả mong đợi:**
```
✅ KẾT NỐI EMAIL THÀNH CÔNG!
✅ GỬI EMAIL TEST THÀNH CÔNG!
🎉 HỆ THỐNG EMAIL ĐÃ SẴN SÀNG!
```

**Nếu lỗi:**
- Kiểm tra lại email có đúng không
- Kiểm tra lại App Password có đúng không
- Làm lại từ Bước 2

---

### ⬜ Bước 5: Khởi động server

```bash
cd backend
npm start
```

**Đợi đến khi thấy:**
```
✅ Kết nối database thành công!
✅ Email server sẵn sàng gửi mail
🚀 Server đang chạy tại http://localhost:3000
```

---

### ⬜ Bước 6: Test đăng ký

**Mở file:** `frontend/test-register.html`

**Hoặc:** `frontend/dang-ky.html`

**Làm gì:**
1. Điền họ tên
2. Điền email (email thật của bạn để test)
3. Điền mật khẩu
4. Click "Đăng ký"

**Kết quả:**
- Thấy thông báo: "Mã xác thực đã được gửi đến email của bạn!"
- Kiểm tra email → Nhận mã 6 số
- Nhập mã → Hoàn tất!

---

## 🎯 TÓM TẮT

```
1. ✅ Bật 2FA (Đã xong)
2. ⬜ Tạo App Password
3. ⬜ Cập nhật .env
4. ⬜ Test email
5. ⬜ Khởi động server
6. ⬜ Test đăng ký
```

---

## ❓ CÂU HỎI THƯỜNG GẶP

### Q: Tôi không thấy "App passwords"?
**A:** Đăng xuất và đăng nhập lại Gmail

### Q: Mã App Password là gì?
**A:** Mã 16 ký tự có dấu cách, ví dụ: `abcd efgh ijkl mnop`

### Q: Tôi có thể dùng mật khẩu Gmail thường không?
**A:** KHÔNG! Phải dùng App Password

### Q: App Password có an toàn không?
**A:** CÓ! Chỉ dùng cho ứng dụng này, có thể thu hồi bất cứ lúc nào

---

## 📞 NẾU GẶP VẤN ĐỀ

**Chạy lệnh này để kiểm tra:**
```bash
cd backend
node scripts/test-email.js
```

**Xem log lỗi và báo cho tôi biết!**

---

**Bắt đầu từ Bước 2 nhé! 🚀**
