# 🔐 Bảo Mật Google OAuth cho Admin

## ✅ Đã Cài Đặt

### Tính Năng: Bắt Buộc Chọn Tài Khoản

Mỗi lần admin đăng nhập bằng Google OAuth, hệ thống sẽ:
- ❌ **KHÔNG** tự động đăng nhập bằng tài khoản đã lưu
- ✅ **BẮT BUỘC** chọn tài khoản Google
- ✅ Hiển thị màn hình chọn tài khoản của Google
- ✅ Admin phải xác nhận tài khoản muốn sử dụng

## 🔧 Cách Hoạt Động

### Backend (admin-auth.js)
```javascript
router.get('/google',
    passport.authenticate('google', { 
        scope: ['profile', 'email'],
        session: false,
        prompt: 'select_account' // ← Tham số này bắt buộc chọn tài khoản
    })
);
```

### Tham Số `prompt`

- `prompt: 'select_account'` - Luôn hiện màn hình chọn tài khoản
- `prompt: 'consent'` - Luôn hỏi quyền truy cập
- `prompt: 'none'` - Tự động đăng nhập (không an toàn)

## 🎯 Lợi Ích

### 1. Bảo Mật Cao Hơn
- Tránh đăng nhập nhầm tài khoản
- Không tự động dùng tài khoản đã lưu
- Admin phải xác nhận mỗi lần đăng nhập

### 2. Đa Tài Khoản
- Dễ dàng chuyển đổi giữa các tài khoản admin
- Không bị "kẹt" với 1 tài khoản

### 3. Audit Trail
- Rõ ràng ai đang đăng nhập
- Tránh nhầm lẫn trong môi trường nhiều admin

## 📋 Quy Trình Đăng Nhập

### Bước 1: Click "Đăng nhập với Google"
```
http://localhost:3000/admin/dang-nhap-admin.html
```

### Bước 2: Chọn Tài Khoản
Google sẽ hiển thị:
- Danh sách tài khoản đã đăng nhập
- Tùy chọn "Use another account"
- Không tự động chọn tài khoản nào

### Bước 3: Xác Nhận
- Admin chọn tài khoản muốn dùng
- Google kiểm tra quyền
- Redirect về hệ thống

### Bước 4: Kiểm Tra Email
Backend kiểm tra:
```javascript
// Chỉ cho phép email có trong bảng admin
const [admins] = await db.query(
    'SELECT * FROM admin WHERE email = ?',
    [email]
);

if (admins.length === 0) {
    // Từ chối đăng nhập
    return res.redirect('/admin/dang-nhap-admin.html?error=not_admin');
}
```

## 🔒 Các Tùy Chọn Bảo Mật Khác

### 1. Thêm Consent Screen
```javascript
prompt: 'consent select_account'
```
Vừa chọn tài khoản, vừa hỏi quyền mỗi lần.

### 2. Thêm Access Type
```javascript
accessType: 'offline'
```
Lấy refresh token để duy trì session.

### 3. Thêm Login Hint
```javascript
loginHint: 'admin@example.com'
```
Gợi ý tài khoản nên dùng.

## 🧪 Test

### Test 1: Đăng Nhập Lần Đầu
1. Truy cập: http://localhost:3000/admin/dang-nhap-admin.html
2. Click "Đăng nhập với Google"
3. **Kết quả:** Hiện màn hình chọn tài khoản

### Test 2: Đăng Nhập Lần 2
1. Đăng xuất
2. Đăng nhập lại bằng Google
3. **Kết quả:** Vẫn hiện màn hình chọn tài khoản (không tự động)

### Test 3: Nhiều Tài Khoản
1. Đăng nhập Google với tài khoản A
2. Đăng xuất
3. Đăng nhập lại
4. **Kết quả:** Có thể chọn tài khoản B

## 📝 Lưu Ý

### Session vs Token
- **Session:** Lưu trên server, tự động expire
- **Token (JWT):** Lưu trên client, cần xóa thủ công

Hệ thống đang dùng:
```javascript
session: false  // Không dùng session
```

Token được lưu trong:
```javascript
localStorage.setItem('admin_token', token);
```

### Đăng Xuất
Để đăng xuất hoàn toàn:
```javascript
// Xóa token
localStorage.removeItem('admin_token');
localStorage.removeItem('admin_info');

// Redirect về login
window.location.href = '/admin/dang-nhap-admin.html';
```

## 🎉 Kết Luận

Với `prompt: 'select_account'`, mỗi lần admin đăng nhập bằng Google sẽ:
- ✅ Phải chọn tài khoản
- ✅ Không tự động đăng nhập
- ✅ An toàn hơn
- ✅ Rõ ràng hơn

**Đã hoàn tất cài đặt!** 🔐
