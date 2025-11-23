# THÔNG TIN DỰ ÁN WEBSITE ẨM THỰC PHƯƠNG NAM

## 1. TỔNG QUAN DỰ ÁN

**Tên dự án:** Website Nhà hàng Ẩm Thực Phương Nam Vĩnh Long  
**Công nghệ:** Full-stack Web Application  
**Kiến trúc:** Client-Server Architecture (Frontend-Backend tách biệt)  
**Database:** MySQL (amthuc_phuongnam)  
**Mục đích:** Hệ thống quản lý nhà hàng trực tuyến với đầy đủ chức năng đặt món, giỏ hàng, thanh toán, và quản trị nội dung

---

## 2. THÀNH PHẦN VÀ CÁC MODULE CHO WEBSITE

### 2.1. FRONTEND (Giao diện người dùng)

#### **A. Công nghệ sử dụng:**
- **HTML5** - Cấu trúc trang web
- **CSS3** + **TailwindCSS** - Styling và responsive design
- **JavaScript (ES6+)** - Logic xử lý phía client
- **GSAP (GreenSock Animation Platform)** - Hiệu ứng animation
- **Swiper.js** - Slider/Carousel
- **Font Awesome** - Icon library

#### **B. Các trang chính:**

##### **1. Trang khách hàng (Customer Pages):**
- `index.html` - Trang chủ
- `gioi-thieu.html` - Giới thiệu nhà hàng
- `thuc-don.html` - Thực đơn món ăn
- `chitietmonan.html` - Chi tiết món ăn
- `album.html` - Album ảnh nhà hàng
- `tin-tuc.html` - Trang tin tức
- `tin-tuc-chi-tiet.html` - Chi tiết bài viết
- `dat-ban.html` - Đặt bàn
- `gio-hang.html` - Giỏ hàng
- `thanh-toan.html` - Thanh toán
- `lien-he.html` - Liên hệ

##### **2. Trang xác thực (Authentication Pages):**
- `dang-ky.html` - Đăng ký tài khoản
- `dang-nhap.html` - Đăng nhập
- `quen-mat-khau.html` - Quên mật khẩu
- `dat-lai-mat-khau.html` - Đặt lại mật khẩu
- `xac-thuc-email.html` - Xác thực email

##### **3. Trang Admin:**
- `admin/dang-nhap-admin.html` - Đăng nhập admin
- `admin/index.html` - Dashboard admin
- `admin/index1.html` - Dashboard admin phiên bản 2

#### **C. Components (Thành phần tái sử dụng):**

**Vị trí:** `frontend/components/`

1. **navbar.html** - Thanh điều hướng chính
2. **footer.html** - Footer website
3. **chatbot.html** - Chatbot hỗ trợ khách hàng
4. **admin-login-modal.html** - Modal đăng nhập admin

#### **D. JavaScript Modules:**

**Vị trí:** `frontend/js/`

##### **Modules chính:**

1. **auth.js** - Xử lý xác thực người dùng
   - Đăng ký, đăng nhập, đăng xuất
   - Quản lý JWT token
   - Xác thực email
   - Quên/đặt lại mật khẩu

2. **cart.js** - Quản lý giỏ hàng
   - Class `CartManager`
   - Thêm/xóa/cập nhật sản phẩm
   - Tính tổng tiền
   - Đồng bộ với backend

3. **menu.js** - Hiển thị thực đơn
   - Load danh sách món ăn
   - Lọc theo danh mục
   - Tìm kiếm món ăn

4. **product-detail.js** - Chi tiết món ăn
   - Hiển thị thông tin chi tiết
   - Thêm vào giỏ hàng
   - Gallery ảnh sản phẩm

5. **checkout.js** - Xử lý thanh toán
   - Form thông tin giao hàng
   - Tính phí ship
   - Tạo đơn hàng

6. **album.js** - Quản lý album ảnh
   - Hiển thị gallery
   - Lightbox effect

7. **news.js** - Hiển thị tin tức
   - Danh sách bài viết
   - Phân trang

8. **news-detail.js** - Chi tiết tin tức
   - Hiển thị nội dung bài viết
   - Bài viết liên quan

