-- Bảng lưu mã xác thực email
CREATE TABLE IF NOT EXISTS email_verification (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    verification_code VARCHAR(6) NOT NULL,
    user_data TEXT NOT NULL COMMENT 'JSON string chứa thông tin đăng ký tạm thời',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME NOT NULL,
    is_verified TINYINT DEFAULT 0 COMMENT '0: Chưa xác thực, 1: Đã xác thực',
    INDEX (email),
    INDEX (verification_code),
    INDEX (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Xóa các mã xác thực đã hết hạn (chạy định kỳ)
-- DELETE FROM email_verification WHERE expires_at < NOW() AND is_verified = 0;
