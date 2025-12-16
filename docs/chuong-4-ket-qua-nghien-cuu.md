# CHƯƠNG 4: KẾT QUẢ NGHIÊN CỨU

## 4.1. Tổng quan kết quả

Sau quá trình phân tích, thiết kế và triển khai, hệ thống Website Ẩm thực Phương Nam đã được hoàn thành với đầy đủ các chức năng theo yêu cầu đặt ra. Hệ thống bao gồm hai phần chính:

- **Giao diện người dùng (Frontend)**: Cho phép khách hàng xem thực đơn, đặt món, đặt bàn, thanh toán và quản lý tài khoản.
- **Giao diện quản trị (Admin)**: Cho phép quản trị viên quản lý toàn bộ hoạt động của nhà hàng.

### 4.1.1. Công nghệ sử dụng

| Thành phần | Công nghệ |
|------------|-----------|
| Backend | Node.js + Express.js |
| Database | MySQL 8.0 |
| Frontend | HTML5, TailwindCSS, JavaScript ES6+ |
| Authentication | JWT, Passport.js, Google OAuth 2.0 |
| Payment | MoMo Payment Gateway |
| AI/Chatbot | OpenAI API |

### 4.1.2. Thống kê hệ thống

- **Số bảng database**: 26 bảng
- **Số API endpoints**: 20+ routes
- **Số trang giao diện người dùng**: 18 trang
- **Số trang quản trị**: 15 trang

---

## 4.2. Giao diện người dùng (Customer Interface)

### 4.2.1. Trang chủ (index.html)

**Mô tả**: Trang chủ là điểm tiếp xúc đầu tiên với khách hàng, hiển thị banner quảng cáo, giới thiệu nhà hàng và các món ăn bán chạy nhất.

**Chức năng chính**:
- Banner slider tự động với hiệu ứng fade
- Hiển thị top 4 món ăn bán chạy nhất (load từ API)
- Giới thiệu về nhà hàng và đội ngũ nhân viên
- Các cam kết về chất lượng dịch vụ

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│  [Logo] Phương Nam          Trang chủ | Thực đơn | Đặt bàn | 🛒 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│     ╔═══════════════════════════════════════════════════════╗   │
│     ║           HƯƠNG VỊ PHƯƠNG NAM                         ║   │
│     ║   Đắm chìm trong không gian ẩm thực truyền thống      ║   │
│     ║              [ĐẶT BÀN NGAY]                           ║   │
│     ╚═══════════════════════════════════════════════════════╝   │
│                                                                 │
│  ┌─────────────────── VỀ CHÚNG TÔI ───────────────────┐        │
│  │  Ẩm thực Phương Nam – Ngon như mẹ nấu              │        │
│  │  Triết lý: chia sẻ hương vị và văn hóa cơm Việt    │        │
│  └────────────────────────────────────────────────────┘        │
│                                                                 │
│  ═══════════ TOP MÓN ĂN BÁN CHẠY NHẤT ═══════════              │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐                   │
│  │ [Ảnh]  │ │ [Ảnh]  │ │ [Ảnh]  │ │ [Ảnh]  │                   │
│  │ Món 1  │ │ Món 2  │ │ Món 3  │ │ Món 4  │                   │
│  │ ⭐⭐⭐⭐⭐│ │ ⭐⭐⭐⭐ │ │ ⭐⭐⭐⭐⭐│ │ ⭐⭐⭐⭐ │                   │
│  │ 85,000đ│ │ 70,000đ│ │ 80,000đ│ │ 45,000đ│                   │
│  │  [+]   │ │  [+]   │ │  [+]   │ │  [+]   │                   │
│  └────────┘ └────────┘ └────────┘ └────────┘                   │
│                                                                 │
│  ═══════════ UY TÍN & CHẤT LƯỢNG ═══════════                   │
│  🚚 Giao hàng nhanh | 🏆 Chất lượng | 📞 Hỗ trợ 24/7 | ↩️ Hoàn tiền│
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.2.2. Trang Thực đơn (thuc-don.html)

**Mô tả**: Hiển thị toàn bộ danh sách món ăn của nhà hàng với các tính năng lọc, tìm kiếm và sắp xếp.