9. **main.js** - Chức năng chung
   - Khởi tạo ứng dụng
   - Utilities functions

10. **load-components.js** - Load components động
    - Tải navbar, footer, chatbot

##### **GSAP Animation Modules:**

11. **gsap-animations.js** - Animation chung
12. **gsap-auth.js** - Animation trang đăng nhập/đăng ký
13. **gsap-gio-hang.js** - Animation giỏ hàng
14. **gsap-gioi-thieu.js** - Animation trang giới thiệu
15. **gsap-product-detail.js** - Animation chi tiết sản phẩm
16. **gsap-thuc-don.js** - Animation trang thực đơn

##### **Component JavaScript:**

**Vị trí:** `frontend/js/components/`

- **navbar.js** - Logic navbar
- **footer.js** - Logic footer
- **chatbot.js** - Chatbot functionality
- **product-card.js** - Card sản phẩm
- **ui-components.js** - UI components chung
- **forms-ui.js** - Form components
- **sections.js** - Section components
- **advanced.js** - Advanced features

#### **E. CSS Styling:**

**Vị trí:** `frontend/css/`

1. **styles.css** - Styles tùy chỉnh chính
2. **modern-style.css** - Modern UI styles
3. **tailwind.css** - TailwindCSS custom config

---

## 3. THÀNH PHẦN VÀ CÁC MODULE CHO HỆ THỐNG (BACKEND)

### 3.1. BACKEND (Node.js + Express)

#### **A. Công nghệ sử dụng:**
- **Node.js** v14+ - Runtime environment
- **Express.js** v4.18+ - Web framework
- **MySQL2** v3.6+ - Database driver (với Promise support)
- **bcryptjs** v2.4+ - Mã hóa mật khẩu
- **jsonwebtoken** v9.0+ - JWT authentication
- **nodemailer** v7.0+ - Gửi email
- **passport** v0.7+ - Authentication middleware
- **passport-google-oauth20** v2.0+ - Google OAuth
- **multer** v1.4+ - Upload file
- **express-session** v1.18+ - Session management
- **dotenv** v16.3+ - Environment variables
- **cors** v2.8+ - Cross-Origin Resource Sharing
- **nodemon** v3.0+ (dev) - Auto-restart server

#### **B. Cấu trúc Backend:**

**File chính:**
- **server.js** - Entry point, khởi tạo Express server

#### **C. Configuration Modules:**

**Vị trí:** `backend/config/`

1. **database.js** - Cấu hình kết nối MySQL
   - Connection pool
   - Promise wrapper
   - Error handling

2. **passport.js** - Cấu hình Passport authentication
   - Google OAuth 2.0 strategy
   - Session serialization

3. **email.js** - Cấu hình email service
   - Nodemailer setup
   - Email templates
   - Verification emails
   - Welcome emails
   - Password reset emails

#### **D. API Routes (RESTful APIs):**

**Vị trí:** `backend/routes/`

##### **1. auth.js - Authentication API**

**Endpoints:**
- `POST /api/auth/send-verification` - Gửi mã xác thực email
- `POST /api/auth/verify-email` - Xác thực email và hoàn tất đăng ký
- `POST /api/auth/resend-verification` - Gửi lại mã xác thực
- `POST /api/auth/login` - Đăng nhập
- `GET /api/auth/me` - Lấy thông tin user hiện tại
- `PUT /api/auth/update` - Cập nhật thông tin user
- `POST /api/auth/change-password` - Đổi mật khẩu
- `POST /api/auth/forgot-password` - Quên mật khẩu
- `POST /api/auth/verify-reset-code` - Xác thực mã reset
- `POST /api/auth/reset-password` - Đặt lại mật khẩu
- `POST /api/auth/upload-avatar` - Upload ảnh đại diện

**Chức năng:**
- Validation (email, phone, password)
- Mã hóa mật khẩu với bcrypt
- JWT token generation
- Email verification với 6-digit code
- Multer file upload
- Middleware: `authenticateToken()`

##### **2. admin-auth.js - Admin Authentication API**

