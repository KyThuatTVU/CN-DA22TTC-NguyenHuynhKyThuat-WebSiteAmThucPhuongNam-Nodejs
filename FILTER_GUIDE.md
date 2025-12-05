# Hướng dẫn Sử dụng Bộ lọc Dashboard

## Tổng quan

Hệ thống bộ lọc đã được cập nhật hoàn chỉnh cho trang Dashboard Admin. Tất cả biểu đồ và thống kê đều sử dụng dữ liệu thật từ database và hỗ trợ filter theo nhiều tiêu chí.

## Các tính năng đã cập nhật

### 1. Backend API - Hỗ trợ Filter

Tất cả các API endpoint sau đã được cập nhật để hỗ trợ filter:

#### `/api/stats/revenue-monthly`
- **Tham số**: `year`, `month`
- **Mô tả**: Lấy doanh thu theo tháng
- **Ví dụ**: `/api/stats/revenue-monthly?year=2024&month=11`

#### `/api/stats/customers-monthly`
- **Tham số**: `year`, `month`
- **Mô tả**: Lấy số khách hàng mới theo tháng
- **Ví dụ**: `/api/stats/customers-monthly?year=2024`

#### `/api/stats/reservations-by-time`
- **Tham số**: `year`, `month`
- **Mô tả**: Lấy thống kê đặt bàn theo khung giờ
- **Ví dụ**: `/api/stats/reservations-by-time?year=2024&month=12`

#### `/api/stats/news-views-monthly`
- **Tham số**: `year`, `month`
- **Mô tả**: Lấy lượt xem tin tức theo tháng
- **Ví dụ**: `/api/stats/news-views-monthly?year=2024`

#### `/api/stats/top-products`
- **Tham số**: `year`, `month`
- **Mô tả**: Lấy top món ăn bán chạy
- **Ví dụ**: `/api/stats/top-products?year=2024&month=11`

#### `/api/orders/stats`
- **Tham số**: `year`, `month`, `status`
- **Mô tả**: Lấy thống kê đơn hàng
- **Ví dụ**: `/api/orders/stats?year=2024&month=11&status=delivered`

### 2. Frontend - Bộ lọc Dashboard

#### Các loại filter:

1. **Filter theo Năm**
   - Chọn năm: 2023, 2024, 2025
   - Mặc định: Năm hiện tại

2. **Filter theo Tháng**
   - Chọn tháng: All, 1-12
   - Mặc định: All (tất cả tháng trong năm)

3. **Filter theo Trạng thái Đơn hàng**
   - Tất cả
   - Chờ xử lý (pending)
   - Đã xác nhận (confirmed)
   - Hoàn thành (delivered)
   - Đã hủy (cancelled)

#### Các biểu đồ được filter:

✅ **Tất cả biểu đồ đều được cập nhật khi filter:**

1. **KPI Cards**
   - Tổng doanh thu
   - Số đơn hàng
   - Biểu đồ Gauge (tỷ lệ hoàn thành mục tiêu)
   - Biểu đồ đơn hàng theo trạng thái

2. **Biểu đồ Doanh thu 12 tháng**
   - Hiển thị doanh thu theo năm được chọn
   - Nếu chọn tháng cụ thể, chỉ hiển thị tháng đó

3. **Biểu đồ Khách hàng mới**
   - Hiển thị khách hàng mới theo năm được chọn

4. **Biểu đồ Đặt bàn theo khung giờ**
   - Hiển thị đặt bàn theo năm/tháng được chọn

5. **Biểu đồ Lượt xem tin tức**
   - Hiển thị lượt xem theo năm được chọn

6. **Top 10 món ăn bán chạy**
   - Hiển thị top món theo năm/tháng được chọn

7. **Đơn hàng gần đây**
   - Lọc theo trạng thái được chọn

### 3. Tính năng UX

#### Loading State
- Hiển thị overlay loading khi đang tải dữ liệu
- Ngăn người dùng click nhiều lần trong lúc đang xử lý

#### Filter Summary
- Hiển thị filter đang áp dụng ở dưới cùng sidebar
- Ví dụ: "Tháng 11/2024 - Hoàn thành"

#### Nút Reset
- Đặt lại tất cả filter về mặc định
- Mặc định: Năm hiện tại, Tháng All, Trạng thái All

## Cách sử dụng

### Bước 1: Chọn Năm
Click vào nút năm muốn xem (2023, 2024, 2025)

### Bước 2: Chọn Tháng (tùy chọn)
- Click "All" để xem tất cả tháng trong năm
- Click số tháng (1-12) để xem tháng cụ thể

### Bước 3: Chọn Trạng thái (tùy chọn)
- Click "Tất cả" để xem tất cả trạng thái
- Click trạng thái cụ thể để lọc

### Bước 4: Xem kết quả
- Tất cả biểu đồ sẽ tự động cập nhật
- Xem filter summary ở dưới cùng sidebar

### Bước 5: Reset (nếu cần)
Click nút "Reset" để đặt lại về mặc định

## Lưu ý kỹ thuật

### Performance
- Tất cả API call được thực hiện song song (Promise.all)
- Chỉ load dữ liệu cần thiết khi filter thay đổi
- Sử dụng loading state để tránh spam request

### Data Validation
- Backend validate tất cả tham số input
- Frontend validate trước khi gửi request
- Xử lý lỗi gracefully nếu API fail

### Caching
- Không có caching ở frontend (luôn load fresh data)
- Backend query trực tiếp từ database
- Đảm bảo dữ liệu luôn real-time

## Troubleshooting

### Biểu đồ không cập nhật
1. Kiểm tra console log xem có lỗi API không
2. Kiểm tra network tab xem request có được gửi không
3. Kiểm tra backend log xem có lỗi query không

### Dữ liệu không đúng
1. Kiểm tra filter đang áp dụng (xem filter summary)
2. Kiểm tra dữ liệu trong database
3. Kiểm tra query SQL trong backend

### Loading quá lâu
1. Kiểm tra kết nối database
2. Kiểm tra index trong database
3. Kiểm tra số lượng dữ liệu cần query

## Mở rộng trong tương lai

### Có thể thêm:
1. Filter theo khoảng ngày tùy chỉnh
2. Export dữ liệu theo filter
3. Lưu filter preset
4. So sánh giữa các khoảng thời gian
5. Filter theo danh mục món ăn
6. Filter theo khu vực giao hàng

## Kết luận

Hệ thống bộ lọc đã hoàn chỉnh và sẵn sàng sử dụng. Tất cả biểu đồ đều sử dụng dữ liệu thật từ database và được cập nhật real-time khi filter thay đổi.
