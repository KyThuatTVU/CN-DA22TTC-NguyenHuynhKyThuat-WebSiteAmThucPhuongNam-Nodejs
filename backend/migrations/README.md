# 📋 Database Migrations

## Danh sách Migrations

### 1. create_order_status_history.sql
**Mục đích**: Tạo bảng `lich_su_trang_thai_don_hang` để theo dõi lịch sử thay đổi trạng thái đơn hàng

**Chức năng**:
- Lưu lịch sử mỗi lần trạng thái đơn hàng thay đổi
- Tự động ghi log khi tạo đơn hàng mới
- Tự động ghi log khi cập nhật trạng thái
- Hỗ trợ theo dõi ai thay đổi (admin/user/system)

**Cấu trúc bảng**:
```sql
lich_su_trang_thai_don_hang (
  ma_lich_su INT PRIMARY KEY AUTO_INCREMENT,
  ma_don_hang INT NOT NULL,
  trang_thai_cu VARCHAR(50),
  trang_thai_moi VARCHAR(50) NOT NULL,
  nguoi_thay_doi INT,
  loai_nguoi_thay_doi ENUM('admin', 'user', 'system'),
  ghi_chu TEXT,
  thoi_gian_thay_doi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
```

**Triggers**:
- `after_don_hang_insert`: Tự động ghi log khi tạo đơn hàng
- `after_don_hang_update`: Tự động ghi log khi cập nhật trạng thái

---

## Cách chạy Migration

### Cách 1: Dùng script tự động (Recommended)

```bash
cd backend
node scripts/create-order-status-history-table.js
```

Script sẽ:
1. Xóa bảng cũ (nếu có)
2. Tạo bảng mới
3. Tạo triggers
4. Import dữ liệu lịch sử cho đơn hàng hiện có

### Cách 2: Chạy SQL trực tiếp

```bash
mysql -u root -p amthuc_phuongnam < backend/migrations/create_order_status_history.sql
```

### Cách 3: Dùng MySQL Workbench

1. Mở MySQL Workbench
2. Connect đến database `amthuc_phuongnam`
3. Mở file `create_order_status_history.sql`
4. Execute

---

## Kiểm tra Migration

### Kiểm tra bảng đã tồn tại
```sql
SHOW TABLES LIKE 'lich_su_trang_thai_don_hang';
```

### Kiểm tra cấu trúc bảng
```sql
DESCRIBE lich_su_trang_thai_don_hang;
```

### Kiểm tra triggers
```sql
SHOW TRIGGERS WHERE `Table` = 'don_hang';
```

### Kiểm tra dữ liệu
```sql
SELECT * FROM lich_su_trang_thai_don_hang ORDER BY thoi_gian_thay_doi DESC LIMIT 10;
```

---

## Rollback Migration

Nếu cần xóa bảng và triggers:

```sql
-- Xóa triggers
DROP TRIGGER IF EXISTS after_don_hang_insert;
DROP TRIGGER IF EXISTS after_don_hang_update;

-- Xóa bảng
DROP TABLE IF EXISTS lich_su_trang_thai_don_hang;
```

---

## Sử dụng trong Code

### Lấy lịch sử đơn hàng

```javascript
const [history] = await db.query(`
    SELECT * FROM lich_su_trang_thai_don_hang 
    WHERE ma_don_hang = ? 
    ORDER BY thoi_gian_thay_doi ASC
`, [orderId]);
```

### Thêm log thủ công (nếu cần)

```javascript
await db.query(`
    INSERT INTO lich_su_trang_thai_don_hang 
    (ma_don_hang, trang_thai_cu, trang_thai_moi, nguoi_thay_doi, loai_nguoi_thay_doi, ghi_chu)
    VALUES (?, ?, ?, ?, ?, ?)
`, [orderId, oldStatus, newStatus, userId, 'admin', 'Cập nhật bởi admin']);
```

---

## Lưu ý

- ⚠️ Triggers sẽ tự động ghi log, không cần thêm code
- ⚠️ Nếu cập nhật trạng thái bằng code, triggers sẽ tự động chạy
- ⚠️ Xóa đơn hàng sẽ tự động xóa lịch sử (CASCADE)
- ✅ Bảng này giúp audit trail và debug
- ✅ Có thể dùng để hiển thị timeline cho khách hàng

---

## Tích hợp với Frontend

Có thể hiển thị timeline trạng thái đơn hàng:

```javascript
// API endpoint
GET /api/orders/:id/history

// Response
{
  "success": true,
  "data": [
    {
      "trang_thai_moi": "pending",
      "thoi_gian_thay_doi": "2025-01-20 10:00:00",
      "ghi_chu": "Đơn hàng được tạo"
    },
    {
      "trang_thai_cu": "pending",
      "trang_thai_moi": "confirmed",
      "thoi_gian_thay_doi": "2025-01-20 10:15:00",
      "ghi_chu": "Đơn hàng đã được xác nhận"
    }
  ]
}
```

---

## Troubleshooting

### Lỗi: Table already exists
```bash
# Xóa bảng cũ và chạy lại
node scripts/create-order-status-history-table.js
```

### Lỗi: Trigger already exists
```sql
-- Xóa triggers cũ
DROP TRIGGER IF EXISTS after_don_hang_insert;
DROP TRIGGER IF EXISTS after_don_hang_update;
-- Chạy lại migration
```

### Lỗi: Foreign key constraint fails
```sql
-- Kiểm tra bảng don_hang tồn tại
SHOW TABLES LIKE 'don_hang';
-- Kiểm tra cột ma_don_hang
DESCRIBE don_hang;
```
