# Hướng Dẫn Cấu Hình Google OAuth

## Bước 1: Tạo Google Cloud Project

1. Truy cập [Google Cloud Console](https://console.cloud.google.com/)
2. Tạo project mới hoặc chọn project hiện có
3. Đặt tên project: "Amthuc Phuong Nam"

## Bước 2: Kích Hoạt Google+ API

1. Vào menu **APIs & Services** > **Library**
2. Tìm kiếm "Google+ API"
3. Click **Enable**

## Bước 3: Tạo OAuth 2.0 Credentials

1. Vào **APIs & Services** > **Credentials**
2. Click **Create Credentials** > **OAuth client ID**
3. Chọn **Application type**: Web application
4. Đặt tên: "Phuong Nam Restaurant Web"

### Cấu hình Authorized JavaScript origins:
```
http://localhost:3000
http://localhost:5500
```

### Cấu hình Authorized redirect URIs:
```
http://localhost:3000/api/auth/google/callback
```

5. Click **Create**
6. Sao chép **Client ID** và **Client Secret**

## Bước 4: Cập Nhật File .env

Mở file `backend/.env` và cập nhật:

```env
# Google OAuth
GOOGLE_CLIENT_ID=your_actual_client_id_here
GOOGLE_CLIENT_SECRET=your_actual_client_secret_here
GOOGLE_CALLBACK_URL=http://localhost:3000/api/auth/google/callback
```

## Bước 5: Cấu Hình OAuth Consent Screen

1. Vào **APIs & Services** > **OAuth consent screen**
2. Chọn **External** (cho testing)
3. Điền thông tin:
   - App name: Nhà hàng Phương Nam
   - User support email: your-email@gmail.com
   - Developer contact: your-email@gmail.com
4. Thêm scopes:
   - `.../auth/userinfo.email`
   - `.../auth/userinfo.profile`
5. Thêm test users (email của bạn để test)

## Bước 6: Test

1. Khởi động server: `npm start`
2. Truy cập: http://localhost:3000/dang-nhap.html
3. Click nút "Đăng nhập với Google"
4. Chọn tài khoản Google
5. Cho phép quyền truy cập
6. Sẽ được redirect về trang chủ với đăng nhập thành công

## Lưu Ý

- Trong môi trường development, bạn cần thêm email test vào OAuth consent screen
- Khi deploy production, cần cập nhật:
  - Authorized JavaScript origins
  - Authorized redirect URIs
  - GOOGLE_CALLBACK_URL trong .env
  - Chuyển OAuth consent screen sang Published

## Troubleshooting

### Lỗi "redirect_uri_mismatch"
- Kiểm tra lại redirect URI trong Google Console
- Đảm bảo URL khớp chính xác (có/không có trailing slash)

### Lỗi "access_denied"
- Kiểm tra OAuth consent screen đã được cấu hình
- Thêm email test user

### Lỗi "invalid_client"
- Kiểm tra GOOGLE_CLIENT_ID và GOOGLE_CLIENT_SECRET trong .env
- Đảm bảo không có khoảng trắng thừa