**Endpoints:**
- `POST /api/admin-auth/login` - Đăng nhập admin
- `GET /api/admin-auth/me` - Thông tin admin hiện tại
- `POST /api/admin-auth/logout` - Đăng xuất admin

**Chức năng:**
- Admin authentication
- Role-based access control
- Session management

##### **3. menu.js - Menu/Product API**

**Endpoints:**
- `GET /api/menu` - Lấy tất cả món ăn
- `GET /api/menu/:id` - Lấy chi tiết món ăn
- `GET /api/menu/category/:id` - Lấy món ăn theo danh mục
- `POST /api/menu` - Thêm món ăn mới (Admin)
- `PUT /api/menu/:id` - Cập nhật món ăn (Admin)
- `DELETE /api/menu/:id` - Xóa món ăn (Admin)

**Chức năng:**
- CRUD operations cho món ăn
- Filter theo danh mục
- Search món ăn
- Quản lý giá, khuyến mãi

##### **4. categories.js - Categories API**

**Endpoints:**
- `GET /api/categories` - Lấy tất cả danh mục
- `GET /api/categories/:id` - Chi tiết danh mục
- `POST /api/categories` - Thêm danh mục (Admin)
- `PUT /api/categories/:id` - Cập nhật danh mục (Admin)
- `DELETE /api/categories/:id` - Xóa danh mục (Admin)

**Chức năng:**
- Quản lý danh mục món ăn
- Hierarchy categories

##### **5. cart.js - Shopping Cart API**

**Endpoints:**
- `GET /api/cart` - Lấy giỏ hàng
- `POST /api/cart/add` - Thêm món vào giỏ
- `PUT /api/cart/update` - Cập nhật số lượng
- `DELETE /api/cart/remove/:id` - Xóa món khỏi giỏ
- `DELETE /api/cart/clear` - Xóa toàn bộ giỏ hàng

**Chức năng:**
- Quản lý giỏ hàng theo user
- Session cart cho guest users
- Real-time cart updates

##### **6. albums.js - Photo Gallery API**

**Endpoints:**
- `GET /api/albums` - Lấy tất cả album
- `GET /api/albums/:id` - Chi tiết album
- `GET /api/albums/product/:id` - Ảnh theo món ăn
- `POST /api/albums` - Thêm ảnh (Admin)
- `DELETE /api/albums/:id` - Xóa ảnh (Admin)

**Chức năng:**
- Quản lý album ảnh
- Gallery cho món ăn
- Loại ảnh: món ăn, không gian, sự kiện

##### **7. news.js - News/Blog API**

**Endpoints:**
- `GET /api/news` - Danh sách tin tức
- `GET /api/news/:id` - Chi tiết tin tức
- `POST /api/news` - Thêm tin tức (Admin)
- `PUT /api/news/:id` - Cập nhật tin tức (Admin)
- `DELETE /api/news/:id` - Xóa tin tức (Admin)

**Chức năng:**
- Quản lý tin tức, blog
- Phân trang
- Tags và categories

#### **E. Utility Scripts:**

**Vị trí:** `backend/scripts/`

1. **check-db.js** - Kiểm tra kết nối database
2. **check-oauth-config.js** - Kiểm tra OAuth config
3. **check-images.js** - Kiểm tra file ảnh
4. **check-mysql-direct.js** - Test MySQL connection
5. **check-system.js** - System health check
6. **check-tables.js** - Kiểm tra cấu trúc bảng
7. **check-users-table.js** - Kiểm tra bảng users
8. **create-admin.js** - Tạo tài khoản admin
9. **create-sample-albums.js** - Tạo dữ liệu mẫu album
10. **create-sample-news.js** - Tạo dữ liệu mẫu tin tức
11. **create-test-user.js** - Tạo user test
12. **create-verification-table.js** - Tạo bảng xác thực
13. **setup-email-verification.js** - Setup email verification
14. **fix-image-paths.js** - Fix đường dẫn ảnh
15. **query-users.js** - Query dữ liệu users
16. **test-email.js** - Test gửi email
17. **update-admin-email.js** - Update email admin
18. **update-missing-images.js** - Update ảnh thiếu
19. **update-trang-thai-enum.js** - Update enum trạng thái
20. **show-structure.js** - Hiển thị cấu trúc database
21. **test-album-data.js** - Test dữ liệu album

