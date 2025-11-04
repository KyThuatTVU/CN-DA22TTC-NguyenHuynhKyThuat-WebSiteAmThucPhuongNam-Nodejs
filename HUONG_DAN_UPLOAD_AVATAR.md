# 📸 Hướng Dẫn Upload & Quản Lý Ảnh Đại Diện

## ✨ Tính năng đã thêm:

### 1. **Upload Ảnh Đại Diện**
- Người dùng có thể upload ảnh từ trang Tài khoản
- Hỗ trợ định dạng: JPG, PNG, GIF, WebP
- Kích thước tối đa: 5MB
- Tự động cập nhật ảnh trên navbar ngay lập tức

### 2. **Xóa Ảnh Đại Diện**
- Nút xóa xuất hiện khi có ảnh
- Xác nhận trước khi xóa
- Quay về icon mặc định sau khi xóa

### 3. **Preview Realtime**
- Hover vào ảnh đại diện → Hiển thị overlay "Đổi ảnh"
- Upload xong → Ảnh hiển thị ngay lập tức
- Tự động sync với navbar

---

## 🎯 Cách sử dụng:

### **Bước 1: Đăng nhập**
```
1. Truy cập: http://localhost:5500/frontend/dang-nhap.html
2. Đăng nhập với tài khoản bất kỳ
```

### **Bước 2: Vào trang Tài khoản**
```
1. Click vào avatar/tên người dùng trên navbar
2. Chọn "Tài khoản của tôi"
3. Hoặc truy cập: http://localhost:5500/frontend/tai-khoan.html
```

### **Bước 3: Upload ảnh**
```
1. Hover chuột vào ảnh đại diện
2. Thấy overlay "Đổi ảnh" xuất hiện
3. Click vào ảnh
4. Chọn file ảnh từ máy tính
5. Đợi upload (hiển thị spinner)
6. Thành công → Ảnh hiển thị ngay
```

### **Bước 4: Xóa ảnh (tùy chọn)**
```
1. Click nút thùng rác màu đỏ ở góc dưới phải ảnh
2. Xác nhận xóa
3. Ảnh về icon mặc định
```

---

## 🔧 Chi tiết kỹ thuật:

### **Frontend (tai-khoan.html)**

#### HTML Structure:
```html
<div class="relative group">
    <!-- Avatar Container -->
    <div id="user-avatar">
        <i class="fas fa-user"></i>
    </div>
    
    <!-- Upload Overlay (hiện khi hover) -->
    <label for="avatar-upload">
        <i class="fas fa-camera"></i>
        Đổi ảnh
    </label>
    
    <!-- Hidden File Input -->
    <input type="file" id="avatar-upload" accept="image/*" hidden>
    
    <!-- Remove Button -->
    <button id="remove-avatar-btn">
        <i class="fas fa-trash"></i>
    </button>
</div>
```

#### JavaScript Functions:

1. **updateAvatarDisplay(avatarPath, userName)**
   - Cập nhật hiển thị ảnh đại diện
   - Hiển thị/ẩn nút xóa

2. **Avatar Upload Handler**
   - Validate file type & size
   - Upload qua API `/api/auth/upload-avatar`
   - Cập nhật database
   - Sync với localStorage & navbar

3. **Remove Avatar Handler**
   - Xác nhận trước khi xóa
   - Cập nhật database (set null)
   - Quay về icon mặc định

### **Backend (routes/auth.js)**

#### Upload Avatar Endpoint:
```javascript
POST /api/auth/upload-avatar
Headers: Authorization: Bearer <token>
Body: FormData with 'avatar' file

Response:
{
  "success": true,
  "data": {
    "anh_dai_dien": "/images/avatars/avatar-1234567890-123456789.jpg"
  }
}
```

#### Multer Configuration:
```javascript
- Destination: backend/images/avatars/
- Filename: avatar-<timestamp>-<random>.<ext>
- File Filter: Chỉ chấp nhận images
- Size Limit: 5MB
```

---

## 📋 Database Schema:

```sql
nguoi_dung table:
- anh_dai_dien VARCHAR(255) NULL
  Lưu đường dẫn: /images/avatars/avatar-xxx.jpg
```

---

## 🧪 Test Cases:

### ✅ Test 1: Upload ảnh thành công
```
1. Chọn ảnh JPG < 5MB
2. Upload thành công
3. Ảnh hiển thị đúng
4. Navbar cập nhật
5. Database lưu đường dẫn
```

### ✅ Test 2: Upload file không hợp lệ
```
1. Chọn file PDF
2. Thông báo lỗi "Vui lòng chọn file ảnh"
3. Không upload
```

### ✅ Test 3: Upload file quá lớn
```
1. Chọn ảnh > 5MB
2. Thông báo lỗi "Kích thước ảnh không được vượt quá 5MB"
3. Không upload
```

### ✅ Test 4: Xóa ảnh đại diện
```
1. Click nút xóa
2. Confirm xóa
3. Ảnh về icon mặc định
4. Navbar cập nhật
5. Database set NULL
```

### ✅ Test 5: Upload ảnh mới (thay thế ảnh cũ)
```
1. Đã có ảnh
2. Upload ảnh khác
3. Ảnh mới thay thế ảnh cũ
4. File cũ vẫn tồn tại trên server (có thể cleanup sau)
```

---

## 🔍 Debugging:

### Check Avatar Path in Database:
```sql
SELECT ma_nguoi_dung, ten_nguoi_dung, anh_dai_dien 
FROM nguoi_dung 
WHERE ma_nguoi_dung = <your_user_id>;
```

### Check localStorage:
```javascript
// Trong DevTools Console:
JSON.parse(localStorage.getItem('user')).anh_dai_dien
```

### Check Uploaded Files:
```
Kiểm tra thư mục: backend/images/avatars/
File có format: avatar-1730712345-987654321.jpg
```

### Backend Logs:
```
Upload thành công sẽ log:
✅ File uploaded: avatar-xxx.jpg
Path: /images/avatars/avatar-xxx.jpg
```

---

## ⚠️ Lưu ý:

1. **CORS**: Backend đã enable CORS cho frontend
2. **Authentication**: Upload cần JWT token
3. **File Storage**: Files lưu trong `backend/images/avatars/`
4. **URL Access**: Ảnh serve qua `http://localhost:3000/images/avatars/xxx.jpg`
5. **Cleanup**: Chưa có auto-delete file cũ khi upload ảnh mới

---

## 🚀 Tối ưu hóa (Tương lai):

1. **Image Optimization**:
   - Resize ảnh về kích thước chuẩn (256x256)
   - Compress để giảm dung lượng
   - Convert sang WebP

2. **File Cleanup**:
   - Xóa file cũ khi upload ảnh mới
   - Cronjob dọn dẹp file không dùng

3. **CDN/Cloud Storage**:
   - Upload lên AWS S3 / Cloudinary
   - Giảm tải cho server

4. **Validation nâng cao**:
   - Scan virus
   - Kiểm tra nội dung không phù hợp

---

## 📞 Support:

Nếu gặp lỗi:
1. Check Backend logs
2. Check Browser Console
3. Check Network tab (DevTools)
4. Verify file permissions trên server

Happy coding! 🎉
