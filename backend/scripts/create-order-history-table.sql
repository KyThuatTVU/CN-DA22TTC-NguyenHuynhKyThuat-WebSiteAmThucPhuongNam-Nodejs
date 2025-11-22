-- Tạo bảng lịch sử trạng thái đơn hàng
CREATE TABLE IF NOT EXISTS lich_su_trang_thai_don_hang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ma_don_hang VARCHAR(50) NOT NULL,
    trang_thai ENUM('cho_xac_nhan', 'da_xac_nhan', 'dang_chuan_bi', 'dang_giao', 'hoan_thanh', 'da_huy') NOT NULL,
    ghi_chu TEXT,
    thoi_gian DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_don_hang) REFERENCES don_hang(ma_don_hang) ON DELETE CASCADE,
    INDEX idx_ma_don_hang (ma_don_hang),
    INDEX idx_thoi_gian (thoi_gian)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Thêm lịch sử cho các đơn hàng hiện có
INSERT INTO lich_su_trang_thai_don_hang (ma_don_hang, trang_thai, ghi_chu, thoi_gian)
SELECT 
    ma_don_hang,
    trang_thai,
    'Trạng thái ban đầu',
    ngay_dat
FROM don_hang
WHERE NOT EXISTS (
    SELECT 1 FROM lich_su_trang_thai_don_hang 
    WHERE lich_su_trang_thai_don_hang.ma_don_hang = don_hang.ma_don_hang
);
