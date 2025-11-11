# 🔐 Session-Based Authentication cho Admin

## ✅ Đã Cài Đặt

### Thay Đổi Từ JWT sang Session

**Trước (JWT):**
- Token lưu trong localStorage
- Tồn tại 7 ngày
- Không tự động hết hạn khi đóng browser

**Sau (Session):**
- Session lưu trên server
- Cookie httpOnly (JavaScript không truy cập được)
- Tự động hết hạn sau 8 giờ
- Xóa hoàn toàn khi đăng xuất

## 🔧 Cách Hoạt Động

### 1. Đăng Nhập
```
User click "Đăng nhập với Google"
  ↓
Google OAuth (prompt: select_account)
  ↓
Backend kiểm tra email trong database
  ↓
Tạo session trên server
  ↓
Gửi cookie về browser (httpOnly)
  ↓
Redirect về admin panel
```

### 2. Truy Cập Trang Admin
```
User truy cập /admin/index1.html
  ↓
check-auth.js tự động chạy
  ↓
Gửi request với cookie session
  ↓
Backend kiểm tra session
  ↓
Nếu hợp lệ: Cho phép truy cập
Nếu không: Redirect về login
```

### 3. Đăng Xuất
```
User click "Đăng xuất"
  ↓
Gửi request logout
  ↓
Backend xóa session
  ↓
Xóa cookie
  ↓
Redirect về login
```

## 🔒 Bảo Mật

### 1. Cookie httpOnly
```javascript
cookie: { 
    httpOnly: true, // JavaScript không đọc được
    secure: true,   // Chỉ gửi qua HTTPS (production)
    maxAge: 8 * 60 * 60 * 1000 // 8 giờ
}
```

### 2. Không Lưu Token
- ❌ Không có localStorage.setItem('admin_token')
- ❌ Không có token trong URL
- ✅ Chỉ có session cookie (httpOnly)

### 3. Prompt Select Account
```javascript
prompt: 'select_account' // Luôn hỏi chọn tài khoản
```

### 4. Access Type Online
```javascript
accessType: 'online' // Không lưu refresh token
```

## 📋 API Endpoints

### Check Session
```http
GET /api/admin/auth/check-session
Credentials: include

Response:
{
  "success": true,
  "isAuthenticated": true,
  "data": {
    "ma_admin": 6,
    "email": "admin@example.com",
    "quyen": "superadmin"
  }
}
```

### Logout
```http
POST /api/admin/auth/logout
Credentials: include

Response:
{
  "success": true,
  "message": "Đăng xuất thành công"
}
```

## 🎯 Quy Trình Sử Dụng

### Đăng Nhập
1. Truy cập: http://localhost:3000/admin/dang-nhap-admin.html
2. Click "Đăng nhập với Google"
3. **Chọn tài khoản** (bắt buộc mỗi lần)
4. Cho phép quyền
5. Tự động chuyển về admin panel

### Làm Việc
- Session tồn tại 8 giờ
- Tự động kiểm tra mỗi khi load trang
- Nếu hết hạn → Redirect về login

### Đăng Xuất
1. Click nút "Đăng xuất"
2. Xác nhận
3. Session bị xóa hoàn toàn
4. Chuyển về trang đăng nhập

### Đăng Nhập Lại
- Phải chọn tài khoản lại
- Không tự động đăng nhập
- Session mới được tạo

## 📁 Files Quan Trọng

### Backend
- `backend/server.js` - Cấu hình session
- `backend/routes/admin-auth.js` - Routes xác thực
- `backend/config/passport.js` - Google OAuth config

### Frontend
- `frontend/admin/dang-nhap-admin.html` - Trang đăng nhập
- `frontend/admin/check-auth.js` - Kiểm tra session
- `frontend/admin/index1.html` - Trang admin (cần thêm script)

## 🔧 Cài Đặt

### 1. Thêm Script vào Trang Admin

Trong `frontend/admin/index1.html`, thêm trước `</body>`:

```html
<script src="check-auth.js"></script>
<script>
    // Kiểm tra xác thực khi load trang
    checkAdminAuth().then(admin => {
        if (admin) {
            console.log('Admin:', admin);
            // Hiển thị thông tin admin
        }
    });
</script>
```

### 2. Thêm Nút Đăng Xuất

```html
<button onclick="logoutAdmin()" class="btn-logout">
    <i class="fas fa-sign-out-alt"></i> Đăng xuất
</button>
```

### 3. Restart Server

```bash
# Stop server
# Start lại
npm start
```

## ⚠️ Lưu Ý

### Session vs Token

| Tính năng | Session | JWT Token |
|-----------|---------|-----------|
| Lưu trữ | Server | Client (localStorage) |
| Bảo mật | Cao hơn | Thấp hơn |
| Tự động hết hạn | Có | Không |
| XSS Attack | An toàn | Dễ bị tấn công |
| Đăng xuất | Xóa ngay | Vẫn còn đến khi expire |

### Credentials: include

Quan trọng! Phải thêm vào mọi request:

```javascript
fetch(url, {
    credentials: 'include' // Gửi cookie session
})
```

### CORS

Backend phải cho phép credentials:

```javascript
cors({
    origin: 'http://localhost:3000',
    credentials: true
})
```

## 🧪 Test

### Test 1: Đăng Nhập
1. Truy cập trang đăng nhập
2. Click "Đăng nhập với Google"
3. Chọn tài khoản
4. **Kết quả:** Vào được admin panel

### Test 2: Truy Cập Trực Tiếp
1. Đóng browser
2. Mở lại
3. Truy cập: http://localhost:3000/admin/index1.html
4. **Kết quả:** Redirect về login (session đã mất)

### Test 3: Đăng Xuất
1. Đăng nhập thành công
2. Click "Đăng xuất"
3. Thử truy cập lại admin panel
4. **Kết quả:** Phải đăng nhập lại

### Test 4: Chọn Tài Khoản
1. Đăng nhập lần 1
2. Đăng xuất
3. Đăng nhập lần 2
4. **Kết quả:** Phải chọn tài khoản lại

## 🎉 Kết Luận

Session-based authentication an toàn hơn JWT cho admin vì:
- ✅ Không lưu token trên client
- ✅ Cookie httpOnly (không bị XSS)
- ✅ Tự động hết hạn
- ✅ Đăng xuất thực sự (xóa session ngay)
- ✅ Luôn yêu cầu chọn tài khoản

**Đã hoàn tất cài đặt!** 🔐
