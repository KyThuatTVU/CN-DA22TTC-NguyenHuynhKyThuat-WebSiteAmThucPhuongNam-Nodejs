-- =============================================
-- Tạo bảng lịch sử trạng thái đơn hàng
-- =============================================

CREATE TABLE IF NOT EXISTS `lich_su_trang_thai_don_hang` (
  `ma_lich_su` INT NOT NULL AUTO_INCREMENT,
  `ma_don_hang` INT NOT NULL,
  `trang_thai_cu` VARCHAR(50) NULL,
  `trang_thai_moi` VARCHAR(50) NOT NULL,
  `nguoi_thay_doi` INT NULL COMMENT 'ID của admin hoặc user thay đổi',
  `loai_nguoi_thay_doi` ENUM('admin', 'user', 'system') DEFAULT 'system',
  `ghi_chu` TEXT NULL,
  `thoi_gian_thay_doi` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_lich_su`),
  INDEX `idx_ma_don_hang` (`ma_don_hang` ASC),
  INDEX `idx_thoi_gian` (`thoi_gian_thay_doi` DESC),
  CONSTRAINT `fk_lich_su_don_hang`
    FOREIGN KEY (`ma_don_hang`)
    REFERENCES `don_hang` (`ma_don_hang`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
COMMENT = 'Lưu lịch sử thay đổi trạng thái đơn hàng';

-- =============================================
-- Tạo trigger tự động ghi lịch sử khi tạo đơn hàng mới
-- =============================================

DELIMITER $$

CREATE TRIGGER `after_don_hang_insert`
AFTER INSERT ON `don_hang`
FOR EACH ROW
BEGIN
    INSERT INTO `lich_su_trang_thai_don_hang` 
    (`ma_don_hang`, `trang_thai_cu`, `trang_thai_moi`, `loai_nguoi_thay_doi`, `ghi_chu`)
    VALUES 
    (NEW.ma_don_hang, NULL, NEW.trang_thai, 'system', 'Đơn hàng được tạo');
END$$

DELIMITER ;

-- =============================================
-- Tạo trigger tự động ghi lịch sử khi cập nhật trạng thái
-- =============================================

DELIMITER $$

CREATE TRIGGER `after_don_hang_update`
AFTER UPDATE ON `don_hang`
FOR EACH ROW
BEGIN
    IF OLD.trang_thai != NEW.trang_thai THEN
        INSERT INTO `lich_su_trang_thai_don_hang` 
        (`ma_don_hang`, `trang_thai_cu`, `trang_thai_moi`, `loai_nguoi_thay_doi`, `ghi_chu`)
        VALUES 
        (NEW.ma_don_hang, OLD.trang_thai, NEW.trang_thai, 'system', 'Trạng thái đơn hàng được cập nhật');
    END IF;
END$$

DELIMITER ;

-- =============================================
-- Thêm dữ liệu lịch sử cho các đơn hàng hiện có
-- =============================================

INSERT INTO `lich_su_trang_thai_don_hang` 
(`ma_don_hang`, `trang_thai_cu`, `trang_thai_moi`, `loai_nguoi_thay_doi`, `ghi_chu`, `thoi_gian_thay_doi`)
SELECT 
    ma_don_hang,
    NULL,
    trang_thai,
    'system',
    'Dữ liệu khởi tạo từ đơn hàng hiện có',
    thoi_gian_tao
FROM don_hang
WHERE ma_don_hang NOT IN (SELECT DISTINCT ma_don_hang FROM lich_su_trang_thai_don_hang);

-- =============================================
-- Hoàn tất
-- =============================================

SELECT 'Bảng lich_su_trang_thai_don_hang đã được tạo thành công!' as message;
