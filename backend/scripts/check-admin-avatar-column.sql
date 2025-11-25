-- Kiểm tra và thêm cột anh_dai_dien vào bảng admin nếu chưa có

-- Kiểm tra cột có tồn tại không
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = 'amthucphuongnam'
    AND TABLE_NAME = 'admin'
    AND COLUMN_NAME = 'anh_dai_dien';

-- Nếu không có kết quả, chạy lệnh sau để thêm cột:
ALTER TABLE admin 
ADD COLUMN anh_dai_dien VARCHAR(500) NULL COMMENT 'URL ảnh đại diện từ Google OAuth';

-- Xem cấu trúc bảng admin
DESC admin;

-- Kiểm tra dữ liệu hiện tại
SELECT ma_admin, tai_khoan, email, ten_hien_thi, anh_dai_dien 
FROM admin 
LIMIT 5;
