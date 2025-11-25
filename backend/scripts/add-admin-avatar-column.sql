-- Thêm cột anh_dai_dien vào bảng admin để lưu avatar từ Google
ALTER TABLE `admin` 
ADD COLUMN `anh_dai_dien` VARCHAR(500) NULL AFTER `email`;
