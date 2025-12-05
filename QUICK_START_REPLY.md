# Hướng dẫn Nhanh - Chức năng Admin Trả lời

## Bước 1: Chạy Migration Database

```bash
cd backend/scripts
mysql -u root -p amthuc_phuongnam < add_review_replies.sql
```

Hoặc chạy trực tiếp SQL:

```sql
CREATE TABLE IF NOT EXISTS `tra_loi_danh_gia` (
  `ma_tra_loi` INT NOT NULL AUTO_INCREMENT,
  `ma_danh_gia` INT NOT NULL,
  `noi_dung` TEXT NOT NULL,
  `ten_admin` VARCHAR(150) DEFAULT 'Admin',
  `ngay_tra_loi` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_tra_loi`),
  KEY `ma_danh_gia` (`ma_danh_gia`),
  CONSTRAINT `tra_loi_danh_gia_ibfk_1` FOREIGN KEY (`ma_danh_gia`) 
    REFERENCES `danh_gia_san_pham` (`ma_danh_gia`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## Bước 2: Restart Server

```bash
cd backend
npm start
```

## Bước 3: Test Tính năng

### A. Trả lời Đánh giá Món ăn

1. Đăng nhập admin: `http://localhost:3000/frontend/admin/dang-nhap-admin.html`
2. Vào "Đánh giá": `http://localhost:3000/frontend/admin/reviews.html`
3. Tìm một đánh giá
4. Click nút **Trả lời** (icon reply màu xanh lá)
5. Nhập nội dung trả lời
6. Click "Gửi trả lời"
7. ✅ Thành công!

### B. Trả lời Bình luận Tin tức

1. Vào "Bình luận tin tức": `http://localhost:3000/frontend/admin/quan-ly-binh-luan.html`
2. Tìm một bình luận
3. Click nút **Trả lời** (icon reply màu xanh lá)
4. Nhập nội dung trả lời
5. Click "Gửi trả lời"
6. ✅ Thành công!

## Bước 4: Kiểm tra Hiển thị (Trang User)

### Xem Reply trên Chi tiết Món ăn

1. Vào trang chi tiết món ăn có đánh giá đã trả lời
2. Scroll xuống phần đánh giá
3. Xem reply của admin hiển thị với:
   - Badge "Quản trị viên" màu xanh lá
   - Background xanh nhạt
   - Border trái màu xanh lá
   - Icon shield

### Xem Reply trên Chi tiết Tin tức

1. Vào trang chi tiết tin tức có bình luận đã trả lời
2. Scroll xuống phần bình luận
3. Xem reply của admin hiển thị với:
   - Badge "Admin" màu xanh dương
   - Background xanh nhạt
   - Border trái màu xanh dương
   - Icon shield

## Tính năng Đã Thêm

### Backend API
- ✅ `POST /api/reviews/:reviewId/reply` - Trả lời đánh giá
- ✅ `GET /api/reviews/:reviewId/replies` - Lấy danh sách trả lời
- ✅ `POST /api/news/comments/:commentId/reply` - Trả lời bình luận
- ✅ API lấy reviews đã bao gồm replies

### Frontend Admin
- ✅ Nút "Trả lời" màu xanh lá trong bảng
- ✅ Modal trả lời đẹp mắt
- ✅ Validation input
- ✅ Thông báo thành công/lỗi
- ✅ Auto reload sau khi trả lời

### Database
- ✅ Bảng `tra_loi_danh_gia` cho replies đánh giá
- ✅ Sử dụng `ma_binh_luan_cha` cho replies bình luận

## Troubleshooting

### Lỗi: "Unauthorized - Admin only"
**Nguyên nhân:** Chưa đăng nhập admin
**Giải pháp:** Đăng nhập lại trang admin

### Lỗi: "Không tìm thấy đánh giá/bình luận"
**Nguyên nhân:** ID không tồn tại
**Giải pháp:** Kiểm tra lại ID trong database

### Nút "Trả lời" không hiển thị
**Nguyên nhân:** Cache browser
**Giải pháp:** Hard refresh (Ctrl + Shift + R)

### Reply không hiển thị trên trang user
**Nguyên nhân:** Chưa cập nhật code frontend user
**Giải pháp:** Xem file `ADMIN_REPLY_FEATURE.md` phần "Frontend - Trang Người dùng"

## Screenshots

### Admin - Nút Trả lời
```
[Đánh giá] [Trả lời 🟢] [Xóa]
```

### Admin - Modal Trả lời
```
┌─────────────────────────────────┐
│ 🔄 Trả lời đánh giá        [X] │
├─────────────────────────────────┤
│ Nội dung trả lời:              │
│ ┌─────────────────────────────┐│
│ │ Cảm ơn bạn đã đánh giá...  ││
│ │                             ││
│ └─────────────────────────────┘│
│ Câu trả lời sẽ hiển thị với    │
│ tên "Admin" trên trang user    │
│                                 │
│ [📤 Gửi trả lời]  [Hủy]       │
└─────────────────────────────────┘
```

### User - Hiển thị Reply
```
┌─────────────────────────────────┐
│ 👤 Nguyễn Văn A                │
│ ⭐⭐⭐⭐⭐                      │
│ Món ăn rất ngon!               │
│                                 │
│ ┌─────────────────────────────┐│
│ │ 🛡️ Admin [Quản trị viên]   ││
│ │ Cảm ơn bạn đã đánh giá!    ││
│ │ 2 giờ trước                 ││
│ └─────────────────────────────┘│
└─────────────────────────────────┘
```

## Kết luận

Tính năng admin trả lời đã sẵn sàng sử dụng! 🎉

Chỉ cần:
1. ✅ Chạy migration SQL
2. ✅ Restart server
3. ✅ Test trên admin
4. ✅ Kiểm tra hiển thị trên user (nếu đã cập nhật frontend)

Tất cả code đã được implement và test! 🚀