**SQL Scripts:**
- **create-email-verification-table.sql** - Script tạo bảng xác thực

---

## 4. CƠ SỞ DỮ LIỆU (DATABASE SCHEMA)

### 4.1. Thông tin Database:
- **Tên database:** `amthuc_phuongnam`
- **Engine:** MySQL 8.0+
- **Charset:** utf8mb4_unicode_ci
- **Port:** 3307 (custom)

### 4.2. Các bảng chính (26 bảng):

#### **A. Bảng Người dùng & Xác thực:**

1. **nguoi_dung** - Thông tin người dùng
   - `ma_nguoi_dung` (PK)
   - `ten_nguoi_dung`
   - `email` (Unique)
   - `so_dien_thoai` (Unique)
   - `mat_khau_hash`
   - `dia_chi`
   - `gioi_tinh` (ENUM: nam, nu, khac)
   - `anh_dai_dien`
   - `trang_thai` (1: active, 0: inactive)
   - `ngay_tao`

2. **xac_thuc_email** - Xác thực email
   - `ma_xac_thuc` (PK)
   - `email`
   - `ma_code` (6 digits)
   - `ten_nguoi_dung`
   - `mat_khau_hash`
   - `so_dien_thoai`
   - `dia_chi`
   - `gioi_tinh`
   - `anh_dai_dien`
   - `trang_thai` (ENUM: pending, verified, expired, reset_password)
   - `ngay_het_han`
   - `ngay_tao`

3. **admin** - Tài khoản quản trị
   - `ma_admin` (PK)
   - `tai_khoan` (Unique)
   - `mat_khau_hash`
   - `ten_hien_thi`
   - `email`
   - `quyen` (superadmin, admin, moderator)
   - `ngay_tao`

#### **B. Bảng Sản phẩm & Danh mục:**

4. **mon_an** - Món ăn
   - `ma_mon` (PK)
   - `ten_mon`
   - `ma_danh_muc` (FK)
   - `gia` (Decimal)
   - `gia_khuyen_mai` (Decimal)
   - `mo_ta`
   - `anh_dai_dien`
   - `trang_thai` (ENUM: con_hang, het_hang, ngung_kinh_doanh)
   - `luot_xem`
   - `diem_danh_gia` (1-5)
   - `so_luot_danh_gia`
   - `ngay_tao`

5. **danh_muc** - Danh mục món ăn
   - `ma_danh_muc` (PK)
   - `ten_danh_muc`
   - `mo_ta`
   - `anh_dai_dien`
   - `ngay_tao`

6. **anh_san_pham** - Gallery ảnh món ăn
   - `ma_anh` (PK)
   - `ma_mon` (FK)
   - `duong_dan_anh`
   - `mo_ta`
   - `ngay_tao`

#### **C. Bảng Giỏ hàng & Đơn hàng:**

7. **gio_hang** - Giỏ hàng
   - `ma_gio_hang` (PK)
   - `ma_nguoi_dung` (FK)
   - `ngay_tao`

8. **chi_tiet_gio_hang** - Chi tiết giỏ hàng
   - `ma_chi_tiet` (PK)
   - `ma_gio_hang` (FK)
   - `ma_mon` (FK)
   - `so_luong`
   - `gia_tam_tinh`
   - `ngay_them`

9. **don_hang** - Đơn hàng
   - `ma_don_hang` (PK)
   - `ma_nguoi_dung` (FK)
   - `tong_tien`
   - `phi_van_chuyen`
   - `ma_giam_gia`
   - `tong_thanh_toan`
   - `trang_thai_don_hang` (ENUM: cho_xac_nhan, dang_chuan_bi, dang_giao, hoan_thanh, huy)
   - `trang_thai_thanh_toan` (ENUM: chua_thanh_toan, da_thanh_toan, hoan_tien)
   - `phuong_thuc_thanh_toan` (tien_mat, chuyen_khoan, the)
   - `dia_chi_giao_hang`
   - `sdt_giao_hang`
   - `ghi_chu`
   - `ngay_tao`
   - `ngay_cap_nhat`

