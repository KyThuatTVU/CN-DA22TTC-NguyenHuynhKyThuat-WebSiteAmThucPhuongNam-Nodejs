# Test Filter API Endpoints

## Hướng dẫn Test

### 1. Khởi động server
```bash
cd backend
npm start
```

### 2. Test các API endpoint với filter

#### Test Revenue Monthly API
```bash
# Lấy doanh thu tất cả tháng năm 2024
curl "http://localhost:3000/api/stats/revenue-monthly?year=2024"

# Lấy doanh thu tháng 11/2024
curl "http://localhost:3000/api/stats/revenue-monthly?year=2024&month=11"

# Lấy doanh thu 12 tháng gần nhất (không có filter)
curl "http://localhost:3000/api/stats/revenue-monthly"
```

#### Test Customers Monthly API
```bash
# Lấy khách hàng mới năm 2024
curl "http://localhost:3000/api/stats/customers-monthly?year=2024"

# Lấy khách hàng mới tháng 12/2024
curl "http://localhost:3000/api/stats/customers-monthly?year=2024&month=12"
```

#### Test Reservations By Time API
```bash
# Lấy đặt bàn theo giờ năm 2024
curl "http://localhost:3000/api/stats/reservations-by-time?year=2024"

# Lấy đặt bàn theo giờ tháng 11/2024
curl "http://localhost:3000/api/stats/reservations-by-time?year=2024&month=11"
```

#### Test News Views Monthly API
```bash
# Lấy lượt xem tin tức năm 2024
curl "http://localhost:3000/api/stats/news-views-monthly?year=2024"

# Lấy lượt xem tin tức tháng 12/2024
curl "http://localhost:3000/api/stats/news-views-monthly?year=2024&month=12"
```

#### Test Top Products API
```bash
# Lấy top món bán chạy năm 2024
curl "http://localhost:3000/api/stats/top-products?year=2024"

# Lấy top món bán chạy tháng 11/2024
curl "http://localhost:3000/api/stats/top-products?year=2024&month=11"
```

#### Test Orders Stats API
```bash
# Lấy thống kê đơn hàng năm 2024
curl "http://localhost:3000/api/orders/stats?year=2024"

# Lấy thống kê đơn hàng tháng 11/2024
curl "http://localhost:3000/api/orders/stats?year=2024&month=11"

# Lấy thống kê đơn hàng đã hoàn thành tháng 11/2024
curl "http://localhost:3000/api/orders/stats?year=2024&month=11&status=delivered"
```

## Expected Response Format

### Revenue Monthly
```json
{
  "success": true,
  "data": [
    {
      "nam": 2024,
      "thang": 1,
      "doanh_thu": 15000000
    },
    {
      "nam": 2024,
      "thang": 2,
      "doanh_thu": 18000000
    }
  ]
}
```

### Customers Monthly
```json
{
  "success": true,
  "data": [
    {
      "nam": 2024,
      "thang": 1,
      "so_luong": 25
    }
  ]
}
```

### Reservations By Time
```json
{
  "success": true,
  "data": [
    {
      "khung_gio": "10-12h",
      "so_luong": 5
    },
    {
      "khung_gio": "12-14h",
      "so_luong": 15
    }
  ]
}
```

### Top Products
```json
{
  "success": true,
  "data": [
    {
      "ma_mon": 1,
      "ten_mon": "Phở bò",
      "anh_mon": "/images/pho-bo.jpg",
      "gia_tien": 50000,
      "da_ban": 150
    }
  ]
}
```

## Test Frontend

### 1. Mở Dashboard Admin
```
http://localhost:3000/frontend/admin/dashboard.html
```

### 2. Test Filter UI

#### Test Filter Năm
1. Click vào nút "2024"
2. Kiểm tra:
   - Loading overlay xuất hiện
   - Tất cả biểu đồ được cập nhật
   - Filter summary hiển thị "Tất cả dữ liệu năm 2024"

#### Test Filter Tháng
1. Click vào nút "11" (tháng 11)
2. Kiểm tra:
   - Loading overlay xuất hiện
   - Biểu đồ doanh thu chỉ hiển thị tháng 11
   - Filter summary hiển thị "Tháng 11/2024"

#### Test Filter Trạng thái
1. Click vào "Hoàn thành"
2. Kiểm tra:
   - Đơn hàng gần đây chỉ hiển thị đơn hoàn thành
   - Filter summary hiển thị "... - Hoàn thành"

#### Test Reset Button
1. Click nút "Reset"
2. Kiểm tra:
   - Tất cả filter về mặc định
   - Năm = năm hiện tại
   - Tháng = All
   - Trạng thái = Tất cả

### 3. Test Console Log

Mở Developer Tools (F12) và kiểm tra:
- Không có lỗi JavaScript
- API calls được gửi với đúng query params
- Response data đúng format

### 4. Test Network Tab

Kiểm tra trong Network tab:
- Tất cả API calls trả về status 200
- Query params được gửi đúng
- Response time hợp lý (< 1s)

## Checklist

### Backend
- [ ] API `/stats/revenue-monthly` hỗ trợ filter year, month
- [ ] API `/stats/customers-monthly` hỗ trợ filter year, month
- [ ] API `/stats/reservations-by-time` hỗ trợ filter year, month
- [ ] API `/stats/news-views-monthly` hỗ trợ filter year, month
- [ ] API `/stats/top-products` hỗ trợ filter year, month
- [ ] API `/orders/stats` hỗ trợ filter year, month, status
- [ ] Tất cả API trả về đúng format JSON
- [ ] Tất cả API xử lý lỗi gracefully

### Frontend
- [ ] Bộ lọc hiển thị đúng (Năm, Tháng, Trạng thái)
- [ ] Click filter cập nhật tất cả biểu đồ
- [ ] Loading overlay hiển thị khi đang tải
- [ ] Filter summary hiển thị đúng
- [ ] Nút Reset hoạt động đúng
- [ ] Không có lỗi JavaScript trong console
- [ ] Tất cả biểu đồ hiển thị dữ liệu đúng
- [ ] UX mượt mà, không lag

### Data Validation
- [ ] Dữ liệu biểu đồ khớp với filter
- [ ] Số liệu KPI cards đúng
- [ ] Top products đúng theo filter
- [ ] Đơn hàng gần đây đúng theo filter
- [ ] So sánh với tháng trước hiển thị đúng

## Troubleshooting

### Lỗi: API trả về 401 Unauthorized
**Giải pháp**: Đăng nhập admin trước khi test

### Lỗi: Biểu đồ không cập nhật
**Giải pháp**: 
1. Kiểm tra console log
2. Kiểm tra network tab
3. Kiểm tra hàm `loadDashboardDataWithFilters`

### Lỗi: Loading overlay không biến mất
**Giải pháp**: 
1. Kiểm tra Promise.finally() có được gọi không
2. Kiểm tra hàm `hideFilterLoading()`

### Lỗi: Filter summary không cập nhật
**Giải pháp**: 
1. Kiểm tra hàm `updateFilterSummary()`
2. Kiểm tra element `#filter-summary-text` có tồn tại không

## Kết quả mong đợi

✅ Tất cả API endpoint hoạt động với filter
✅ Frontend filter cập nhật tất cả biểu đồ
✅ UX mượt mà với loading state
✅ Dữ liệu chính xác theo filter
✅ Không có lỗi trong console
✅ Performance tốt (< 1s response time)
