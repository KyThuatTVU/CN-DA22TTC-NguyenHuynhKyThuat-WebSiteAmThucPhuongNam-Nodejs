# ✅ Cập nhật: Mỗi Comment Chỉ Có 1 Reply

## Thay đổi Logic

### Trước đây
- Admin có thể tạo nhiều reply cho cùng 1 comment/đánh giá
- Mỗi lần trả lời tạo ra 1 record mới
- Khó quản lý khi có nhiều reply

### Bây giờ
- ✅ **Mỗi comment/đánh giá chỉ có 1 reply duy nhất**
- ✅ **Lần đầu**: Tạo reply mới
- ✅ **Lần sau**: Cập nhật (edit) reply cũ
- ✅ **Hiển thị lịch sử**: Thời gian cập nhật thay đổi

## Backend Logic

### API: POST /api/reviews/:reviewId/reply

```javascript
// Kiểm tra xem đã có reply chưa
const [existingReply] = await db.query(
    'SELECT ma_tra_loi FROM tra_loi_danh_gia WHERE ma_danh_gia = ?',
    [reviewId]
);

if (existingReply.length > 0) {
    // CẬP NHẬT reply cũ
    await db.query(
        `UPDATE tra_loi_danh_gia 
        SET noi_dung = ?, ten_admin = ?, ngay_tra_loi = NOW()
        WHERE ma_tra_loi = ?`,
        [noi_dung, adminName, existingReply[0].ma_tra_loi]
    );
    message = 'Cập nhật trả lời thành công';
} else {
    // TẠO MỚI reply
    await db.query(
        `INSERT INTO tra_loi_danh_gia (ma_danh_gia, noi_dung, ten_admin) 
        VALUES (?, ?, ?)`,
        [reviewId, noi_dung, adminName]
    );
    message = 'Trả lời đánh giá thành công';
}
```

### API: POST /api/news/comments/:commentId/reply

```javascript
// Kiểm tra xem đã có reply của admin chưa
const [existingReply] = await db.query(
    `SELECT ma_binh_luan FROM binh_luan_tin_tuc 
    WHERE ma_binh_luan_cha = ? AND email_nguoi_binh_luan = 'admin@phuongnam.vn'`,
    [commentId]
);

if (existingReply.length > 0) {
    // CẬP NHẬT reply cũ
    await db.query(
        `UPDATE binh_luan_tin_tuc 
        SET noi_dung = ?, ten_nguoi_binh_luan = ?, ngay_binh_luan = NOW()
        WHERE ma_binh_luan = ?`,
        [noi_dung, adminName, existingReply[0].ma_binh_luan]
    );
    message = 'Cập nhật trả lời thành công';
} else {
    // TẠO MỚI reply
    // ...
}
```

## Frontend UX

### 1. Mở Modal Trả lời

**Chưa có reply:**
```
┌─────────────────────────────┐
│ 🔄 Trả lời đánh giá    [X] │
├─────────────────────────────┤
│ Nội dung trả lời:          │
│ ┌─────────────────────────┐│
│ │ [Textarea trống]        ││
│ └─────────────────────────┘│
│ [📤 Gửi trả lời]  [Hủy]   │
└─────────────────────────────┘
```

**Đã có reply:**
```
┌─────────────────────────────┐
│ ✏️ Chỉnh sửa trả lời   [X] │
├─────────────────────────────┤
│ Nội dung trả lời:          │
│ ┌─────────────────────────┐│
│ │ Cảm ơn bạn đã đánh giá ││
│ │ [Nội dung reply cũ]    ││
│ └─────────────────────────┘│
│ [📤 Gửi trả lời]  [Hủy]   │
└─────────────────────────────┘
```

### 2. Thông báo sau khi Submit

- **Lần đầu**: "✅ Trả lời đánh giá thành công!"
- **Lần sau**: "✅ Cập nhật trả lời thành công!"

### 3. Modal Chi tiết

**Nút thay đổi theo trạng thái:**
- Chưa có reply: `[🔄 Trả lời]`
- Đã có reply: `[✏️ Chỉnh sửa]`

## Luồng hoạt động

### Trường hợp 1: Trả lời lần đầu

