# Tính năng động cho trang Thực Đơn

## Các tính năng đã cài đặt:

### 1. **Tải dữ liệu động từ API**
- Tất cả món ăn được tải từ backend API
- Hiển thị loading skeleton khi đang tải
- Xử lý lỗi khi không thể kết nối API

### 2. **Responsive Design - Tối ưu cho Mobile**
- Giao diện tự động điều chỉnh theo kích thước màn hình
- Filter sidebar dạng overlay trên mobile
- Dropdown sắp xếp riêng cho mobile
- Grid layout tối ưu: 1 cột (mobile), 2 cột (tablet), 3 cột (desktop)
- Pagination thu gọn trên mobile
- Touch-friendly buttons và inputs
- Backdrop overlay khi mở filter trên mobile

### 3. **Tìm kiếm món ăn**
- Tìm kiếm theo tên món và mô tả
- Debounce 300ms để tối ưu hiệu suất
- Nút xóa tìm kiếm nhanh

### 4. **Lọc theo danh mục**
- Lọc món ăn theo danh mục (Canh & Súp, Hải sản, Thịt, Rau, Cơm, Đồ uống)
- Danh mục được tải động từ database
- Chỉ cho phép chọn 1 danh mục tại một thời điểm

### 5. **Lọc theo giá**
- Dưới 100.000đ
- 100.000đ - 200.000đ
- 200.000đ - 500.000đ
- Trên 500.000đ

### 6. **Sắp xếp**
- Phổ biến (theo số lượng tồn kho)
- Mới nhất (theo mã món)
- Giá tăng dần
- Giá giảm dần

### 7. **Phân trang**
- Hiển thị 9 món/trang
- Điều hướng trang với nút Previous/Next
- Hiển thị số trang hiện tại
- Tự động scroll về đầu danh sách khi chuyển trang

### 8. **Đếm số lượng**
- Hiển thị tổng số món ăn tìm thấy
- Cập nhật động khi lọc/tìm kiếm

### 9. **Reset bộ lọc**
- Nút "Đặt lại" để xóa tất cả bộ lọc
- Quay về trạng thái ban đầu

## Cách sử dụng:

### Khởi động Backend:
```bash
cd backend
npm install
npm start
```

### Mở trang web:
```
frontend/thuc-don.html
```

## API Endpoints:

- `GET /api/menu` - Lấy tất cả món ăn
- `GET /api/menu/category/:id` - Lấy món ăn theo danh mục
- `GET /api/menu/:id` - Lấy chi tiết món ăn
- `GET /api/categories` - Lấy tất cả danh mục

## Query Parameters hỗ trợ:

- `search` - Tìm kiếm theo tên/mô tả
- `category` - Lọc theo danh mục
- `minPrice` - Giá tối thiểu
- `maxPrice` - Giá tối đa
- `sortBy` - Sắp xếp (newest, price-asc, price-desc, popular)

## Ví dụ:
```
GET /api/menu?search=cá&category=2&minPrice=100000&maxPrice=500000&sortBy=price-asc
```


## Tính năng Mobile-Specific:

### Breakpoints:
- **Mobile**: < 640px (1 cột sản phẩm)
- **Tablet**: 640px - 1024px (2 cột sản phẩm)
- **Desktop**: > 1024px (3 cột sản phẩm)

### Mobile Features:
1. **Filter Toggle Button**: Nút mở/đóng bộ lọc với icon động
2. **Full-screen Filter Overlay**: Bộ lọc hiển thị toàn màn hình với backdrop
3. **Mobile Sort Dropdown**: Dropdown sắp xếp thay vì buttons
4. **Compact Pagination**: Hiển thị ít trang hơn trên mobile
5. **Touch Optimized**: Buttons và inputs có kích thước phù hợp cho touch
6. **Auto-close Filter**: Tự động đóng filter sau khi apply trên mobile
7. **Responsive Typography**: Font size tự động điều chỉnh
8. **Optimized Images**: Lazy loading và responsive image containers

### UX Improvements:
- Smooth animations khi mở/đóng filter
- Backdrop click để đóng filter
- Scroll to top khi chuyển trang
- Debounced search (300ms)
- Loading skeleton cho trải nghiệm mượt mà
- Error handling với retry button