**Chức năng chính**:
- Tìm kiếm món ăn theo tên
- Lọc theo danh mục (Canh & Súp, Hải sản, Thịt, Rau, Cơm, Đồ uống)
- Lọc theo khoảng giá
- Lọc theo đánh giá sao
- Sắp xếp: Phổ biến, Mới nhất, Giá tăng/giảm
- Phân trang kết quả
- Thêm vào giỏ hàng trực tiếp

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│                        THỰC ĐƠN                                 │
│                 Hương vị từ miền sông nước                      │
├─────────────────────────────────────────────────────────────────┤
│  🔍 [Tìm kiếm món ăn...                              ] [X]      │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌────────────────────────────────────────┐  │
│  │  BỘ LỌC      │  │ Sắp xếp: [Phổ biến][Mới nhất][Giá↑][Giá↓]│
│  │              │  │ Tìm thấy: 25 món ăn                     │
│  │ ☐ Tất cả     │  ├────────────────────────────────────────┤  │
│  │ ☐ Canh & Súp │  │ ┌────────┐ ┌────────┐ ┌────────┐      │  │
│  │ ☐ Hải sản    │  │ │ [Ảnh]  │ │ [Ảnh]  │ │ [Ảnh]  │      │  │
│  │ ☐ Thịt      │  │ │Tôm sốt │ │Cá nướng│ │Cơm tấm │      │  │
│  │ ☐ Rau       │  │ │mật ong │ │mỡ hành │ │sườn bì │      │  │
│  │ ☐ Cơm       │  │ │⭐⭐⭐⭐⭐  │ │⭐⭐⭐⭐   │ │⭐⭐⭐⭐⭐  │      │  │
│  │ ☐ Đồ uống   │  │ │85,000đ │ │70,000đ │ │45,000đ │      │  │
│  │              │  │ │  [+]   │ │  [+]   │ │  [+]   │      │  │
│  │ KHOẢNG GIÁ   │  │ └────────┘ └────────┘ └────────┘      │  │
│  │ ○ < 100k     │  │                                        │  │
│  │ ○ 100k-200k  │  │ ┌────────┐ ┌────────┐ ┌────────┐      │  │
│  │ ○ 200k-500k  │  │ │ [Ảnh]  │ │ [Ảnh]  │ │ [Ảnh]  │      │  │
│  │ ○ > 500k     │  │ │ Món 4  │ │ Món 5  │ │ Món 6  │      │  │
│  │              │  │ └────────┘ └────────┘ └────────┘      │  │
│  │ [Áp dụng]    │  │                                        │  │
│  │ [Đặt lại]    │  │      [1] [2] [3] ... [Tiếp]           │  │
│  └──────────────┘  └────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.2.3. Trang Chi tiết món ăn (chitietmonan.html)

**Mô tả**: Hiển thị thông tin chi tiết của một món ăn, bao gồm hình ảnh, mô tả, giá, đánh giá và các món liên quan.

**Chức năng chính**:
- Hiển thị gallery ảnh món ăn
- Thông tin chi tiết: tên, giá, mô tả, danh mục
- Đánh giá và bình luận từ khách hàng
- Chọn số lượng và thêm vào giỏ hàng
- Gợi ý món ăn tương tự

---

### 4.2.4. Trang Giỏ hàng (gio-hang.html)

**Mô tả**: Quản lý các món ăn đã chọn trước khi thanh toán.

