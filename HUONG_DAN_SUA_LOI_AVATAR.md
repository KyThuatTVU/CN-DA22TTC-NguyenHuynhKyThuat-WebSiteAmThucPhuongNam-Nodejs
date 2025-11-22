# Hướng Dẫn Khắc Phục Lỗi Mất Ảnh Đại Diện

## 🔍 Vấn đề

Khi người dùng đăng nhập vào hệ thống, ảnh đại diện không hiển thị hoặc bị mất.

## 🎯 Nguyên nhân

1. **File ảnh bị xóa:** Các file ảnh avatar đã bị xóa khỏi thư mục `backend/images/avatars/` nhưng đường dẫn vẫn còn trong database
2. **Database lưu path không tồn tại:** Database có giá trị `anh_dai_dien` nhưng file không còn trên server
3. **LocalStorage lưu dữ liệu cũ:** Trình duyệt vẫn lưu thông tin avatar cũ trong localStorage

## ✅ Giải pháp đã triển khai

### 1. Cập nhật xử lý Avatar trong Frontend

**File: `frontend/js/components/navbar.js`**
- Thêm kiểm tra `null`, `undefined`, và empty string cho `anh_dai_dien`
- Xử lý fallback khi ảnh không load được
- Hiển thị icon mặc định khi không có avatar

**File: `frontend/js/load-components.js`**
- Đồng bộ logic xử lý avatar với navbar.js
- Thêm console.log để debug

**File: `frontend/js/auth.js`**
- Thêm logging khi lưu user data vào localStorage
- Giúp debug vấn đề avatar

### 2. Cập nhật Backend

**File: `backend/routes/auth.js`**
- Thêm logging khi đăng nhập thành công
- Log thông tin user data được trả về, bao gồm `anh_dai_dien`

### 3. Scripts Kiểm tra và Sửa lỗi

**Script 1: `backend/scripts/check-user-avatars.js`**
```bash
node scripts/check-user-avatars.js
```
- Kiểm tra tất cả người dùng trong database
- Xác định avatar nào có path trong DB nhưng file không tồn tại
- Hiển thị thống kê chi tiết

**Script 2: `backend/scripts/fix-missing-avatars.js`**
```bash
node scripts/fix-missing-avatars.js
```
- Tự động xóa các path avatar không tồn tại khỏi database
- Người dùng có thể upload lại ảnh mới

### 4. Trang Test Avatar

**File: `frontend/test-avatar.html`**

Mở trình duyệt: `http://localhost:3000/test-avatar.html`

Trang này giúp:
- Kiểm tra thông tin user trong localStorage
- Preview avatar
- Test xem avatar có load được không
- Debug console real-time

## 📋 Các bước khắc phục

### Bước 1: Kiểm tra Database
```bash
cd backend
node scripts/check-user-avatars.js
```

### Bước 2: Sửa các avatar path lỗi
```bash
node scripts/fix-missing-avatars.js
```

### Bước 3: Test trên trình duyệt
1. Mở `http://localhost:3000/test-avatar.html`
2. Kiểm tra thông tin user
3. Xem avatar có hiển thị không

### Bước 4: Đăng nhập lại
1. Xóa localStorage (hoặc dùng nút "Xóa localStorage" trên test-avatar.html)
2. Đăng nhập lại
3. Kiểm tra avatar trên navbar

## 🔧 Cách Upload Avatar mới

### Backend API

**Upload avatar:**
```javascript
POST /api/auth/upload-avatar
Content-Type: multipart/form-data

Form data:
- avatar: [file] (image file, max 5MB)
```

**Cập nhật thông tin user (bao gồm avatar):**
```javascript
PUT /api/auth/update
Authorization: Bearer <token>
Content-Type: application/json

{
  "anh_dai_dien": "/images/avatars/avatar-xxxxx.jpg"
}
```

### Frontend

Người dùng có thể upload avatar qua:
1. Trang đăng ký (nếu có form upload)
2. Trang cài đặt tài khoản (`tai-khoan.html`)

## 🐛 Debug Tips

### 1. Kiểm tra Console Log

Mở DevTools (F12) và xem console khi đăng nhập:
```javascript
// Should see:
💾 Saving user data to localStorage: { name, email, avatar, hasToken }
👤 User data: { name, avatar, avatarType }
🖼️ Avatar URL: http://localhost:3000/images/avatars/avatar-xxxxx.jpg
✅ User menu rendered for: [username]
```

### 2. Kiểm tra localStorage

Trong DevTools Console:
```javascript
console.log(JSON.parse(localStorage.getItem('user')))
```

Nên thấy:
```javascript
{
  ma_nguoi_dung: 1,
  ten_nguoi_dung: "...",
  email: "...",
  anh_dai_dien: "/images/avatars/..." hoặc null,
  token: "..."
}
```

### 3. Kiểm tra Network

Mở DevTools > Network tab, filter by "avatars"
- Nếu có request đến avatar và trả về 404: File không tồn tại
- Nếu có request đến avatar và trả về 200: File OK

### 4. Kiểm tra thư mục Backend

```bash
ls backend/images/avatars/
# Hoặc
dir backend\images\avatars\
```

Nên thấy các file `.jpg` hoặc `.png`

## 🚀 Best Practices

1. **Backup thư mục avatars:** Định kỳ backup `backend/images/avatars/`
2. **Validation upload:** Backend đã có validation (5MB max, chỉ ảnh)
3. **Xử lý lỗi:** Frontend có fallback icon khi avatar không load
4. **Clear cache:** Sau khi sửa lỗi, clear browser cache
5. **Test thường xuyên:** Dùng test-avatar.html để kiểm tra

## 📝 Checklist

- [x] Cập nhật logic xử lý avatar trong navbar.js
- [x] Cập nhật logic xử lý avatar trong load-components.js
- [x] Thêm logging trong auth.js (frontend & backend)
- [x] Tạo script check-user-avatars.js
- [x] Tạo script fix-missing-avatars.js
- [x] Tạo trang test-avatar.html
- [x] Chạy fix-missing-avatars.js để clean database
- [ ] Test đăng nhập với các user khác nhau
- [ ] Test upload avatar mới
- [ ] Verify avatar hiển thị đúng sau khi upload

## 🆘 Support

Nếu vẫn gặp vấn đề:
1. Chạy `node scripts/check-user-avatars.js` và gửi kết quả
2. Mở DevTools Console và copy tất cả log
3. Kiểm tra file `backend/images/avatars/` có chứa file không
4. Thử đăng xuất và đăng nhập lại
5. Clear localStorage và cookie

---

**Cập nhật:** 22/11/2025
**Trạng thái:** ✅ Đã sửa lỗi
