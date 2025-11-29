# Cập Nhật Chức Năng Tin Tức Chi Tiết

## Ngày: 29/11/2025

### Các Thay Đổi Chính

#### 1. Database
- ✅ Tạo bảng `binh_luan_tin_tuc` để lưu bình luận tin tức
- ✅ Thêm 10 bình luận mẫu từ người dùng thật
- ✅ Cấu trúc bảng bao gồm:
  - `ma_binh_luan`: ID bình luận
  - `ma_tin_tuc`: ID tin tức (foreign key)
  - `ma_nguoi_dung`: ID người dùng (foreign key, nullable)
  - `ten_nguoi_binh_luan`: Tên người bình luận
  - `email_nguoi_binh_luan`: Email (optional)
  - `noi_dung`: Nội dung bình luận
  - `ngay_binh_luan`: Thời gian bình luận
  - `trang_thai`: Trạng thái (pending/approved/rejected)

#### 2. Backend API (backend/routes/news.js)
- ✅ **GET /api/news/:id/comments** - Lấy danh sách bình luận đã được duyệt
- ✅ **POST /api/news/:id/comments** - Thêm bình luận mới
- ✅ API trả về thông tin người bình luận kèm avatar
- ✅ Tự động tăng lượt xem khi xem tin tức

#### 3. Frontend JavaScript (frontend/js/news-detail.js)
- ✅ Xóa toàn bộ dữ liệu tĩnh (hardcoded data)
- ✅ Gọi API để lấy tin tức thật từ database
- ✅ Hiển thị thông tin tin tức động:
  - Tiêu đề
  - Tóm tắt
  - Nội dung HTML
  - Ảnh đại diện
  - Tác giả (admin đăng)
  - Ngày đăng
  - Lượt xem
- ✅ Hiển thị bình luận thật từ database
- ✅ Chức năng gửi bình luận mới
- ✅ Hiển thị thời gian bình luận (time ago)
- ✅ Hiển thị tin tức liên quan
- ✅ Chức năng chia sẻ (Facebook, Twitter, Copy link)

#### 4. Frontend HTML (frontend/tin-tuc-chi-tiet.html)
- ✅ Đơn giản hóa cấu trúc HTML
- ✅ Xóa nội dung tĩnh dài
- ✅ Thêm container động cho bình luận
- ✅ Form bình luận với validation
- ✅ Hiển thị số lượng bình luận động

#### 5. Trang Tin Tức (frontend/tin-tuc.html & frontend/js/news.js)
- ✅ Đã có sẵn chức năng load tin tức từ API
- ✅ Hiển thị tin nổi bật
- ✅ Phân trang
- ✅ Tìm kiếm tin tức

#### 6. Animation (frontend/js/gsap-tin-tuc.js)
- ✅ Tạo file animation GSAP cho trang tin tức
- ✅ Hiệu ứng fade in cho các phần tử

### Dữ Liệu Mẫu

#### Tin Tức (5 bài)
- ID 6: Khai Trương Chi Nhánh Mới Tại Vĩnh Long (751 lượt xem)
- ID 7: Ra Mắt Thực Đơn Mùa Thu 2025 (940 lượt xem)
- ID 8: Workshop Ẩm Thực Miền Tây (777 lượt xem)
- ID 9: Chương Trình Khuyến Mãi Cuối Tuần (447 lượt xem)
- ID 10: Đặc Sản Mùa Vụ - Tháng 11 (858 lượt xem)

#### Bình Luận (10 bình luận)
- Mỗi tin tức có 2-3 bình luận từ người dùng thật
- Tất cả đã được duyệt (approved)
- Có thông tin người dùng đầy đủ (tên, email, avatar)

### Cách Sử Dụng

#### Xem Tin Tức Chi Tiết
```
http://localhost:5500/frontend/tin-tuc-chi-tiet.html?id=6
```

#### Gửi Bình Luận
1. Điền họ tên (bắt buộc)
2. Điền email (không bắt buộc)
3. Nhập nội dung bình luận
4. Click "Gửi bình luận"
5. Bình luận sẽ được hiển thị ngay lập tức