**Chức năng chính**:
- Hiển thị danh sách món đã thêm
- Tăng/giảm số lượng từng món
- Xóa món khỏi giỏ hàng
- Áp dụng mã giảm giá
- Tính tổng tiền tự động
- Gợi ý món ăn kết hợp (ML-based pairing)

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│                        🛒 GIỎ HÀNG                              │
│              Xem lại và quản lý đơn hàng của bạn                │
├─────────────────────────────────────────────────────────────────┤
│  ┌────────────────────────────────┐  ┌──────────────────────┐  │
│  │ GIỎ HÀNG CỦA BẠN    [3 SP] [🗑]│  │ TÓM TẮT ĐƠN HÀNG     │  │
│  ├────────────────────────────────┤  │                      │  │
│  │ ┌─────┐ Tôm sốt mật ong       │  │ Mã giảm giá:         │  │
│  │ │[Ảnh]│ 85,000đ               │  │ [___________][Áp dụng]│  │
│  │ └─────┘ [-] 2 [+]    170,000đ │  │                      │  │
│  │                        [🗑]   │  │ ─────────────────────│  │
│  ├────────────────────────────────┤  │ 🛍 Tạm tính: 255,000đ│  │
│  │ ┌─────┐ Cá nướng mỡ hành      │  │ 🚚 Phí giao:  20,000đ│  │
│  │ │[Ảnh]│ 70,000đ               │  │ 🏷 Giảm giá:      -0đ│  │
│  │ └─────┘ [-] 1 [+]     70,000đ │  │ ─────────────────────│  │
│  │                        [🗑]   │  │ 💰 TỔNG:    275,000đ │  │
│  ├────────────────────────────────┤  │                      │  │
│  │ ┌─────┐ Cơm tấm sườn          │  │ [TIẾN HÀNH THANH TOÁN]│  │
│  │ │[Ảnh]│ 45,000đ               │  │ [← Tiếp tục mua sắm] │  │
│  │ └─────┘ [-] 1 [+]     45,000đ │  │                      │  │
│  │                        [🗑]   │  │ ✓ Thanh toán an toàn │  │
│  └────────────────────────────────┘  │ ✓ Giao hàng nhanh   │  │
│                                      │ ✓ Hoàn tiền 24h     │  │
│  🍽️ KẾT HỢP HOÀN HẢO                 └──────────────────────┘  │
│  ┌────────┐ ┌────────┐ ┌────────┐                              │
│  │ Gợi ý 1│ │ Gợi ý 2│ │ Gợi ý 3│                              │
│  └────────┘ └────────┘ └────────┘                              │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.2.5. Trang Thanh toán (thanh-toan.html)

**Mô tả**: Hoàn tất đơn hàng với thông tin giao hàng và phương thức thanh toán.

**Chức năng chính**:
- Nhập thông tin người nhận (tên, SĐT, địa chỉ)
- Chọn phương thức thanh toán:
  - Tiền mặt khi nhận hàng (COD)
  - Chuyển khoản ngân hàng
  - Thanh toán MoMo
- Ghi chú đơn hàng
- Xác nhận và đặt hàng

---

### 4.2.6. Trang Đặt bàn (dat-ban.html)

**Mô tả**: Cho phép khách hàng đặt bàn trước tại nhà hàng.

**Chức năng chính**:
- Nhập thông tin: họ tên, SĐT, email
- Chọn ngày và giờ đặt bàn
- Chọn số lượng khách
- Chọn khu vực (trong nhà, sân vườn, VIP)
- Ghi chú yêu cầu đặc biệt
- Validate: đặt trước ít nhất 3 tiếng

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│                        ĐẶT BÀN                                  │
│         Mời quý khách đặt bàn trước để có chỗ ngồi tốt          │
├─────────────────────────────────────────────────────────────────┤
│  ┌────────────────────────────┐  ┌────────────────────────────┐│
│  │ 📅 THÔNG TIN ĐẶT BÀN       │  │ ℹ️ THÔNG TIN NHÀ HÀNG      ││
│  │                            │  │                            ││
│  │ Họ và tên *                │  │ 📍 Địa chỉ:                ││
│  │ [_____________________]    │  │ 168 Ấp Phú Hòa, Long Đức   ││
│  │                            │  │                            ││
│  │ SĐT *        Email         │  │ 📞 Điện thoại:             ││
│  │ [________] [____________]  │  │ 0388 853 044               ││
│  │                            │  │                            ││
│  │ Ngày đặt *   Giờ đặt *     │  │ 🕐 Giờ mở cửa:             ││
│  │ [________] [________]      │  │ T2-T6: 08:00-22:00         ││
│  │                            │  │ T7-CN: 07:00-23:00         ││
│  │ Số lượng khách *           │  │                            ││
│  │ [▼ Chọn số lượng khách]    │  │ 📧 Email:                  ││
│  │                            │  │ amthucphuongnam@gmail.com  ││
│  │ Khu vực                    │  └────────────────────────────┘│
│  │ [▼ Chọn khu vực]           │                                │
│  │                            │  ┌────────────────────────────┐│
│  │ Ghi chú                    │  │ ⚠️ LƯU Ý KHI ĐẶT BÀN       ││
│  │ [_____________________]    │  │ ✓ Đặt trước ít nhất 3 tiếng││
│  │ [_____________________]    │  │ ✓ Bàn giữ trong 15 phút    ││
│  │                            │  │ ✓ Liên hệ nếu cần hủy/đổi  ││
│  │ [📅 XÁC NHẬN ĐẶT BÀN]      │  └────────────────────────────┘│
│  └────────────────────────────┘                                │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.2.7. Trang Đăng nhập / Đăng ký

