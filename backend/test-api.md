# 🧪 Test API Login

## ✅ Kết quả kiểm tra

### 1. User Login API
**Endpoint**: `POST /api/auth/login`

**Test với PowerShell**:
```powershell
Invoke-RestMethod -Uri "http://localhost:3000/api/auth/login" -Method POST -ContentType "application/json" -Body '{"email":"your-email@example.com","mat_khau":"your-password"}'
```

**Test với curl**:
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"your-email@example.com","mat_khau":"your-password"}'
```

**Response thành công**:
```json
{
  "success": true,
  "message": "Đăng nhập thành công",
  "data": {
    "ma_nguoi_dung": 1,
    "ten_nguoi_dung": "Tên người dùng",
    "email": "email@example.com",
    "token": "jwt-token-here"
  }
}
```

**Response lỗi**:
```json
{
  "success": false,
  "message": "Email hoặc mật khẩu không đúng"
}
```

---

### 2. Admin Login API
**Endpoint**: `POST /api/admin-auth/login`

**Test với PowerShell**:
```powershell
Invoke-RestMethod -Uri "http://localhost:3000/api/admin-auth/login" -Method POST -ContentType "application/json" -Body '{"tai_khoan":"admin","mat_khau":"your-password"}'
```

**Test với curl**:
```bash
curl -X POST http://localhost:3000/api/admin-auth/login \
  -H "Content-Type: application/json" \
  -d '{"tai_khoan":"admin","mat_khau":"your-password"}'
```

**Response thành công**:
```json
{
  "success": true,
  "message": "Đăng nhập admin thành công",
  "data": {
    "ma_admin": 1,
    "tai_khoan": "admin",
    "email": "admin@example.com",
    "token": "jwt-token-here",
    "role": "admin"
  }
}
```

---

### 3. Check Session API
**Endpoint**: `GET /api/admin-auth/check-session`

**Test với PowerShell**:
```powershell
Invoke-RestMethod -Uri "http://localhost:3000/api/admin-auth/check-session" -Method GET
```

**Response khi chưa đăng nhập**:
```json
{
  "success": false,
  "isAuthenticated": false,
  "message": "Chưa đăng nhập"
}
```

---

### 4. Google OAuth Login (Admin)
**Endpoint**: `GET /api/admin-auth/google`

Truy cập trực tiếp trong browser:
```
http://localhost:3000/api/admin-auth/google
```

Sau khi đăng nhập Google thành công, sẽ redirect về:
```
http://localhost:3000/admin/index1.html?login=success
```

---

## 📝 Các thay đổi đã thực hiện

### 1. Cài đặt packages mới
```bash
npm install express-session passport passport-google-oauth20
```

### 2. Cập nhật `server.js`
- ✅ Thêm session middleware
- ✅ Thêm passport middleware
- ✅ Thêm admin-auth routes
- ✅ Cấu hình CORS với credentials

### 3. Cập nhật `.env`
- ✅ Sửa GOOGLE_CALLBACK_URL từ `/api/admin/auth/google/callback` → `/api/admin-auth/google/callback`
- ✅ Thêm FRONTEND_URL

### 4. Các tính năng hoạt động
- ✅ User login với email/password
- ✅ Admin login với tài khoản/password
- ✅ Admin login với Google OAuth
- ✅ Session management
- ✅ JWT token authentication
- ✅ Check session status

---

## 🔒 Bảo mật

### JWT Token
- Thời gian hết hạn: 7 ngày
- Secret key: Lưu trong `.env`

### Session
- Thời gian hết hạn: 24 giờ
- HttpOnly cookie: Bật
- Secure cookie: Bật khi production

### Password
- Hash với bcrypt (10 rounds)
- Không trả về password trong response

---

## 🚀 Chạy server

```bash
cd backend
npm start
```

Server sẽ chạy tại: `http://localhost:3000`