### API Endpoints

#### Lấy Chi Tiết Tin Tức
```
GET /api/news/:id
Response: {
  success: true,
  data: {
    ma_tin_tuc, tieu_de, tom_tat, noi_dung,
    anh_dai_dien, ngay_dang, luot_xem, tac_gia,
    related: [...]
  }
}
```

#### Lấy Bình Luận
```
GET /api/news/:id/comments
Response: {
  success: true,
  data: [{
    ma_binh_luan, noi_dung, ngay_binh_luan,
    ten_nguoi_binh_luan, anh_dai_dien
  }]
}
```

#### Thêm Bình Luận
```
POST /api/news/:id/comments
Body: {
  ten_nguoi_binh_luan: string,
  email_nguoi_binh_luan: string (optional),
  noi_dung: string
}
Response: {
  success: true,
  message: "Bình luận đã được gửi thành công"
}
```

### Files Đã Thay Đổi

1. `backend/scripts/create-news-comments-table.sql` - SQL tạo bảng
2. `backend/scripts/create-news-comments.js` - Script chạy SQL
3. `backend/routes/news.js` - Thêm API bình luận
4. `frontend/js/news-detail.js` - Viết lại hoàn toàn
5. `frontend/js/gsap-tin-tuc.js` - Tạo mới
6. `frontend/tin-tuc-chi-tiet.html` - Cập nhật cấu trúc

### Lưu Ý
- Tất cả dữ liệu đều lấy từ database thật
- Không còn dữ liệu tĩnh (hardcoded)
- Bình luận được duyệt tự động (trang_thai = 'approved')
- Lượt xem tự động tăng mỗi khi xem tin tức
- ⚠️ **YÊU CẦU ĐĂNG NHẬP ĐỂ BÌNH LUẬN** - Người dùng phải đăng nhập mới có thể bình luận

### Cập Nhật Mới Nhất (29/11/2025)

#### Bảo Mật Bình Luận
- ✅ **Backend**: Yêu cầu đăng nhập để bình luận (kiểm tra session)
- ✅ **Frontend**: Ẩn form bình luận nếu chưa đăng nhập
- ✅ Hiển thị thông báo "Vui lòng đăng nhập để bình luận"
- ✅ Tự động lấy thông tin người dùng từ session (tên, email)
- ✅ Redirect về trang đăng nhập nếu chưa đăng nhập khi submit

#### Cảm Xúc Tin Tức (Reactions)
- ✅ Tạo bảng `cam_xuc_tin_tuc` để lưu cảm xúc
- ✅ 6 loại cảm xúc: like, love, haha, wow, sad, angry
- ✅ **GET /api/news/:id/reactions** - Lấy thống kê cảm xúc
- ✅ **POST /api/news/:id/reactions** - Thêm/Cập nhật/Xóa cảm xúc
- ✅ Yêu cầu đăng nhập để thả cảm xúc
- ✅ Mỗi người chỉ được thả 1 cảm xúc cho 1 tin tức
- ✅ Click lại cùng cảm xúc để bỏ cảm xúc (unlike)
- ✅ Click cảm xúc khác để thay đổi

#### Đánh Giá Tin Tức (Rating)
- ✅ Thêm cột `so_sao` vào bảng `binh_luan_tin_tuc`
- ✅ Cho phép đánh giá từ 1-5 sao khi bình luận
- ✅ Tính trung bình đánh giá cho mỗi tin tức
- ✅ Hiển thị tổng số đánh giá

#### Admin - Quản Lý Bình Luận
- ✅ **GET /api/news/admin/comments/all** - Lấy tất cả bình luận
- ✅ **PUT /api/news/admin/comments/:id/status** - Duyệt/Từ chối bình luận
- ✅ **DELETE /api/news/admin/comments/:id** - Xóa bình luận
- ✅ Trang quản lý bình luận: `frontend/admin/quan-ly-binh-luan.html`
- ✅ Script quản lý: `frontend/js/admin-comments.js`