**Mô tả**: Xác thực người dùng để truy cập các tính năng cá nhân.

**Chức năng chính**:
- Đăng nhập bằng email/mật khẩu
- Đăng nhập bằng Google OAuth 2.0
- Đăng ký tài khoản mới
- Quên mật khẩu (gửi email reset)
- Xác thực email

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│              [Logo] Phương Nam - Vĩnh Long                      │
│                                                                 │
│         ┌─────────────────────────────────────────┐             │
│         │           ĐĂNG NHẬP                     │             │
│         │       Chào mừng bạn trở lại!            │             │
│         │                                         │             │
│         │  Email                                  │             │
│         │  📧 [email@example.com          ]       │             │
│         │                                         │             │
│         │  Mật khẩu                               │             │
│         │  🔒 [••••••••••••••••••      ] 👁       │             │
│         │                                         │             │
│         │  ☐ Ghi nhớ đăng nhập    Quên mật khẩu? │             │
│         │                                         │             │
│         │  [      🔐 ĐĂNG NHẬP              ]     │             │
│         │                                         │             │
│         │  ─────── Hoặc đăng nhập với ───────    │             │
│         │                                         │             │
│         │  [  G  Đăng nhập với Google       ]     │             │
│         │                                         │             │
│         │  Chưa có tài khoản? Đăng ký ngay       │             │
│         └─────────────────────────────────────────┘             │
│                                                                 │
│                    ← Quay lại trang chủ                         │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.2.8. Trang Tài khoản (tai-khoan.html)

**Mô tả**: Quản lý thông tin cá nhân và lịch sử hoạt động của người dùng.

**Chức năng chính**:
- Xem và cập nhật thông tin cá nhân
- Đổi mật khẩu
- Xem lịch sử đơn hàng
- Xem lịch sử đặt bàn
- Quản lý thông báo

---

### 4.2.9. Các trang khác

| Trang | Mô tả |
|-------|-------|
| **Tin tức** (tin-tuc.html) | Hiển thị các bài viết, tin tức về nhà hàng |
| **Chi tiết tin tức** (tin-tuc-chi-tiet.html) | Nội dung chi tiết bài viết, bình luận, reactions |
| **Album ảnh** (album.html) | Gallery ảnh không gian, món ăn, sự kiện |
| **Giới thiệu** (gioi-thieu.html) | Thông tin về nhà hàng, lịch sử, đội ngũ |
| **Liên hệ** (lien-he.html) | Form liên hệ, bản đồ, thông tin liên lạc |
| **Đơn hàng của tôi** (don-hang-cua-toi.html) | Theo dõi trạng thái đơn hàng |

---

## 4.3. Giao diện quản trị (Admin Interface)

### 4.3.1. Dashboard (dashboard.html)

**Mô tả**: Trang tổng quan hiển thị các chỉ số KPI quan trọng của nhà hàng.

