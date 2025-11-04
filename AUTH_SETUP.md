# Hệ thống Đăng ký & Đăng nhập

## ✅ Đã hoàn thành:

### Backend API:
- **POST /api/auth/upload-avatar** - Upload ảnh đại diện
- **POST /api/auth/register** - Đăng ký tài khoản mới
- **POST /api/auth/login** - Đăng nhập
- **GET /api/auth/me** - Lấy thông tin người dùng hiện tại (cần token)
- **PUT /api/auth/update** - Cập nhật thông tin người dùng (cần token)
- **POST /api/auth/change-password** - Đổi mật khẩu (cần token)

### Frontend:
- **dang-ky.html** - Trang đăng ký với form đầy đủ
- **dang-nhap.html** - Trang đăng nhập
- **js/auth.js** - Xử lý authentication logic

### Cấu trúc bảng `nguoi_dung`:
```
- ma_nguoi_dung (int, PK, auto_increment)
- ten_nguoi_dung (varchar(150), required)
- email (varchar(255), unique, required)
- so_dien_thoai (varchar(20), nullable)
- mat_khau_hash (varchar(255), required)
- dia_chi (varchar(300), nullable)
- gioi_tinh (enum: 'khac', 'nam', 'nu', default: 'khac')
- anh_dai_dien (varchar(500), nullable)
- ngay_tao (datetime, default: CURRENT_TIMESTAMP)
- trang_thai (tinyint, default: 1)
```

## 🚀 Cách sử dụng:

### 1. Khởi động Backend:
```bash
cd backend
npm start
```

### 2. Test API với Postman hoặc curl:

**Đăng ký:**
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "ten_nguoi_dung": "Nguyễn Văn A",
    "email": "test@example.com",
    "so_dien_thoai": "0123456789",
    "mat_khau": "123456",
    "dia_chi": "123 ABC, Q1, TP.HCM",
    "gioi_tinh": "nam"
  }'
```

**Đăng nhập:**
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "mat_khau": "123456"
  }'
```

**Lấy thông tin người dùng:**
```bash
curl http://localhost:3000/api/auth/me \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 3. Mở Frontend:
- Đăng ký: `frontend/dang-ky.html`
- Đăng nhập: `frontend/dang-nhap.html`

## 📋 Tính năng:

### Đăng ký:
- ✅ Upload ảnh đại diện (tùy chọn, max 5MB)
- ✅ Preview ảnh trước khi upload
- ✅ Validate email unique
- ✅ Validate số điện thoại unique
- ✅ Hash mật khẩu với bcrypt
- ✅ Tự động tạo JWT token sau khi đăng ký
- ✅ Lưu thông tin vào localStorage
- ✅ Redirect về trang chủ

### Đăng nhập:
- ✅ Validate email và mật khẩu
- ✅ Kiểm tra trạng thái tài khoản
- ✅ Tạo JWT token (expires: 7 days)
- ✅ Lưu token và user info vào localStorage
- ✅ Toggle hiển thị mật khẩu
- ✅ Remember me checkbox
- ✅ Notification thành công/thất bại

### Bảo mật:
- ✅ Mật khẩu được hash với bcrypt (salt rounds: 10)
- ✅ JWT token authentication
- ✅ Token expiration (7 ngày)
- ✅ Middleware xác thực cho protected routes
- ✅ Không trả về mật khẩu trong response

## 🔧 Cấu hình:

### Environment Variables (.env):
```
JWT_SECRET=amthuc_phuongnam_secret_key_2025_very_secure
```

### API URL (frontend/js/auth.js):
```javascript
const API_URL = 'http://localhost:3000/api';
```

## 📝 Dữ liệu mẫu:

Có 3 tài khoản test sẵn trong database:
1. Email: `mai.nguyen@gmail.com` - Password: `123456`
2. Email: `hung.tran@gmail.com` - Password: `123456`
3. Email: `hoa.le@gmail.com` - Password: `123456`

## 🎨 UI/UX Features:

- Responsive design (mobile-friendly)
- Loading states khi submit form
- Toast notifications
- Form validation
- Password strength indicator
- Social login buttons (UI only)
- Smooth animations với GSAP

## 🔄 Luồng hoạt động:

1. User điền form đăng ký/đăng nhập
2. Frontend validate dữ liệu
3. Gửi request đến API
4. Backend validate và xử lý
5. Trả về token + user info
6. Frontend lưu vào localStorage
7. Redirect về trang chủ
8. Navbar hiển thị thông tin user

## 🛠️ Các API endpoint khác:

- **PUT /api/auth/update** - Cập nhật thông tin cá nhân
- **POST /api/auth/change-password** - Đổi mật khẩu
- **GET /api/auth/me** - Lấy thông tin user hiện tại

## 📱 Tích hợp với các trang khác:

Thêm vào các trang cần authentication:
```html
<script src="js/auth.js"></script>
<script>
  // Check if user is logged in
  if (!isLoggedIn()) {
    window.location.href = 'dang-nhap.html';
  }
  
  // Get current user
  const user = getUserData();
  console.log(user);
</script>
```

## 🎯 Next Steps:

- [ ] Quên mật khẩu (reset password)
- [ ] Xác thực email
- [ ] Social login (Google, Facebook)
- [ ] Two-factor authentication
- [ ] Upload avatar
- [ ] Trang quản lý tài khoản


## 📸 Upload Avatar:

### API Endpoint:
```bash
POST /api/auth/upload-avatar
Content-Type: multipart/form-data

# Body:
avatar: [file]
```

### Response:
```json
{
  "success": true,
  "message": "Upload ảnh thành công",
  "data": {
    "anh_dai_dien": "/images/avatars/avatar-1234567890-123456789.jpg"
  }
}
```

### Validation:
- ✅ Chỉ chấp nhận file ảnh (image/*)
- ✅ Kích thước tối đa: 5MB
- ✅ Tự động tạo tên file unique
- ✅ Lưu vào thư mục `backend/images/avatars/`

### Frontend Features:
- ✅ Preview ảnh real-time
- ✅ Drag & drop hoặc click để chọn
- ✅ Validate file size và type
- ✅ Upload tự động khi chọn file
- ✅ Hiển thị avatar trong navbar
- ✅ Hover effects đẹp mắt

### Cách sử dụng:
1. User chọn ảnh từ form đăng ký
2. Ảnh được preview ngay lập tức
3. Upload tự động lên server
4. Server trả về đường dẫn ảnh
5. Đường dẫn được lưu cùng thông tin đăng ký
6. Avatar hiển thị trong navbar sau khi đăng nhập