1. Admin click nút "Trả lời"
2. Modal mở với textarea trống
3. Title: "🔄 Trả lời đánh giá"
4. Admin nhập nội dung → Gửi
5. Backend tạo reply mới
6. Thông báo: "✅ Trả lời đánh giá thành công!"
7. Comment có badge "1 trả lời"

### Trường hợp 2: Chỉnh sửa reply

1. Admin click nút "Trả lời" (hoặc "Xem chi tiết" → "Chỉnh sửa")
2. Modal mở với nội dung reply cũ đã điền sẵn
3. Title: "✏️ Chỉnh sửa trả lời"
4. Admin sửa nội dung → Gửi
5. Backend cập nhật reply cũ (UPDATE)
6. Thông báo: "✅ Cập nhật trả lời thành công!"
7. Thời gian reply cập nhật thành NOW()

## Lợi ích

### 1. Quản lý đơn giản
- ✅ Mỗi comment chỉ có 1 reply duy nhất
- ✅ Không bị rối khi có nhiều reply
- ✅ Dễ theo dõi lịch sử chỉnh sửa

### 2. UX tốt hơn
- ✅ Admin biết rõ đang tạo mới hay chỉnh sửa
- ✅ Nội dung cũ được load sẵn để edit
- ✅ Thông báo rõ ràng

### 3. Database sạch
- ✅ Không tạo nhiều record không cần thiết
- ✅ Luôn có tối đa 1 reply per comment
- ✅ Dễ query và maintain

## Lịch sử chỉnh sửa

### Hiển thị thời gian

Reply hiển thị với thời gian cập nhật mới nhất:

```
┌─────────────────────────────────┐
│ 🛡️ Admin [Admin]               │
│ Cảm ơn bạn đã đánh giá!        │
│ 2 giờ trước (đã chỉnh sửa)     │
└─────────────────────────────────┘
```

### Trong database

- `ngay_tra_loi` / `ngay_binh_luan` được cập nhật thành NOW()
- Có thể thêm cột `ngay_chinh_sua` nếu muốn lưu lịch sử chi tiết

## Testing

### Test Case 1: Trả lời lần đầu
1. ✅ Tìm comment chưa có reply
2. ✅ Click "Trả lời"
3. ✅ Modal title: "Trả lời đánh giá"
4. ✅ Textarea trống
5. ✅ Nhập nội dung → Gửi
6. ✅ Thông báo: "Trả lời thành công"
7. ✅ Badge "1 trả lời" xuất hiện

### Test Case 2: Chỉnh sửa reply
1. ✅ Tìm comment đã có reply
2. ✅ Click "Trả lời" hoặc "Chỉnh sửa"
3. ✅ Modal title: "Chỉnh sửa trả lời"
4. ✅ Textarea có nội dung cũ
5. ✅ Sửa nội dung → Gửi
6. ✅ Thông báo: "Cập nhật thành công"
7. ✅ Nội dung reply được cập nhật

### Test Case 3: Kiểm tra database
1. ✅ Trả lời lần đầu → 1 record mới
2. ✅ Trả lời lần 2 → Vẫn 1 record (UPDATE)
3. ✅ Thời gian được cập nhật
4. ✅ Nội dung được thay thế

## API Response

### Trả lời lần đầu
```json
{
  "success": true,
  "message": "Trả lời đánh giá thành công",
  "data": {
    "ma_tra_loi": 123,
    "noi_dung": "Cảm ơn bạn!",
    "ten_admin": "Admin",
    "ngay_tra_loi": "2024-12-05T10:30:00.000Z",
    "is_update": false
  }
}
```

### Cập nhật reply
```json
{
  "success": true,
  "message": "Cập nhật trả lời thành công",
  "data": {
    "ma_tra_loi": 123,
    "noi_dung": "Cảm ơn bạn rất nhiều!",
    "ten_admin": "Admin",
    "ngay_tra_loi": "2024-12-05T12:45:00.000Z",
    "is_update": true
  }
}
```

## Kết luận

Hệ thống giờ hoạt động theo logic:
- ✅ **1 comment = 1 reply duy nhất**
- ✅ **Lần đầu = Tạo mới**
- ✅ **Lần sau = Cập nhật**
- ✅ **UI phân biệt rõ ràng**
- ✅ **Thông báo chính xác**
- ✅ **Database sạch sẽ**

Không còn tạo nhiều reply cho cùng 1 comment nữa! 🎉