**Chức năng chính**:
- Thống kê doanh thu (ngày/tuần/tháng)
- Số đơn hàng mới
- Số đặt bàn chờ xác nhận
- Số khách hàng mới
- Biểu đồ doanh thu theo thời gian
- Biểu đồ món ăn bán chạy
- Thông báo hệ thống

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│ ┌──────────┐                                                    │
│ │ [Logo]   │  Dashboard                    🔔 [Avatar] Admin    │
│ │ Phương   │  Báo cáo tổng quan nhà hàng                        │
│ │ Nam      │────────────────────────────────────────────────────│
│ │          │                                                    │
│ │ MENU     │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐│
│ │ ─────────│  │💰 DOANH THU│ │📦 ĐƠN HÀNG│ │📅 ĐẶT BÀN │ │👥 KHÁCH││
│ │ 📊 Tổng quan│ │ 15,500,000đ│ │    45    │ │    12    │ │   156  ││
│ │ 🍽 Món ăn  │  │ ↑ 12.5%   │ │ ↑ 8.3%   │ │ ↑ 15.2%  │ │ ↑ 5.1% ││
│ │ 🛒 Đơn hàng│  └──────────┘ └──────────┘ └──────────┘ └────────┘│
│ │ 📅 Đặt bàn │                                                   │
│ │ 👥 Khách hàng│ ┌─────────────────────────────────────────────┐ │
│ │ 📧 Liên hệ │  │         BIỂU ĐỒ DOANH THU THÁNG             │ │
│ │ 🤖 Chatbot │  │    📈                                        │ │
│ │ ⭐ Đánh giá │  │         ╱╲    ╱╲                            │ │
│ │          │  │    ╱╲  ╱  ╲  ╱  ╲                           │ │
│ │ NỘI DUNG │  │   ╱  ╲╱    ╲╱    ╲                          │ │
│ │ ─────────│  │  ╱                  ╲                        │ │
│ │ 📰 Tin tức │  │ ─────────────────────────────────────────── │ │
│ │ 💬 Bình luận│  │ T1  T2  T3  T4  T5  T6  T7  T8  T9  T10    │ │
│ │ 📷 Album  │  └─────────────────────────────────────────────┘ │
│ │          │                                                    │
│ │ HỆ THỐNG │  ┌─────────────────┐ ┌─────────────────────────┐  │
│ │ ─────────│  │ TOP MÓN BÁN CHẠY │ │ ĐƠN HÀNG GẦN ĐÂY        │  │
│ │ ⚙ Cài đặt │  │ 1. Tôm sốt mật ong│ │ #DH001 - Đang giao     │  │
│ │          │  │ 2. Cá nướng      │ │ #DH002 - Chờ xác nhận  │  │
│ │ [Đăng xuất]│ │ 3. Cơm tấm       │ │ #DH003 - Hoàn thành    │  │
│ └──────────┘  └─────────────────┘ └─────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.3.2. Quản lý Món ăn (products.html)

**Mô tả**: Quản lý toàn bộ thực đơn của nhà hàng.

**Chức năng chính**:
- Xem danh sách món ăn dạng grid
- Tìm kiếm và lọc theo danh mục, trạng thái
- Thêm món ăn mới (tên, giá, mô tả, ảnh, danh mục)
- Sửa thông tin món ăn
- Xóa món ăn
- Quản lý số lượng tồn kho
- Ẩn/hiện món ăn

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│  Quản lý Món ăn                              [+ Thêm món mới]   │
│  Quản lý thực đơn nhà hàng                                      │
├─────────────────────────────────────────────────────────────────┤
│  🔍 [Tìm kiếm món ăn...] [▼ Danh mục] [▼ Trạng thái] [Lọc]     │
├─────────────────────────────────────────────────────────────────┤
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐   │
│  │   [Ảnh]    │ │   [Ảnh]    │ │   [Ảnh]    │ │   [Ảnh]    │   │
│  │ Tôm sốt    │ │ Cá nướng   │ │ Cơm tấm    │ │ Lẩu mắm    │   │
│  │ mật ong    │ │ mỡ hành    │ │ sườn bì    │ │ miền Tây   │   │
│  │ 85,000đ    │ │ 70,000đ    │ │ 45,000đ    │ │ 250,000đ   │   │
│  │ SL: 50     │ │ SL: 30     │ │ SL: 100    │ │ SL: 20     │   │
│  │ [Còn hàng] │ │ [Còn hàng] │ │ [Còn hàng] │ │ [Hết hàng] │   │
│  │ [✏️] [🗑️]  │ │ [✏️] [🗑️]  │ │ [✏️] [🗑️]  │ │ [✏️] [🗑️]  │   │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘   │
│                                                                 │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐   │
│  │   [Ảnh]    │ │   [Ảnh]    │ │   [Ảnh]    │ │   [Ảnh]    │   │
│  │ Chè ba màu │ │ Gỏi cuốn   │ │ Bánh xèo   │ │ Hủ tiếu    │   │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.3.3. Quản lý Đơn hàng (orders.html)

**Mô tả**: Theo dõi và xử lý các đơn hàng từ khách hàng.