10. **chi_tiet_don_hang** - Chi tiết đơn hàng
    - `ma_chi_tiet` (PK)
    - `ma_don_hang` (FK)
    - `ma_mon` (FK)
    - `ten_mon`
    - `so_luong`
    - `don_gia`
    - `thanh_tien`

#### **D. Bảng Nội dung:**

11. **tin_tuc** - Tin tức/Blog
    - `ma_tin` (PK)
    - `tieu_de`
    - `noi_dung`
    - `anh_dai_dien`
    - `tac_gia`
    - `luot_xem`
    - `trang_thai` (ENUM: nhap, dang, an)
    - `ngay_tao`
    - `ngay_cap_nhat`

12. **album_anh** - Album ảnh
    - `ma_album` (PK)
    - `duong_dan_anh`
    - `loai_anh` (khong_gian, mon_an, su_kien, khong_ro)
    - `mo_ta`
    - `ngay_tao`

#### **E. Bảng Khuyến mãi & Đánh giá:**

13. **ma_giam_gia** - Mã giảm giá
    - `ma_giam_gia` (PK)
    - `code` (Unique)
    - `loai_giam` (ENUM: phan_tram, so_tien)
    - `gia_tri_giam`
    - `gia_tri_don_toi_thieu`
    - `so_luong`
    - `da_su_dung`
    - `ngay_bat_dau`
    - `ngay_ket_thuc`
    - `trang_thai` (active, inactive, expired)

14. **danh_gia** - Đánh giá món ăn
    - `ma_danh_gia` (PK)
    - `ma_mon` (FK)
    - `ma_nguoi_dung` (FK)
    - `diem_danh_gia` (1-5)
    - `noi_dung`
    - `ngay_tao`

#### **F. Bảng Đặt bàn & Liên hệ:**

15. **dat_ban** - Đặt bàn
    - `ma_dat_ban` (PK)
    - `ma_nguoi_dung` (FK, nullable)
    - `ten_khach_hang`
    - `so_dien_thoai`
    - `email`
    - `ngay_dat`
    - `gio_dat`
    - `so_nguoi`
    - `ghi_chu`
    - `trang_thai` (ENUM: cho_xac_nhan, da_xac_nhan, hoan_thanh, huy)
    - `ngay_tao`

16. **lien_he** - Liên hệ
    - `ma_lien_he` (PK)
    - `ten_nguoi_gui`
    - `email`
    - `so_dien_thoai`
    - `tieu_de`
    - `noi_dung`
    - `trang_thai` (ENUM: moi, dang_xu_ly, da_xu_ly)
    - `ngay_tao`

#### **G. Bảng Thông báo & Hoạt động:**

17. **thong_bao** - Thông báo
    - `ma_thong_bao` (PK)
    - `ma_nguoi_dung` (FK)
    - `tieu_de`
    - `noi_dung`
    - `loai` (don_hang, khuyen_mai, he_thong)
    - `da_doc` (boolean)
    - `ngay_tao`

18. **lich_su_hoat_dong** - Lịch sử hoạt động
    - `ma_hoat_dong` (PK)
    - `ma_nguoi_dung` (FK)
    - `loai_hoat_dong`
    - `mo_ta`
    - `ngay_tao`

#### **H. Bảng khác:**

19. **yeu_thich** - Món ăn yêu thích
20. **banner** - Banner quảng cáo
21. **cau_hinh** - Cấu hình hệ thống
22. **phuong_thuc_thanh_toan** - Phương thức thanh toán
23. **van_chuyen** - Vận chuyển
24. **nha_cung_cap** - Nhà cung cấp
25. **nguyen_lieu** - Nguyên liệu
26. **kho** - Quản lý kho

---

## 5. LUỒNG HOẠT ĐỘNG CHÍNH (USER FLOWS)

### 5.1. Luồng đăng ký người dùng:
1. User nhập thông tin → Frontend validation
2. POST `/api/auth/send-verification`
3. Backend tạo mã 6 số, lưu vào `xac_thuc_email`
4. Gửi email xác thực qua Nodemailer
5. User nhập mã xác thực
6. POST `/api/auth/verify-email`
7. Backend validate mã, tạo user trong `nguoi_dung`
8. Trả về JWT token
9. Frontend lưu token vào localStorage
10. Redirect đến trang chủ

