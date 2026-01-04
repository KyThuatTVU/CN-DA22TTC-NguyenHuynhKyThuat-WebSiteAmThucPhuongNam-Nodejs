# Dự Án Website Ẩm Thực Phương Nam

Website nhà hàng ẩm thực Phương Nam Vĩnh Long với backend Node.js + MySQL và frontend HTML/CSS/JavaScript.

## Cấu trúc dự án

```
├── backend/              # Backend API (Node.js + Express + MySQL)
│   ├── config/          # Cấu hình database
│   ├── routes/          # API routes
│   ├── scripts/         # Scripts tiện ích
│   ├── images/          # Hình ảnh món ăn
│   ├── .env            # Biến môi trường
│   ├── server.js       # Server chính
│   └── package.json    # Dependencies
│
└── frontend/            # Frontend (HTML/CSS/JS)
    ├── components/      # Components tái sử dụng
    ├── css/            # Stylesheets
    ├── js/             # JavaScript files
    ├── images/         # Hình ảnh frontend
    └── *.html          # Các trang HTML

```

## Cài đặt và chạy

### 1. Cài đặt Backend

```bash
cd backend
npm install
```

### 2. Cấu hình Database

File `.env` đã được cấu hình:
- Database: `amthuc_phuongnam`
- Port: 3307
- User: root

### 3. Chạy Server

```bash
# Development mode (tự động restart khi có thay đổi)
npm run dev

# Production mode
npm start
```

Server sẽ chạy tại: **http://localhost:3000**

### 4. Truy cập Website

Mở trình duyệt và truy cập:
- Trang chủ: http://localhost:3000/index.html
- Thực đơn: http://localhost:3000/thuc-don.html
- Album: http://localhost:3000/album.html

## Tính năng đã hoàn thành

✅ Kết nối database MySQL
✅ API lấy danh sách món ăn
✅ API lấy danh mục món ăn
✅ API lấy album ảnh
✅ Trang thực đơn động (load từ database)
✅ Lọc món ăn theo danh mục
✅ Hiển thị thông tin món ăn chi tiết

## API Endpoints

### Món ăn
- `GET /api/menu` - Tất cả món ăn
- `GET /api/menu/:id` - Chi tiết món ăn
- `GET /api/menu/category/:id` - Món ăn theo danh mục

### Danh mục
- `GET /api/categories` - Tất cả danh mục
- `GET /api/categories/:id` - Chi tiết danh mục


- `GET /api/albums` - Tất cả album
- `GET /api/albums/product/:id` - Ảnh theo món ăn

## Công nghệ sử dụng

**Backend:**
- Node.js + Express
- MySQL2 (với Promise)
- dotenv
- CORS

**Frontend:**
- HTML5
- TailwindCSS (CDN cho development, khuyến nghị cài đặt qua PostCSS/CLI cho production)
- JavaScript (ES6+)
- Font Awesome Icons

> ⚠️ **Lưu ý về Tailwind CSS**: Hiện tại project sử dụng Tailwind CDN (`cdn.tailwindcss.com`) cho development. Khi deploy production, nên cài đặt Tailwind CSS thông qua PostCSS hoặc Tailwind CLI để tối ưu hiệu suất và loại bỏ cảnh báo trình duyệt. Xem thêm: [Tailwind Installation](https://tailwindcss.com/docs/installation)



Database `amthuc_phuongnam` có 26 bảng với dữ liệu:
- 25 món ăn
- 5 danh mục
- 2 album
- Và nhiều bảng khác..


- Server backend cũng serve frontend files
- Hình ảnh món ăn được lưu trong `backend/images/`
- API trả về JSON format
- CORS đã được enable cho phép truy cập từ mọi nguồn
