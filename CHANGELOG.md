# Changelog - Cập nhật Website Ẩm Thực Phương Nam

## [1.0.0] - 2025-10-30

### ✨ Tính năng mới

#### Backend
- ✅ Kết nối database MySQL thành công
- ✅ API RESTful cho món ăn, danh mục, album
- ✅ Serve static files cho frontend và images
- ✅ CORS enabled cho cross-origin requests
- ✅ Connection pooling cho hiệu suất tốt hơn

#### Frontend - Trang Thực Đơn
- ✅ Load dữ liệu động từ database (25 món ăn)
- ✅ Hiển thị ảnh món ăn đầy đủ và đẹp mắt
- ✅ Lọc món ăn theo danh mục (5 danh mục)
- ✅ Responsive design cho mobile, tablet, desktop

### 🎨 Cải thiện giao diện

#### Card món ăn
- Ảnh món ăn full cover với tỷ lệ 16:9
- Hover effect: zoom ảnh + overlay gradient
- Badge hiển thị trạng thái (Hết hàng, Sắp hết)
- Badge danh mục với icon
- Nút yêu thích với hover animation
- Nút thêm giỏ hàng với rotate effect

#### Hiệu ứng
- Loading skeleton khi tải dữ liệu
- GSAP animations: fade in, slide up
- Stagger animation cho cards
- Smooth scroll khi đổi danh mục
- Pulse animation cho badge giảm giá

#### Typography & Colors
- Gradient text cho giá tiền
- Font weight hierarchy rõ ràng
- Color scheme: Orange (#ea580c) - Red (#dc2626)
- Shadow effects cho depth

### 🔧 Sửa lỗi

- ✅ Sửa đường dẫn ảnh trong database
  - `cataituongchienxuu.jpg` → `cataituongchienxu.jpg`
  - `banhuyenunong.jpg` → `banhuyenuong.jpg`
  - `lamammiantay.jpg` → `laumammientay.jpg`
- ✅ Tất cả 25 món đã có ảnh hiển thị đúng
- ✅ Placeholder SVG cho ảnh bị lỗi
- ✅ Lazy loading cho ảnh

### 📱 Responsive

- Mobile (< 640px): 1 cột, ảnh 200px
- Tablet (640-1024px): 2 cột, ảnh 240px
- Desktop (> 1024px): 3 cột, ảnh 280px

### 🚀 Performance

- Connection pooling cho database
- Lazy loading images
- CSS animations thay vì JavaScript
- GSAP cho smooth animations
- Optimized image serving

### 📊 Database

**Bảng đang sử dụng:**
- `mon_an` - 25 món ăn
- `danh_muc` - 5 danh mục
- `album_anh` - 2 album
- `anh_san_pham` - 5 ảnh

**Cấu trúc món ăn:**
- ma_mon, ten_mon, mo_ta_chi_tiet
- gia_tien, so_luong_ton, don_vi_tinh
- anh_mon, ma_danh_muc, trang_thai

### 🎯 Tính năng sắp tới

- [ ] Tìm kiếm món ăn
- [ ] Sắp xếp theo giá, tên, đánh giá
- [ ] Lọc theo khoảng giá
- [ ] Pagination
- [ ] Chi tiết món ăn (modal/page)
- [ ] Thêm vào giỏ hàng (functional)
- [ ] Yêu thích món ăn
- [ ] Đánh giá và review

### 📝 Ghi chú

- Server chạy tại: http://localhost:3000
- API endpoint: http://localhost:3000/api
- Frontend: http://localhost:3000/thuc-don.html
- Database: amthuc_phuongnam (MySQL port 3307)