### 5.2. Luồng đặt hàng:
1. User browse menu → `GET /api/menu`
2. Thêm món vào giỏ → `POST /api/cart/add`
3. Xem giỏ hàng → `GET /api/cart`
4. Cập nhật số lượng → `PUT /api/cart/update`
5. Proceed to checkout
6. Nhập thông tin giao hàng
7. Chọn phương thức thanh toán
8. Tạo đơn hàng → `POST /api/orders/create`
9. Backend tạo record trong `don_hang` và `chi_tiet_don_hang`
10. Clear giỏ hàng
11. Gửi email xác nhận đơn hàng
12. Redirect đến trang success

### 5.3. Luồng quên mật khẩu:
1. User click "Quên mật khẩu"
2. Nhập email → `POST /api/auth/forgot-password`
3. Backend tạo mã reset, gửi email
4. User nhập mã xác thực → `POST /api/auth/verify-reset-code`
5. User nhập mật khẩu mới → `POST /api/auth/reset-password`
6. Backend update `mat_khau_hash`
7. Success message

---

## 6. BẢO MẬT & XÁC THỰC

### 6.1. Authentication Methods:
- **JWT (JSON Web Tokens)** - Token-based authentication
- **bcrypt** - Password hashing (salt rounds: 10)
- **Google OAuth 2.0** - Social login
- **Email verification** - 6-digit code (10 phút hết hạn)

### 6.2. Security Features:
- Password validation (min 6 chars, chữ + số)
- Email format validation
- Phone number validation (Vietnam format)
- SQL Injection prevention (parameterized queries)
- XSS prevention (input sanitization)
- CORS configuration
- Session management
- Secure file upload (image only, max 5MB)
- Token expiration (7 days)

---

## 7. EMAIL SERVICE

### 7.1. Email Types:
1. **Verification Email** - Email xác thực đăng ký
2. **Welcome Email** - Email chào mừng sau đăng ký
3. **Password Reset Email** - Email đặt lại mật khẩu
4. **Order Confirmation Email** - Xác nhận đơn hàng
5. **Order Status Update Email** - Cập nhật trạng thái đơn

### 7.2. Email Configuration:
- **Service:** Gmail SMTP
- **Library:** Nodemailer
- **Templates:** HTML email templates
- **From:** No-reply email address

---

## 8. FILE UPLOAD & STORAGE

### 8.1. Upload Locations:
- **Avatar:** `backend/images/avatars/`
- **Product Images:** `backend/images/`
- **Album Images:** `backend/images/albums/`

### 8.2. Upload Configuration:
- **Max size:** 5MB
- **Allowed types:** Images only (jpg, png, gif, webp)
- **Naming:** Timestamp + random number
- **Library:** Multer

---

## 9. RESPONSIVE DESIGN

### 9.1. Breakpoints:
- **Mobile:** < 640px
- **Tablet:** 640px - 1024px
- **Desktop:** > 1024px

### 9.2. Features:
- Mobile-first approach
- TailwindCSS responsive utilities
- Touch-friendly UI
- Optimized images
- Fast loading

---

## 10. ANIMATION & UX

### 10.1. Animation Libraries:
- **GSAP** - Timeline animations, ScrollTrigger
- **Swiper.js** - Carousels, sliders
- **CSS Transitions** - Hover effects, smooth transitions

### 10.2. UX Features:
- Loading states
- Toast notifications
- Skeleton loaders
- Smooth scrolling
- Parallax effects
- Lazy loading images

---

## 11. PERFORMANCE OPTIMIZATION

### 11.1. Backend:
- Connection pooling (MySQL)
- Async/await patterns
- Error handling
- Query optimization
- Response compression

### 11.2. Frontend:
- Code splitting
- Lazy loading
- Image optimization
- CDN for libraries
- Minified assets
- Browser caching

---

## 12. DEPLOYMENT & ENVIRONMENT

