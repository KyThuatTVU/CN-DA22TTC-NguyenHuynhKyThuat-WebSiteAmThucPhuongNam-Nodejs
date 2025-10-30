# Backend - Ẩm Thực Phương Nam

## Cài đặt

### 1. Cài đặt dependencies
```bash
cd backend
npm install
```

### 2. Cấu hình Database
File `.env` đã được cấu hình với thông tin:
- Host: localhost
- Port: 3307
- Database: amthuc_phuongnam
- User: root
- Password: TVU@842004

### 3. Tạo Database
Chạy file `database/schema.sql` trong MySQL:
```bash
mysql -u root -p -P 3307 < database/schema.sql
```

Hoặc import trực tiếp trong MySQL Workbench/phpMyAdmin.

### 4. Chạy Server

**Development mode (với nodemon):**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

Server sẽ chạy tại: `http://localhost:3000`

## Kiểm tra kết nối

Truy cập: `http://localhost:3000/api/test-db`

Nếu thành công, bạn sẽ thấy:
```json
{
  "success": true,
  "message": "Kết nối database thành công!",
  "data": [{"result": 2}]
}
```

## Cấu trúc thư mục

```
backend/
├── config/
│   └── database.js       # Cấu hình kết nối MySQL
├── database/
│   └── schema.sql        # Schema database
├── images/               # Thư mục chứa hình ảnh
├── .env                  # Biến môi trường
├── server.js             # File server chính
└── package.json          # Dependencies
```

## API Endpoints

### Cơ bản
- `GET /` - Thông tin API
- `GET /api/test-db` - Test kết nối database
- `GET /images/:filename` - Lấy hình ảnh

### Món ăn
- `GET /api/menu` - Lấy tất cả món ăn (kèm tên danh mục)
- `GET /api/menu/:id` - Chi tiết món ăn theo mã món
- `GET /api/menu/category/:id` - Lấy món ăn theo danh mục

### Danh mục
- `GET /api/categories` - Lấy tất cả danh mục
- `GET /api/categories/:id` - Chi tiết danh mục

### Album
- `GET /api/albums` - Lấy tất cả album
- `GET /api/albums/product/:id` - Lấy ảnh theo món ăn

## Công nghệ sử dụng

- Node.js + Express
- MySQL2
- dotenv
- CORS
- Multer (upload files)
- bcryptjs (mã hóa password)
- jsonwebtoken (JWT authentication)