**Chức năng chính**:
- Thống kê nhanh: Chờ xác nhận, Đang xử lý, Đang giao, Hoàn thành
- Tìm kiếm theo mã đơn, tên khách hàng
- Lọc theo trạng thái, thanh toán, ngày
- Xem chi tiết đơn hàng
- Cập nhật trạng thái đơn hàng
- In hóa đơn

**Giao diện minh họa**:

```
┌─────────────────────────────────────────────────────────────────┐
│  Quản lý Đơn hàng                                               │
│  Theo dõi và xử lý đơn hàng                                     │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐           │
│  │⏰ Chờ XN  │ │🔄 Đang XL │ │🚚 Đang giao│ │✅ Hoàn thành│          │
│  │    5     │ │    3     │ │    2     │ │    45    │           │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘           │
├─────────────────────────────────────────────────────────────────┤
│  🔍 [Tìm mã đơn, khách hàng...] [▼ Trạng thái] [▼ TT] [📅] [Lọc]│
├─────────────────────────────────────────────────────────────────┤
│  │ Mã đơn    │ Khách hàng  │ Ngày đặt   │ Tổng tiền │ TT  │ Trạng thái │
│  ├───────────┼─────────────┼────────────┼───────────┼─────┼────────────┤
│  │ #DH000066 │ Nguyễn Văn A│ 15/12/2025 │ 170,000đ  │ ✓   │ [⏰][✓][🍳][🚚][✅] │
│  │ #DH000065 │ Trần Thị B  │ 15/12/2025 │ 255,000đ  │ ⏳  │ [⏰][✓][🍳][🚚][✅] │
│  │ #DH000064 │ Lê Văn C    │ 14/12/2025 │ 85,000đ   │ ✓   │ [⏰][✓][🍳][🚚][✅] │
│  │ #DH000063 │ Phạm Thị D  │ 14/12/2025 │ 320,000đ  │ ✓   │ [⏰][✓][🍳][🚚][✅] │
└─────────────────────────────────────────────────────────────────┘
```

---

### 4.3.4. Quản lý Đặt bàn (reservations.html)

**Mô tả**: Quản lý các yêu cầu đặt bàn từ khách hàng.

**Chức năng chính**:
- Xem danh sách đặt bàn
- Lọc theo ngày, trạng thái
- Xác nhận/Từ chối đặt bàn
- Xem chi tiết thông tin đặt bàn
- Ghi chú cho nhân viên

---

### 4.3.5. Quản lý Khách hàng (customers.html)

**Mô tả**: Quản lý thông tin khách hàng đã đăng ký.

**Chức năng chính**:
- Danh sách khách hàng
- Tìm kiếm theo tên, email, SĐT
- Xem lịch sử đơn hàng của khách
- Khóa/Mở khóa tài khoản
- Thống kê khách hàng VIP

---

### 4.3.6. Các trang quản trị khác

| Trang | Mô tả |
|-------|-------|
| **Liên hệ** (contacts.html) | Quản lý tin nhắn liên hệ từ khách hàng |
| **Lịch sử Chatbot** (chatbot-history.html) | Xem lịch sử hội thoại với AI chatbot |
| **Đánh giá** (reviews.html) | Quản lý đánh giá món ăn từ khách hàng |
| **Tin tức** (news.html) | Quản lý bài viết, tin tức |
| **Bình luận tin tức** (quan-ly-binh-luan.html) | Duyệt và quản lý bình luận |
| **Reactions tin tức** (quan-ly-danh-gia-tin-tuc.html) | Thống kê reactions (like, love, wow...) |
| **Album ảnh** (albums.html) | Quản lý gallery ảnh nhà hàng |
| **Cài đặt** (settings.html) | Cấu hình thông tin nhà hàng, thanh toán |

---

## 4.4. Tính năng nổi bật

### 4.4.1. Chatbot AI

Hệ thống tích hợp chatbot sử dụng OpenAI API để hỗ trợ khách hàng:
- Tư vấn món ăn phù hợp
- Trả lời câu hỏi về nhà hàng
- Hỗ trợ đặt bàn, đặt món
- Giải đáp thắc mắc 24/7

### 4.4.2. Hệ thống gợi ý thông minh (ML-based Recommendation)

- Gợi ý món ăn dựa trên lịch sử mua hàng
- Gợi ý món kết hợp (pairing) khi thêm vào giỏ hàng
- Hiển thị món ăn phổ biến, bán chạy

### 4.4.3. Thanh toán đa dạng