### 12.1. Environment Variables (.env):
```
# Database
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=amthuc_phuongnam
DB_PORT=3307

# Server
PORT=3000
NODE_ENV=development

# JWT
JWT_SECRET=your-secret-key-change-this

# Email
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password

# Session
SESSION_SECRET=your-session-secret

# Google OAuth
GOOGLE_CLIENT_ID=your-client-id
GOOGLE_CLIENT_SECRET=your-client-secret
GOOGLE_CALLBACK_URL=http://localhost:3000/api/auth/google/callback
```

### 12.2. Scripts:
- `npm start` - Production mode
- `npm run dev` - Development mode (nodemon)

---

## 13. TESTING & DEBUGGING

### 13.1. Debugging Tools:
- Console logging
- Network tab inspection
- Database query logs
- Error tracking

### 13.2. Test Files:
- `test-api.md` - API testing guide
- Various check scripts in `backend/scripts/`

---

## 14. FEATURES CHECKLIST

### ✅ Đã hoàn thành:
- [x] Kết nối database MySQL
- [x] RESTful API design
- [x] User authentication (register, login, logout)
- [x] Email verification
- [x] Password reset flow
- [x] Shopping cart functionality
- [x] Product catalog
- [x] Product categories
- [x] Product detail pages
- [x] Image gallery/albums
- [x] News/Blog system
- [x] Admin authentication
- [x] Responsive design
- [x] GSAP animations
- [x] Google OAuth integration
- [x] File upload (avatars)
- [x] JWT token management
- [x] Session management

### 🔄 Đang phát triển:
- [ ] Order management system
- [ ] Payment gateway integration
- [ ] Table reservation system
- [ ] Review & rating system
- [ ] Real-time notifications
- [ ] Chatbot functionality
- [ ] Admin dashboard features
- [ ] Inventory management
- [ ] Reporting & analytics

---

## 15. API DOCUMENTATION SUMMARY

### Total Endpoints: 40+

**Authentication:** 10 endpoints  
**Menu/Products:** 6 endpoints  
**Categories:** 5 endpoints  
**Cart:** 5 endpoints  
**Albums:** 5 endpoints  
**News:** 5 endpoints  
**Admin:** 3+ endpoints  

---

## 16. DATABASE STATISTICS

- **Total Tables:** 26
- **Total Records (Sample Data):**
  - Món ăn: 25
  - Danh mục: 5
  - Admin: 5
  - Album: 2
  - Users: Variable

---

## 17. PROJECT MANAGEMENT

### 17.1. Version Control:
- **Repository:** CN-DA22TTC-NguyenHuynhKyThuat-WebSiteAmThucPhuongNam-Nodejs
- **Owner:** KyThuatTVU
- **Branch:** main

### 17.2. File Structure Scripts:
- `check-sensitive-files.ps1` - Check sensitive files
- `check-sensitive-files.sh` - Check sensitive files (Linux)
- `create-pr-branch.ps1` - Create PR branch

---

## 18. CONTACT & SUPPORT

**Project:** Website Ẩm Thực Phương Nam Vĩnh Long  
**Location:** Vĩnh Long, Vietnam  
**Type:** Restaurant Management System  
**Technology Stack:** MERN-like (MySQL instead of MongoDB)

---

## 19. TỔNG KẾT CÔNG NGHỆ

### Backend Stack:
```
Node.js + Express.js
├── MySQL (Database)
├── JWT (Authentication)
├── bcrypt (Password Security)
├── Nodemailer (Email Service)
├── Passport (OAuth)
├── Multer (File Upload)
└── dotenv (Config Management)
```

### Frontend Stack:
```
HTML5 + CSS3 + JavaScript (ES6+)
├── TailwindCSS (Styling)
├── GSAP (Animations)
├── Swiper.js (Sliders)
├── Font Awesome (Icons)
└── Fetch API (HTTP Requests)
```

### Database:
```
MySQL 8.0
├── 26 Tables
├── InnoDB Engine
├── utf8mb4_unicode_ci Charset
└── Foreign Key Constraints
```

---

**Tài liệu này tổng hợp đầy đủ thông tin về thành phần và module của Website Ẩm Thực Phương Nam.**
