# 📡 API Endpoints - Ẩm Thực Phương Nam

## 🔐 Authentication APIs

### User Authentication
Base URL: `/api/auth`

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/send-verification` | Gửi mã xác thực email |
| POST | `/api/auth/verify-email` | Xác thực email và tạo tài khoản |
| POST | `/api/auth/resend-verification` | Gửi lại mã xác thực |
| POST | `/api/auth/login` | Đăng nhập user |
| GET | `/api/auth/me` | Lấy thông tin user hiện tại |
| PUT | `/api/auth/update` | Cập nhật thông tin user |
| POST | `/api/auth/change-password` | Đổi mật khẩu user |
| POST | `/api/auth/upload-avatar` | Upload ảnh đại diện |

### Admin Authentication
Base URL: `/api/admin-auth`

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/admin-auth/login` | Đăng nhập admin (username/password) |
| GET | `/api/admin-auth/google` | Đăng nhập admin với Google OAuth |
| GET | `/api/admin-auth/google/callback` | Callback từ Google OAuth |
| GET | `/api/admin-auth/check-session` | Kiểm tra session admin |
| POST | `/api/admin-auth/logout` | Đăng xuất admin |
| GET | `/api/admin-auth/me` | Lấy thông tin admin hiện tại |
| POST | `/api/admin-auth/change-password` | Đổi mật khẩu admin |

---

## 🍽️ Menu APIs
Base URL: `/api/menu`

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/menu` | Lấy danh sách món ăn |
| GET | `/api/menu/:id` | Lấy chi tiết món ăn |
| POST | `/api/menu` | Thêm món ăn mới (Admin) |
| PUT | `/api/menu/:id` | Cập nhật món ăn (Admin) |
| DELETE | `/api/menu/:id` | Xóa món ăn (Admin) |

---

## 📂 Category APIs
Base URL: `/api/categories`

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/categories` | Lấy danh sách danh mục |
| GET | `/api/categories/:id` | Lấy chi tiết danh mục |
| POST | `/api/categories` | Thêm danh mục mới (Admin) |
| PUT | `/api/categories/:id` | Cập nhật danh mục (Admin) |
| DELETE | `/api/categories/:id` | Xóa danh mục (Admin) |

---

## 🖼️ Album APIs
Base URL: `/api/albums`

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/albums` | Lấy danh sách album |
| GET | `/api/albums/:id` | Lấy chi tiết album |
| POST | `/api/albums` | Thêm album mới (Admin) |
| PUT | `/api/albums/:id` | Cập nhật album (Admin) |
| DELETE | `/api/albums/:id` | Xóa album (Admin) |

---

## 🛒 Cart APIs
Base URL: `/api/cart`

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/cart` | Lấy giỏ hàng của user |
| POST | `/api/cart/add` | Thêm món vào giỏ |
| PUT | `/api/cart/update` | Cập nhật số lượng |
| DELETE | `/api/cart/remove/:id` | Xóa món khỏi giỏ |
| DELETE | `/api/cart/clear` | Xóa toàn bộ giỏ hàng |

---

## 🔧 System APIs

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | API info |
| GET | `/api/test-db` | Test database connection |

---

## 📝 Notes

### Authentication Headers
```javascript
// JWT Token (User & Admin)
headers: {
  'Authorization': 'Bearer <token>',
  'Content-Type': 'application/json'
}

// Session (Admin Google OAuth)
credentials: 'include'
```

### Response Format
```javascript
// Success
{
  "success": true,
  "message": "Success message",
  "data": { ... }
}

// Error
{
  "success": false,
  "message": "Error message",
  "error": "Error details"
}
```

### Status Codes
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error

---

## 🔄 Recent Changes

### ✅ Updated (2025)
- Changed admin auth routes from `/api/admin/auth/*` to `/api/admin-auth/*`
- Updated all frontend files to use new endpoints
- Fixed Google OAuth callback URL
- Added session-based authentication for admin

### 📁 Files Updated
- `backend/server.js` - Added admin-auth routes
- `frontend/admin/dang-nhap-admin.html` - Updated Google OAuth URL
- `frontend/components/admin-login-modal.html` - Updated all admin auth URLs
- `frontend/admin/check-auth.js` - Updated check-session and logout URLs
- `backend/.env` - Updated GOOGLE_CALLBACK_URL
- `SESSION_BASED_AUTH.md` - Updated documentation