- Tiền mặt khi nhận hàng (COD)
- Chuyển khoản ngân hàng
- Thanh toán qua MoMo (tích hợp API)

### 4.4.4. Hệ thống thông báo

- Thông báo realtime cho admin (đơn hàng mới, đặt bàn mới)
- Thông báo cho khách hàng (trạng thái đơn hàng, khuyến mãi)
- Email notification

### 4.4.5. Responsive Design

Giao diện được thiết kế responsive, hoạt động tốt trên:
- Desktop (1920px+)
- Laptop (1024px - 1919px)
- Tablet (768px - 1023px)
- Mobile (< 768px)

---

## 4.5. Đánh giá và so sánh

### 4.5.1. Đánh giá hiệu năng

| Tiêu chí | Kết quả | Đánh giá |
|----------|---------|----------|
| Thời gian tải trang | < 2 giây | Tốt |
| Thời gian phản hồi API | < 500ms | Tốt |
| Hỗ trợ đồng thời | 100+ users | Đạt yêu cầu |
| Tương thích trình duyệt | Chrome, Firefox, Safari, Edge | Tốt |
| Responsive | Mobile, Tablet, Desktop | Hoàn chỉnh |

### 4.5.2. So sánh với các hệ thống tương tự

| Tính năng | Hệ thống này | Website nhà hàng thông thường |
|-----------|--------------|-------------------------------|
| Đặt món online | ✅ | ✅ |
| Đặt bàn online | ✅ | ✅/❌ |
| Thanh toán MoMo | ✅ | ❌ |
| Chatbot AI | ✅ | ❌ |
| Gợi ý món ăn ML | ✅ | ❌ |
| Đăng nhập Google | ✅ | ❌ |
| Hệ thống đánh giá | ✅ | ✅/❌ |
| Thông báo realtime | ✅ | ❌ |
| Quản lý tin tức | ✅ | ✅/❌ |
| Album ảnh | ✅ | ✅ |

### 4.5.3. Ưu điểm của hệ thống

1. **Giao diện hiện đại**: Sử dụng TailwindCSS với thiết kế đẹp mắt, thân thiện người dùng
2. **Tích hợp AI**: Chatbot thông minh hỗ trợ khách hàng 24/7
3. **Thanh toán đa dạng**: Hỗ trợ nhiều phương thức thanh toán
4. **Responsive hoàn chỉnh**: Hoạt động tốt trên mọi thiết bị
5. **Quản trị mạnh mẽ**: Dashboard trực quan với đầy đủ thống kê
6. **Bảo mật**: JWT authentication, Google OAuth 2.0

### 4.5.4. Hạn chế và hướng phát triển

**Hạn chế hiện tại**:
- Chưa có ứng dụng mobile native
- Chưa tích hợp nhiều cổng thanh toán (VNPay, ZaloPay)
- Chưa có tính năng loyalty/điểm thưởng

**Hướng phát triển**:
- Phát triển ứng dụng mobile (React Native/Flutter)
- Tích hợp thêm cổng thanh toán
- Xây dựng chương trình khách hàng thân thiết
- Tối ưu SEO cho website
- Tích hợp Google Analytics để phân tích hành vi người dùng

---

## 4.6. Kết luận chương

Chương 4 đã trình bày chi tiết kết quả đạt được sau quá trình phân tích, thiết kế và triển khai hệ thống Website Ẩm thực Phương Nam. Hệ thống đã hoàn thành đầy đủ các chức năng theo yêu cầu đặt ra, bao gồm:

- **18 trang giao diện người dùng** với đầy đủ tính năng: xem thực đơn, đặt món, đặt bàn, thanh toán, quản lý tài khoản
- **15 trang quản trị** cho phép quản lý toàn diện hoạt động nhà hàng
- **Tích hợp công nghệ hiện đại**: AI Chatbot, ML Recommendation, OAuth 2.0, MoMo Payment
- **Thiết kế responsive** hoạt động tốt trên mọi thiết bị

Hệ thống đã được kiểm thử và đánh giá đạt yêu cầu về hiệu năng, bảo mật và trải nghiệm người dùng. So với các website nhà hàng thông thường, hệ thống có nhiều tính năng vượt trội như chatbot AI, gợi ý món ăn thông minh và thanh toán điện tử.
