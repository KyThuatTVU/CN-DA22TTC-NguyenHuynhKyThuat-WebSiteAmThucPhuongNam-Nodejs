# 🔧 Hướng dẫn kiểm tra load ảnh Google Avatar

## ✅ Những gì đã sửa

### 1. **Backend - Passport.js**
- ✅ Thay đổi size ảnh Google từ `s=96` sang `s=200` để có ảnh rõ nét hơn
- ✅ Log URL ảnh ra console để debug
- ✅ Truyền `anh_dai_dien` vào session

### 2. **Backend - admin-auth.js**
- ✅ Lưu `anh_dai_dien` vào database khi admin đăng nhập Google
- ✅ Lưu `anh_dai_dien` vào session để frontend lấy

### 3. **Frontend - admin-layout.js**  
- ✅ Thêm `referrerpolicy="no-referrer"` để tránh bị chặn bởi Google
- ✅ Thêm `crossorigin="anonymous"` để load ảnh cross-origin
- ✅ Thêm fallback tự động về UI Avatars nếu ảnh Google lỗi
- ✅ Log URL ảnh trong error để debug

## 🧪 Cách kiểm tra

### Bước 1: Restart backend
```bash
# Ctrl+C để dừng server hiện tại
# Chạy lại:
npm start
```

### Bước 2: Test load ảnh
1. Mở trình duyệt và vào: `http://localhost:3000/admin/dang-nhap-admin.html`
2. Click "Đăng nhập với Google"
3. Chọn tài khoản Google admin của bạn
4. Mở Console (F12)
5. Xem các log:
   - `📸 Google Avatar URL:` - URL ảnh từ backend
   - `📦 Admin data from server:` - Dữ liệu admin từ session
   - `👤 Processed admin info:` - Thông tin đã xử lý
   - `🖼️ Setting image src for #admin-avatar:` - URL đang set vào img

### Bước 3: Sử dụng trang test
1. Mở: `http://localhost:3000/admin/test-google-image.html`
2. Copy URL từ console log `👤 Processed admin info: { avatar: "URL_O_DAY" }`
3. Paste vào ô input và click "Test URL này"
4. Xem kết quả:
   - ✅ Nếu load thành công → Tốt!
   - ❌ Nếu lỗi → Copy URL và gửi cho tôi để kiểm tra

## 🔍 Debug nếu vẫn lỗi

### Kiểm tra trong Console:
```javascript
// Chạy lệnh này trong Console để xem session hiện tại
fetch('http://localhost:3000/api/admin-auth/check-session', {credentials: 'include'})
  .then(r => r.json())
  .then(d => console.log('📦 Session:', d));
```

### Các vấn đề thường gặp:

#### 1. ❌ URL ảnh bị chặn bởi CORS
**Triệu chứng:** Console hiện lỗi CORS  
**Giải pháp:** ✅ Đã thêm `crossorigin="anonymous"`

#### 2. ❌ URL ảnh bị chặn bởi Referrer Policy
**Triệu chứng:** Console hiện 403 Forbidden  
**Giải pháp:** ✅ Đã thêm `referrerpolicy="no-referrer"`

#### 3. ❌ URL ảnh không tồn tại trong database
**Triệu chứng:** `anh_dai_dien` là `null`  
**Giải pháp:** 
- Đăng xuất
- Đăng nhập lại với Google
- Kiểm tra backend log có `✅ Updated admin info from Google`

#### 4. ❌ URL ảnh có format lạ
**Triệu chứng:** URL không có pattern `s96` hoặc `s=96`  
**Giải pháp:** Copy URL và gửi cho tôi

## 📊 Kết quả mong đợi

Sau khi hoàn thành các bước trên, bạn sẽ thấy:

1. ✅ Ảnh đại diện Google hiển thị trong admin panel
2. ✅ Không có lỗi ❌ trong console
3. ✅ Chỉ có cảnh báo ⚠️ nếu ảnh Google thực sự không load được
4. ✅ Tự động fallback về ảnh UI Avatars nếu ảnh Google lỗi

## 🎯 URL ảnh Google đúng format

URL từ Google thường có dạng:
```
https://lh3.googleusercontent.com/a/ACg8ocK...=s200-c
hoặc
https://lh3.googleusercontent.com/a/ACg8ocK...?sz=200
```

Nếu URL của bạn khác, hãy cho tôi biết!
