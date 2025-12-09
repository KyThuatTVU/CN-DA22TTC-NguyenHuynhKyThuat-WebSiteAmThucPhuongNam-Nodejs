-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: amthuc_phuongnam
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `ma_admin` int NOT NULL AUTO_INCREMENT,
  `tai_khoan` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mat_khau_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ten_hien_thi` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anh_dai_dien` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quyen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'superadmin',
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_admin`),
  UNIQUE KEY `tai_khoan` (`tai_khoan`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin1','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Nguyễn Văn An','admin1@phuongnam.vn',NULL,'superadmin','2025-10-30 08:31:01'),(2,'admin2','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Trần Thị Bình','admin2@phuongnam.vn',NULL,'admin','2025-10-30 08:31:01'),(3,'admin3','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Lê Văn Cường','admin3@phuongnam.vn',NULL,'moderator','2025-10-30 08:31:01'),(4,'admin4','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Phạm Thị Dung','admin4@phuongnam.vn',NULL,'admin','2025-10-30 08:31:01'),(5,'admin5','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Hoàng Văn Em','admin5@phuongnam.vn',NULL,'moderator','2025-10-30 08:31:01'),(6,'admin','$2a$10$I/S3gPoql7.3t2s8gcoNv.qI4P3duc8/5uSiglMBGlCca7/mi4aPO','Nguyễn Huỳnh Kĩ Thuật','nguyenhuynhkithuat84tv@gmail.com','https://lh3.googleusercontent.com/a/ACg8ocIo90HHFVO_TpBzGlbr-kcFij7f4VyqjWwWZYUSGqJIjRzSHp85=s200-c','superadmin','2025-11-10 09:36:17'),(7,'manager','$2a$10$KL9W0L7/zszxiLUNA4698uwizXuTN8lkyP.ySPSyav0XromP6ZNnG','Manager','manager@phuongnam.vn',NULL,'admin','2025-11-10 09:36:17');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_anh`
--

DROP TABLE IF EXISTS `album_anh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_anh` (
  `ma_album` int NOT NULL AUTO_INCREMENT,
  `duong_dan_anh` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Đường dẫn hoặc URL ảnh',
  `loai_anh` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'khong_ro' COMMENT 'Loại: mon_an, khong_gian, su_kien, khach_hang',
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mô tả ảnh',
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Ngày thêm ảnh',
  PRIMARY KEY (`ma_album`),
  KEY `idx_loai_anh` (`loai_anh`),
  KEY `idx_ngay_tao` (`ngay_tao`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng lưu trữ album ảnh nhà hàng';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_anh`
--

LOCK TABLES `album_anh` WRITE;
/*!40000 ALTER TABLE `album_anh` DISABLE KEYS */;
INSERT INTO `album_anh` VALUES (1,'album-1764488060736-635976621.jpg','khong_gian','Không gian nhà hàng buổi tối','2025-09-09 23:24:19'),(2,'album-1764488759702-802091851.jpg','mon_an','Đông vui','2025-09-09 23:24:19'),(3,'album-1764486972694-998321482.jpg','khong_gian','Trang trí tiệc miễn phí\r\n','2025-11-15 15:39:42'),(4,'album-1764487059734-479059763.jpg','khong_gian','Buổi tiệc ấm áp cùng gia đình ','2025-11-15 15:39:42'),(5,'album-1764487182549-786005532.jpg','khong_gian','Góc chill nhẹ của nhà hàng','2025-11-15 15:39:42'),(6,'album-1764487231495-732182984.jpg','su_kien','Ngày của những người phụ nữ mến yêu','2025-11-15 15:39:42'),(7,'album-1764487297533-544111249.jpg','khong_gian','Buổi chiều mát mẻ cùng em ạ','2025-11-15 15:39:42'),(8,'album-1764487396209-642507861.jpg','su_kien','Tất bật với sự kiện Tết Trung thu năm 2023','2025-11-15 15:39:42'),(9,'album-1764487688812-420142119.jpg','su_kien','Sự kiện 8/3 ạ\r\n','2025-11-15 15:39:42'),(10,'album-1764487814100-973207662.jpg','su_kien','Tết đến xuân về họp mặt anh em mình ạ','2025-11-15 15:39:42'),(11,'album-1764487870056-239679189.jpg','su_kien','2 3 dô dô','2025-11-15 15:39:42'),(12,'album-1764488009041-54892753.jpg','khong_gian','Đông vui quá ạ','2025-11-15 15:39:42'),(13,'album-1764488351779-31035156.jpg','khong_gian','Bàn ăn gia đình ấm cúng','2025-11-15 15:39:42'),(14,'album-1764488400156-195003232.jpg','khong_gian','Buổi trưa mát mẻ','2025-11-15 15:39:42'),(15,'album-1764488481375-362825801.jpg','khong_gian','Sang trọng','2025-11-15 15:39:42'),(16,'album-1764488520701-260733150.jpg','mon_an','Cơm quê ạ','2025-11-15 15:39:42'),(17,'album-1764488571345-965727796.jpg','khong_gian','Hòa mình vào thiên nhiên','2025-11-15 15:39:42'),(18,'album-1764488643710-21512114.jpg','khong_gian','Phục vụ nhiệt tình','2025-11-15 15:39:42'),(19,'album-1764488679331-848795196.jpg','su_kien','Khách hàng hài lòng với dịch vụ','2025-11-15 15:39:42'),(20,'album-1764488707023-470737057.jpg','khong_gian','Bạn bè quây quần vui vẻ','2025-11-15 15:39:42'),(21,'album-1764488731322-670001154.jpg','mon_an','Khoảnh khắc đáng nhớ của khách hàng','2025-11-15 15:39:42');
/*!40000 ALTER TABLE `album_anh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anh_san_pham`
--

DROP TABLE IF EXISTS `anh_san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anh_san_pham` (
  `ma_anh` int NOT NULL AUTO_INCREMENT,
  `ma_mon` int NOT NULL,
  `duong_dan_anh` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Đường dẫn tới file ảnh',
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mô tả ngắn cho ảnh (alt text)',
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_anh`),
  KEY `ma_mon` (`ma_mon`),
  CONSTRAINT `anh_san_pham_ibfk_1` FOREIGN KEY (`ma_mon`) REFERENCES `mon_an` (`ma_mon`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lưu nhiều ảnh cho mỗi món ăn';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anh_san_pham`
--

LOCK TABLES `anh_san_pham` WRITE;
/*!40000 ALTER TABLE `anh_san_pham` DISABLE KEYS */;
INSERT INTO `anh_san_pham` VALUES (1,1,'/images/com-tam-suon-1.jpg','Cơm tấm sườn - góc chụp 1','2025-10-30 08:31:01'),(2,1,'/images/com-tam-suon-2.jpg','Cơm tấm sườn - góc chụp 2','2025-10-30 08:31:01'),(3,6,'/images/goi-cuon-1.jpg','Gỏi cuốn tôm thịt - chi tiết','2025-10-30 08:31:01'),(4,11,'/images/che-ba-mau-1.jpg','Chè ba màu - topping đầy đủ','2025-10-30 08:31:01'),(5,21,'/images/lau-mam-1.jpg','Lẩu mắm - nồi lẩu đang sôi','2025-10-30 08:31:01');
/*!40000 ALTER TABLE `anh_san_pham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `binh_luan_tin_tuc`
--

DROP TABLE IF EXISTS `binh_luan_tin_tuc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `binh_luan_tin_tuc` (
  `ma_binh_luan` int NOT NULL AUTO_INCREMENT,
  `ma_tin_tuc` int NOT NULL,
  `ma_nguoi_dung` int DEFAULT NULL,
  `ten_nguoi_binh_luan` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_nguoi_binh_luan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noi_dung` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_sao` tinyint DEFAULT NULL COMMENT 'Đánh giá từ 1-5 sao',
  `ngay_binh_luan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `ma_binh_luan_cha` int DEFAULT NULL,
  PRIMARY KEY (`ma_binh_luan`),
  KEY `ma_tin_tuc` (`ma_tin_tuc`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  KEY `fk_binh_luan_cha` (`ma_binh_luan_cha`),
  CONSTRAINT `binh_luan_tin_tuc_ibfk_1` FOREIGN KEY (`ma_tin_tuc`) REFERENCES `tin_tuc` (`ma_tin_tuc`) ON DELETE CASCADE,
  CONSTRAINT `binh_luan_tin_tuc_ibfk_2` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL,
  CONSTRAINT `fk_binh_luan_cha` FOREIGN KEY (`ma_binh_luan_cha`) REFERENCES `binh_luan_tin_tuc` (`ma_binh_luan`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `binh_luan_tin_tuc`
--

LOCK TABLES `binh_luan_tin_tuc` WRITE;
/*!40000 ALTER TABLE `binh_luan_tin_tuc` DISABLE KEYS */;
INSERT INTO `binh_luan_tin_tuc` VALUES (11,6,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Chúc mừng nhà hàng khai trương chi nhánh mới! Mình rất mong được đến thử không gian mới này.',NULL,'2025-11-15 10:30:00','approved',NULL),(12,6,2,'Trần Văn Hùng','hung.tran@gmail.com','Ưu đãi khai trương rất hấp dẫn! Mình sẽ rủ gia đình đến ăn cuối tuần này.',NULL,'2025-11-15 14:20:00','approved',NULL),(13,6,3,'Lê Thị Hoa','hoa.le@gmail.com','Không gian nhìn rất đẹp và sang trọng. Chắc chắn sẽ ghé thăm!',NULL,'2025-11-16 09:15:00','approved',NULL),(14,7,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Bài viết rất hữu ích! Mình đã biết thêm nhiều món ăn ngon của miền Nam.',NULL,'2025-11-15 16:45:00','approved',NULL),(15,7,5,'Võ Thị Lan','lan.vo@gmail.com','Cảm ơn nhà hàng đã chia sẻ. Mình sẽ thử hết các món này!',NULL,'2025-11-16 11:30:00','approved',NULL),(16,8,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Workshop rất bổ ích! Mình đã học được nhiều kỹ năng nấu ăn mới.',NULL,'2025-11-16 15:20:00','approved',NULL),(17,9,2,'Trần Văn Hùng','hung.tran@gmail.com','Khuyến mãi cuối tuần quá tuyệt vời! Đã đặt bàn cho gia đình rồi.',NULL,'2025-11-17 10:00:00','approved',NULL),(18,9,3,'Lê Thị Hoa','hoa.le@gmail.com','Mình vừa sử dụng mã giảm giá, rất hài lòng với dịch vụ!',NULL,'2025-11-17 14:30:00','approved',NULL),(19,10,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Đặc sản mùa vụ rất tươi ngon! Đúng chuẩn vị miền Tây.',NULL,'2025-11-18 12:45:00','approved',NULL),(20,10,5,'Võ Thị Lan','lan.vo@gmail.com','Bài viết giới thiệu rất chi tiết. Mình sẽ đến thử món này!',NULL,'2025-11-18 16:00:00','approved',NULL),(21,6,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Chúc mừng nhà hàng khai trương chi nhánh mới! Mình rất mong được đến thử không gian mới này.',NULL,'2025-11-15 10:30:00','approved',NULL),(22,6,2,'Trần Văn Hùng','hung.tran@gmail.com','Ưu đãi khai trương rất hấp dẫn! Mình sẽ rủ gia đình đến ăn cuối tuần này.',NULL,'2025-11-15 14:20:00','approved',NULL),(23,6,3,'Lê Thị Hoa','hoa.le@gmail.com','Không gian nhìn rất đẹp và sang trọng. Chắc chắn sẽ ghé thăm!',NULL,'2025-11-16 09:15:00','approved',NULL),(24,7,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Bài viết rất hữu ích! Mình đã biết thêm nhiều món ăn ngon của miền Nam.',NULL,'2025-11-15 16:45:00','approved',NULL),(25,7,5,'Võ Thị Lan','lan.vo@gmail.com','Cảm ơn nhà hàng đã chia sẻ. Mình sẽ thử hết các món này!',NULL,'2025-11-16 11:30:00','approved',NULL),(26,8,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Workshop rất bổ ích! Mình đã học được nhiều kỹ năng nấu ăn mới.',NULL,'2025-11-16 15:20:00','approved',NULL),(27,9,2,'Trần Văn Hùng','hung.tran@gmail.com','Khuyến mãi cuối tuần quá tuyệt vời! Đã đặt bàn cho gia đình rồi.',NULL,'2025-11-17 10:00:00','approved',NULL),(28,9,3,'Lê Thị Hoa','hoa.le@gmail.com','Mình vừa sử dụng mã giảm giá, rất hài lòng với dịch vụ!',NULL,'2025-11-17 14:30:00','approved',NULL),(29,10,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Đặc sản mùa vụ rất tươi ngon! Đúng chuẩn vị miền Tây.',NULL,'2025-11-18 12:45:00','approved',NULL),(30,10,5,'Võ Thị Lan','lan.vo@gmail.com','Bài viết giới thiệu rất chi tiết. Mình sẽ đến thử món này!',NULL,'2025-11-18 16:00:00','approved',NULL),(31,6,6,'Hồ Quang Vinh','quangvinhho000@gmail.com','Sẽ ghé lại',NULL,'2025-11-29 13:40:59','approved',NULL),(32,6,6,'Hồ Quang Vinh','quangvinhho000@gmail.com','ko',NULL,'2025-11-29 13:50:47','approved',23),(33,7,6,'Hồ Quang Vinh','quangvinhho000@gmail.com','Đẹp quá',NULL,'2025-11-30 13:04:11','approved',NULL),(34,6,6,'Hồ Quang Vinh','quangvinhho000@gmail.com','ok',NULL,'2025-12-05 15:19:48','approved',NULL),(38,6,NULL,'Nguyễn Huỳnh Kĩ Thuật','admin@phuongnam.vn','cảm ơn bạn',NULL,'2025-12-05 15:57:20','approved',34);
/*!40000 ALTER TABLE `binh_luan_tin_tuc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cai_dat`
--

DROP TABLE IF EXISTS `cai_dat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cai_dat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ngay_cap_nhat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cai_dat`
--

LOCK TABLES `cai_dat` WRITE;
/*!40000 ALTER TABLE `cai_dat` DISABLE KEYS */;
INSERT INTO `cai_dat` VALUES (1,'ten_nha_hang','Nhà hàng Ẩm thực Phương Nam','Tên nhà hàng','2025-12-01 20:48:49','2025-12-05 15:11:21'),(2,'so_dien_thoai','0388853044','Số điện thoại liên hệ','2025-12-01 20:48:49','2025-12-05 15:11:21'),(3,'email','amthucphuongnamvinhlong64@gmail.com','Email liên hệ','2025-12-01 20:48:49','2025-12-05 15:11:21'),(4,'website','https://amthucphuongnam.com','Website','2025-12-01 20:48:49','2025-12-05 15:11:21'),(5,'dia_chi','168, Ấp Phú Hòa, Phường Long Đức, Tỉnh Vĩnh Long','Địa chỉ nhà hàng','2025-12-01 20:48:49','2025-12-05 15:11:21'),(6,'gio_mo_cua_t2_t6','08:00-22:00','Giờ mở cửa thứ 2 - thứ 6','2025-12-01 20:48:49','2025-12-01 20:48:49'),(7,'gio_mo_cua_t7_cn','07:00-23:00','Giờ mở cửa thứ 7 - chủ nhật','2025-12-01 20:48:49','2025-12-01 20:48:49'),(8,'cho_phep_giao_hang','1','Cho phép giao hàng (1=có, 0=không)','2025-12-01 20:48:49','2025-12-01 21:06:54'),(9,'phi_giao_hang','20000','Phí giao hàng mặc định (VNĐ)','2025-12-01 20:48:49','2025-12-01 21:06:54'),(10,'mien_phi_giao_hang_tu','200000','Miễn phí giao hàng cho đơn từ (VNĐ)','2025-12-01 20:48:49','2025-12-01 21:06:54'),(11,'thanh_toan_tien_mat','1','Cho phép thanh toán tiền mặt','2025-12-01 20:48:49','2025-12-01 20:48:49'),(12,'thanh_toan_chuyen_khoan','1','Cho phép thanh toán chuyển khoản','2025-12-01 20:48:49','2025-12-01 20:48:49'),(13,'thanh_toan_momo','1','Cho phép thanh toán MoMo','2025-12-01 20:48:49','2025-12-01 20:48:49'),(32,'facebook_url','https://www.facebook.com/Alodzo100tv','Link Facebook','2025-12-06 15:40:10','2025-12-06 15:41:16'),(33,'youtube_url','https://www.youtube.com/watch?v=A56vAp1iol0','Link YouTube','2025-12-06 15:40:10','2025-12-06 15:41:16'),(34,'instagram_url','https://instagram.com/phuongnam','Link Instagram','2025-12-06 15:40:10','2025-12-06 15:41:16'),(35,'tiktok_url','https://tiktok.com/@phuongnam','Link TikTok','2025-12-06 15:40:10','2025-12-06 15:41:16');
/*!40000 ALTER TABLE `cai_dat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cam_xuc_binh_luan`
--

DROP TABLE IF EXISTS `cam_xuc_binh_luan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cam_xuc_binh_luan` (
  `ma_cam_xuc` int NOT NULL AUTO_INCREMENT,
  `ma_binh_luan` int NOT NULL,
  `ma_nguoi_dung` int NOT NULL,
  `loai_cam_xuc` enum('like','love','haha','wow','sad','angry') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'like',
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_cam_xuc`),
  UNIQUE KEY `unique_user_comment_reaction` (`ma_binh_luan`,`ma_nguoi_dung`),
  KEY `cam_xuc_binh_luan_ibfk_2` (`ma_nguoi_dung`),
  CONSTRAINT `cam_xuc_binh_luan_ibfk_1` FOREIGN KEY (`ma_binh_luan`) REFERENCES `binh_luan_tin_tuc` (`ma_binh_luan`) ON DELETE CASCADE,
  CONSTRAINT `cam_xuc_binh_luan_ibfk_2` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cam_xuc_binh_luan`
--

LOCK TABLES `cam_xuc_binh_luan` WRITE;
/*!40000 ALTER TABLE `cam_xuc_binh_luan` DISABLE KEYS */;
INSERT INTO `cam_xuc_binh_luan` VALUES (1,31,6,'love','2025-11-29 13:52:39'),(2,22,6,'haha','2025-11-29 13:55:12'),(3,33,6,'love','2025-11-30 13:04:17');
/*!40000 ALTER TABLE `cam_xuc_binh_luan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cam_xuc_tin_tuc`
--

DROP TABLE IF EXISTS `cam_xuc_tin_tuc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cam_xuc_tin_tuc` (
  `ma_cam_xuc` int NOT NULL AUTO_INCREMENT,
  `ma_tin_tuc` int NOT NULL,
  `ma_nguoi_dung` int NOT NULL,
  `loai_cam_xuc` enum('like','love','haha','wow','sad','angry') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_cam_xuc`),
  UNIQUE KEY `unique_user_news` (`ma_tin_tuc`,`ma_nguoi_dung`),
  KEY `ma_tin_tuc` (`ma_tin_tuc`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `cam_xuc_tin_tuc_ibfk_1` FOREIGN KEY (`ma_tin_tuc`) REFERENCES `tin_tuc` (`ma_tin_tuc`) ON DELETE CASCADE,
  CONSTRAINT `cam_xuc_tin_tuc_ibfk_2` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cam_xuc_tin_tuc`
--

LOCK TABLES `cam_xuc_tin_tuc` WRITE;
/*!40000 ALTER TABLE `cam_xuc_tin_tuc` DISABLE KEYS */;
INSERT INTO `cam_xuc_tin_tuc` VALUES (1,6,1,'love','2025-11-29 13:16:19'),(2,6,2,'like','2025-11-29 13:16:19'),(3,6,3,'wow','2025-11-29 13:16:19'),(4,6,4,'love','2025-11-29 13:16:19'),(5,6,5,'like','2025-11-29 13:16:19'),(6,7,1,'love','2025-11-29 13:16:19'),(7,7,2,'wow','2025-11-29 13:16:19'),(8,7,3,'like','2025-11-29 13:16:19'),(9,7,4,'haha','2025-11-29 13:16:19'),(10,8,1,'like','2025-11-29 13:16:19'),(11,8,2,'love','2025-11-29 13:16:19'),(12,8,5,'wow','2025-11-29 13:16:19'),(13,9,1,'love','2025-11-29 13:16:19'),(14,9,2,'love','2025-11-29 13:16:19'),(15,9,3,'love','2025-11-29 13:16:19'),(16,9,4,'like','2025-11-29 13:16:19'),(17,9,5,'like','2025-11-29 13:16:19'),(18,10,2,'love','2025-11-29 13:16:19'),(19,10,3,'like','2025-11-29 13:16:19'),(20,10,4,'wow','2025-11-29 13:16:19');
/*!40000 ALTER TABLE `cam_xuc_tin_tuc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_don_hang`
--

DROP TABLE IF EXISTS `chi_tiet_don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_don_hang` (
  `ma_ct_don` int NOT NULL AUTO_INCREMENT,
  `ma_don_hang` int NOT NULL,
  `ma_mon` int NOT NULL,
  `so_luong` int NOT NULL,
  `gia_tai_thoi_diem` decimal(12,2) NOT NULL,
  PRIMARY KEY (`ma_ct_don`),
  KEY `ma_don_hang` (`ma_don_hang`),
  KEY `ma_mon` (`ma_mon`),
  CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE,
  CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`ma_mon`) REFERENCES `mon_an` (`ma_mon`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang`
--

LOCK TABLES `chi_tiet_don_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang` VALUES (1,1,1,2,45000.00),(2,1,6,1,30000.00),(3,1,16,2,25000.00),(4,2,2,3,40000.00),(5,2,7,2,35000.00),(6,2,11,5,20000.00),(7,3,3,2,35000.00),(8,3,8,1,45000.00),(9,3,12,4,15000.00),(10,4,21,1,250000.00),(11,4,4,2,50000.00),(12,4,16,4,25000.00),(13,5,5,3,55000.00),(14,5,10,2,50000.00),(15,5,22,1,280000.00),(16,6,25,1,70000.00),(17,7,24,1,85000.00),(18,8,24,1,85000.00),(19,8,25,1,70000.00),(20,9,24,1,85000.00),(21,10,24,1,85000.00),(22,11,24,1,85000.00),(23,11,25,1,70000.00),(24,12,24,1,85000.00),(25,13,24,1,85000.00),(26,14,25,1,70000.00),(27,15,24,1,85000.00),(28,16,24,1,85000.00),(29,17,24,1,85000.00),(30,18,23,1,80000.00),(31,19,24,1,85000.00),(32,20,24,1,85000.00),(33,21,24,1,85000.00),(34,22,24,1,85000.00),(35,23,23,1,80000.00),(36,24,24,1,85000.00),(37,25,20,1,30000.00),(38,26,24,1,85000.00),(39,27,24,1,85000.00),(40,28,25,1,70000.00),(41,29,24,1,85000.00),(42,30,22,1,40000.00),(43,31,24,1,85000.00),(44,32,24,1,85000.00),(45,32,23,1,80000.00),(46,33,24,1,85000.00),(47,34,24,1,85000.00),(48,35,23,1,80000.00),(49,36,23,1,80000.00),(50,37,24,1,85000.00),(51,38,23,1,80000.00),(52,39,24,1,85000.00),(53,40,24,1,85000.00),(54,41,24,1,85000.00),(55,42,24,1,85000.00),(56,43,24,1,85000.00),(57,44,24,1,85000.00),(58,45,24,1,85000.00),(59,46,24,1,85000.00),(60,47,24,1,85000.00),(61,48,24,1,85000.00),(62,49,24,1,85000.00),(63,50,24,1,85000.00),(64,51,24,1,85000.00),(65,52,24,1,85000.00),(66,53,24,1,85000.00),(67,54,24,1,85000.00),(68,55,24,1,85000.00),(69,56,24,1,85000.00),(70,57,24,1,85000.00),(71,58,24,1,85000.00),(72,59,24,1,85000.00),(73,60,24,1,85000.00),(74,61,23,1,80000.00),(75,62,24,1,85000.00),(76,62,23,1,80000.00),(77,63,24,1,85000.00),(78,64,24,1,85000.00),(79,65,25,1,70000.00),(80,66,25,1,70000.00);
/*!40000 ALTER TABLE `chi_tiet_don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_gio_hang`
--

DROP TABLE IF EXISTS `chi_tiet_gio_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_gio_hang` (
  `ma_chi_tiet` int NOT NULL AUTO_INCREMENT,
  `ma_gio_hang` int NOT NULL,
  `ma_mon` int NOT NULL,
  `so_luong` int NOT NULL DEFAULT '1',
  `gia_tai_thoi_diem` decimal(12,2) NOT NULL,
  PRIMARY KEY (`ma_chi_tiet`),
  KEY `ma_gio_hang` (`ma_gio_hang`),
  KEY `ma_mon` (`ma_mon`),
  CONSTRAINT `chi_tiet_gio_hang_ibfk_1` FOREIGN KEY (`ma_gio_hang`) REFERENCES `gio_hang` (`ma_gio_hang`) ON DELETE CASCADE,
  CONSTRAINT `chi_tiet_gio_hang_ibfk_2` FOREIGN KEY (`ma_mon`) REFERENCES `mon_an` (`ma_mon`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_gio_hang`
--

LOCK TABLES `chi_tiet_gio_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_gio_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_gio_hang` VALUES (1,1,1,2,45000.00),(2,1,6,1,30000.00),(3,3,11,3,20000.00),(4,4,16,2,25000.00),(5,4,21,1,250000.00),(6,6,24,1,85000.00),(7,6,22,1,40000.00),(8,6,21,1,30000.00),(9,6,25,1,70000.00),(10,7,25,1,70000.00),(11,8,24,1,85000.00),(12,9,24,1,85000.00),(13,9,25,1,70000.00),(14,10,24,1,85000.00),(15,11,24,1,85000.00),(16,12,24,1,85000.00),(17,12,25,1,70000.00),(18,13,24,1,85000.00),(19,14,24,1,85000.00),(20,15,25,1,70000.00),(21,16,24,1,85000.00),(22,17,24,1,85000.00),(23,18,24,1,85000.00),(24,19,23,1,80000.00),(25,20,24,1,85000.00),(26,21,24,1,85000.00),(27,22,24,1,85000.00),(28,23,24,1,85000.00),(29,24,23,1,80000.00),(30,25,24,1,85000.00),(31,26,20,1,30000.00),(32,27,24,1,85000.00),(33,28,24,1,85000.00),(34,29,25,1,70000.00),(35,30,24,1,85000.00),(36,31,22,1,40000.00),(37,32,24,1,85000.00),(38,33,24,1,85000.00),(39,33,23,1,80000.00),(40,34,24,1,85000.00),(41,35,24,1,85000.00),(42,36,23,1,80000.00),(51,37,23,1,80000.00),(52,39,24,1,85000.00),(53,39,23,1,80000.00),(54,41,24,1,85000.00),(55,42,25,1,70000.00),(56,43,24,1,85000.00);
/*!40000 ALTER TABLE `chi_tiet_gio_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_hoa_don`
--

DROP TABLE IF EXISTS `chi_tiet_hoa_don`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_hoa_don` (
  `ma_ct_hoa_don` int NOT NULL AUTO_INCREMENT,
  `ma_hoa_don` int NOT NULL,
  `ma_mon` int NOT NULL,
  `ten_mon` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_luong` int NOT NULL,
  `don_gia` decimal(12,2) NOT NULL,
  `thanh_tien` decimal(14,2) NOT NULL,
  PRIMARY KEY (`ma_ct_hoa_don`),
  KEY `ma_hoa_don` (`ma_hoa_don`),
  KEY `ma_mon` (`ma_mon`),
  CONSTRAINT `chi_tiet_hoa_don_ibfk_1` FOREIGN KEY (`ma_hoa_don`) REFERENCES `hoa_don` (`ma_hoa_don`) ON DELETE CASCADE,
  CONSTRAINT `chi_tiet_hoa_don_ibfk_2` FOREIGN KEY (`ma_mon`) REFERENCES `mon_an` (`ma_mon`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_hoa_don`
--

LOCK TABLES `chi_tiet_hoa_don` WRITE;
/*!40000 ALTER TABLE `chi_tiet_hoa_don` DISABLE KEYS */;
INSERT INTO `chi_tiet_hoa_don` VALUES (1,1,1,'Cơm Tấm Sườn Bì Chả',2,45000.00,90000.00),(2,1,6,'Gỏi Cuốn Tôm Thịt',1,30000.00,30000.00),(3,2,2,'Hủ Tiếu Nam Vang',3,40000.00,120000.00),(4,2,7,'Chả Giò Rế',2,35000.00,70000.00),(5,2,11,'Chè Ba Màu',5,20000.00,100000.00),(6,3,3,'Bánh Xèo Miền Tây',2,35000.00,70000.00),(7,3,8,'Gỏi Khô Bò',1,45000.00,45000.00),(8,3,12,'Bánh Flan Caramen',4,15000.00,60000.00),(9,4,21,'Lẩu Mắm Miền Tây',1,250000.00,250000.00),(10,4,4,'Bún Mắm Miền Tây',2,50000.00,100000.00),(11,4,16,'Cà Phê Sữa Đá',4,25000.00,100000.00),(12,5,5,'Cơm Chiên Dương Châu',3,55000.00,165000.00),(13,5,10,'Nem Nướng Nha Trang',2,50000.00,100000.00),(14,5,22,'Lẩu Thái Hải Sản',1,280000.00,280000.00),(15,6,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(16,7,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(17,8,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(18,8,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(19,9,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(20,10,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(21,11,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(22,11,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(23,12,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(24,13,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(25,14,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(26,15,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(27,16,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(28,17,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(29,18,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(30,19,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(31,20,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(32,21,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(33,22,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(34,23,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(35,24,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(36,25,20,'Kim Chi Tai Heo',1,30000.00,30000.00),(37,26,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(38,27,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(39,28,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(40,29,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(41,30,22,'Tép Rong Cháy Sả',1,40000.00,40000.00),(42,31,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(43,32,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(44,32,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(45,33,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(46,34,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(47,35,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(48,36,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(49,37,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(50,38,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(51,39,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(52,40,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(53,41,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(54,42,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(55,43,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(56,44,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(57,45,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(58,46,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(59,47,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(60,48,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(61,49,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(62,50,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(63,51,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(64,52,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(65,53,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(66,54,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(67,55,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(68,56,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(69,57,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(70,58,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(71,59,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(72,60,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(73,61,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(74,62,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(75,62,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(76,63,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(77,64,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(78,65,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(79,66,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00);
/*!40000 ALTER TABLE `chi_tiet_hoa_don` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_gia_san_pham`
--

DROP TABLE IF EXISTS `danh_gia_san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danh_gia_san_pham` (
  `ma_danh_gia` int NOT NULL AUTO_INCREMENT,
  `ma_mon` int NOT NULL,
  `ma_nguoi_dung` int NOT NULL,
  `so_sao` tinyint NOT NULL,
  `binh_luan` text COLLATE utf8mb4_unicode_ci,
  `hinh_anh` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON array chứa đường dẫn các ảnh đánh giá',
  `ngay_danh_gia` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`ma_danh_gia`),
  KEY `ma_mon` (`ma_mon`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `danh_gia_san_pham_ibfk_1` FOREIGN KEY (`ma_mon`) REFERENCES `mon_an` (`ma_mon`) ON DELETE CASCADE,
  CONSTRAINT `danh_gia_san_pham_ibfk_2` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_gia_san_pham`
--

LOCK TABLES `danh_gia_san_pham` WRITE;
/*!40000 ALTER TABLE `danh_gia_san_pham` DISABLE KEYS */;
INSERT INTO `danh_gia_san_pham` VALUES (1,1,1,5,'Cơm tấm rất ngon, sườn mềm thơm. Sẽ quay lại!',NULL,'2025-10-30 08:31:01','approved'),(2,2,2,4,'Hủ tiếu nước dùng ngọt, nhưng hơi ít tôm',NULL,'2025-10-30 08:31:01','approved'),(3,6,3,5,'Gỏi cuốn tươi ngon, rau sạch. Nước chấm đậm đà',NULL,'2025-10-30 08:31:01','approved'),(4,21,1,5,'Lẩu mắm đậm đà chuẩn vị miền Tây. Tuyệt vời!',NULL,'2025-10-30 08:31:01','approved'),(5,11,4,3,'Chè bình thường, không có gì đặc biệt',NULL,'2025-10-30 08:31:01','pending'),(6,24,6,3,'Món ăn hấp dẫn, sẽ ủng hộ\n',NULL,'2025-11-28 13:43:59','approved'),(7,25,6,2,'Ngon quá',NULL,'2025-11-30 13:04:57','approved'),(8,25,6,2,NULL,'[\"/images/reviews/review-1764482714689-442191950.png\"]','2025-11-30 13:05:14','approved'),(9,2,6,2,NULL,NULL,'2025-11-30 16:18:47','approved');
/*!40000 ALTER TABLE `danh_gia_san_pham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc`
--

DROP TABLE IF EXISTS `danh_muc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danh_muc` (
  `ma_danh_muc` int NOT NULL AUTO_INCREMENT,
  `ten_danh_muc` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trang_thai` tinyint DEFAULT '1',
  `mo_ta` text COLLATE utf8mb4_unicode_ci,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_danh_muc`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc`
--

LOCK TABLES `danh_muc` WRITE;
/*!40000 ALTER TABLE `danh_muc` DISABLE KEYS */;
INSERT INTO `danh_muc` VALUES (1,'Món Chính',1,'Các món ăn chính như cơm, bún, phở, mì','2025-10-30 08:31:01'),(2,'Món Khai Vị',1,'Các món khai vị, gỏi, salad','2025-10-30 08:31:01'),(3,'Món Tráng Miệng',1,'Các món tráng miệng, chè, bánh ngọt','2025-10-30 08:31:01'),(4,'Đồ Uống',1,'Nước giải khát, trà, cà phê, sinh tố','2025-10-30 08:31:01'),(5,'Món Lẩu',1,'Các loại lẩu theo phong cách miền Nam','2025-10-30 08:31:01');
/*!40000 ALTER TABLE `danh_muc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dat_ban`
--

DROP TABLE IF EXISTS `dat_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dat_ban` (
  `ma_dat_ban` int NOT NULL AUTO_INCREMENT,
  `ten_nguoi_dat` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_dien_thoai` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_luong` int NOT NULL,
  `ngay_dat` date NOT NULL,
  `gio_den` time NOT NULL,
  `ghi_chu` text COLLATE utf8mb4_unicode_ci,
  `trang_thai` enum('pending','confirmed','attended','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `thoi_gian_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_dat_ban`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dat_ban`
--

LOCK TABLES `dat_ban` WRITE;
/*!40000 ALTER TABLE `dat_ban` DISABLE KEYS */;
INSERT INTO `dat_ban` VALUES (1,'Nguyễn Văn A','0906123456',4,'2025-10-15','12:00:00','Đặt bàn gần cửa sổ','confirmed','2025-10-30 08:31:01'),(2,'Trần Thị B','0907234567',6,'2025-10-15','18:30:00','Có trẻ em, cần ghế cao','pending','2025-10-30 08:31:01'),(3,'Lê Văn C','0908345678',2,'2025-10-16','19:00:00','Đặt bàn riêng tư','confirmed','2025-10-30 08:31:01'),(4,'Phạm Thị D','0909456789',8,'2025-10-17','12:30:00','Tiệc sinh nhật, cần trang trí','confirmed','2025-10-30 08:31:01'),(5,'Hoàng Văn E','0910567890',3,'2025-10-18','20:00:00','Không ghi chú','attended','2025-10-30 08:31:01');
/*!40000 ALTER TABLE `dat_ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don_hang`
--

DROP TABLE IF EXISTS `don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `don_hang` (
  `ma_don_hang` int NOT NULL AUTO_INCREMENT,
  `ma_nguoi_dung` int DEFAULT NULL,
  `ten_khach_vang_lai` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `so_dt_khach` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dia_chi_giao` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tong_tien` decimal(14,2) NOT NULL,
  `trang_thai` enum('pending','confirmed','preparing','delivered','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `phuong_thuc_thanh_toan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'cod',
  `thoi_gian_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ghi_chu` text COLLATE utf8mb4_unicode_ci,
  `ma_khuyen_mai` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tien_giam_gia` decimal(14,2) DEFAULT '0.00',
  PRIMARY KEY (`ma_don_hang`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_hang`
--

LOCK TABLES `don_hang` WRITE;
/*!40000 ALTER TABLE `don_hang` DISABLE KEYS */;
INSERT INTO `don_hang` VALUES (1,1,NULL,NULL,'123 Lê Lợi, Q1, TP.HCM',120000.00,'delivered','cod','2025-10-30 08:31:01','Giao trước 12h','GIAM50K',50000.00),(2,2,NULL,NULL,'456 Nguyễn Huệ, Q1, TP.HCM',315000.00,'preparing','cod','2025-10-30 08:31:01','Không giao cuối tuần',NULL,0.00),(3,3,NULL,NULL,'789 Trần Hưng Đạo, Q5, TP.HCM',180000.00,'confirmed','cod','2025-10-30 08:31:01',NULL,'THANHVIEN10',18000.00),(4,NULL,'Võ Văn F','0916666666','111 Pasteur, Q3, TP.HCM',450000.00,'delivered','cod','2025-10-30 08:31:01','Khách vãng lai',NULL,0.00),(5,4,NULL,NULL,'321 Điện Biên Phủ, Q3, TP.HCM',560000.00,'cancelled','cod','2025-10-30 08:31:01','Khách hủy đơn',NULL,0.00),(6,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đông Thạnh, Thị xã Bình Minh, Tỉnh Vĩnh Long',100000.00,'pending','cod','2025-11-22 12:00:12',NULL,NULL,0.00),(7,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Long Mỹ, Huyện Giồng Trôm, Tỉnh Bến Tre',115000.00,'pending','cod','2025-11-22 13:04:18',NULL,NULL,0.00),(8,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',155000.00,'pending','cod','2025-11-22 13:06:11',NULL,NULL,0.00),(9,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:08:00',NULL,NULL,0.00),(10,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Đông Thuận, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:09:40',NULL,NULL,0.00),(11,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',155000.00,'pending','cod','2025-11-22 13:12:44',NULL,NULL,0.00),(12,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã An Ngãi Tây, Huyện Ba Tri, Tỉnh Bến Tre',115000.00,'pending','cod','2025-11-22 13:14:05',NULL,NULL,0.00),(13,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Ea Ral, Huyện Ea H\'leo, Tỉnh Đắk Lắk',115000.00,'pending','cod','2025-11-22 13:15:52',NULL,NULL,0.00),(14,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phú Quới, Huyện Long Hồ, Tỉnh Vĩnh Long',100000.00,'pending','cod','2025-11-22 13:18:06',NULL,NULL,0.00),(15,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tích Thiện, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:20:45',NULL,NULL,0.00),(16,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:26:21',NULL,NULL,0.00),(17,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Thị trấn Tân Quới, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:27:57',NULL,NULL,0.00),(18,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường 2, Thành phố Bảo Lộc, Tỉnh Lâm Đồng',110000.00,'pending','cod','2025-11-22 13:30:14',NULL,NULL,0.00),(19,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường 5, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:38:03',NULL,NULL,0.00),(20,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Bình Hòa Phước, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:39:49',NULL,NULL,0.00),(21,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:43:02',NULL,NULL,0.00),(22,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Thuận, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:46:39',NULL,NULL,0.00),(23,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hòa, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',110000.00,'pending','cod','2025-11-22 13:50:31',NULL,NULL,0.00),(24,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:50:55',NULL,NULL,0.00),(25,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Vĩnh Hòa, Huyện Ba Tri, Tỉnh Bến Tre',60000.00,'pending','cod','2025-11-22 13:51:55',NULL,NULL,0.00),(26,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Bình Hòa Phước, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:03:06',NULL,NULL,0.00),(27,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:14:27',NULL,NULL,0.00),(28,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',100000.00,'pending','cod','2025-11-22 14:17:36',NULL,NULL,0.00),(29,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thanh Đức, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:18:47',NULL,NULL,0.00),(30,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Hòa, Thị xã Bình Minh, Tỉnh Vĩnh Long',70000.00,'pending','cod','2025-11-22 14:20:19',NULL,NULL,0.00),(31,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ An, Huyện Mang Thít, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:25:21',NULL,NULL,0.00),(32,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Lộc, Huyện Tam Bình, Tỉnh Vĩnh Long',165000.00,'pending','cod','2025-11-22 14:31:54',NULL,NULL,0.00),(33,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:36:15',NULL,NULL,0.00),(34,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phú Quới, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'cancelled','cod','2025-11-22 14:47:44','\nKhách hàng hủy đơn',NULL,0.00),(35,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Phước, Huyện Mang Thít, Tỉnh Vĩnh Long',110000.00,'pending','cod','2025-11-22 14:56:07',NULL,NULL,0.00),(36,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',110000.00,'cancelled','cod','2025-11-23 12:52:04','\nKhách hàng hủy đơn',NULL,0.00),(37,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phong Phú, Huyện Cầu Kè, Tỉnh Trà Vinh',115000.00,'pending','cod','2025-11-23 13:00:02',NULL,NULL,0.00),(38,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',110000.00,'pending','cod','2025-11-23 13:03:17',NULL,NULL,0.00),(39,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường 4, Thành phố Trà Vinh, Tỉnh Trà Vinh',115000.00,'pending','cod','2025-11-23 14:47:33',NULL,NULL,0.00),(40,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 14:52:43',NULL,NULL,0.00),(41,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tân Long, Huyện Mang Thít, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 14:55:25',NULL,NULL,0.00),(42,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 14:58:44',NULL,NULL,0.00),(43,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã An Bình, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:03:43',NULL,NULL,0.00),(44,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã An Bình, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:07:26',NULL,NULL,0.00),(45,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phú Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:15:41',NULL,NULL,0.00),(46,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tân Bình, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:24:56',NULL,NULL,0.00),(47,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:26:35',NULL,NULL,0.00),(48,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Hòa, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'preparing','cod','2025-11-23 15:39:13',NULL,NULL,0.00),(49,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Đông Thuận, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'confirmed','cod','2025-11-23 15:40:54',NULL,NULL,0.00),(50,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Thị trấn Tân Quới, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'confirmed','cod','2025-11-23 15:47:23',NULL,NULL,0.00),(51,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đông Thành, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:03:30',NULL,NULL,0.00),(52,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:07:47',NULL,NULL,0.00),(53,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Đông Thuận, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:12:16',NULL,NULL,0.00),(54,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:19:37',NULL,NULL,0.00),(55,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:22:19',NULL,NULL,0.00),(56,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:30:05',NULL,NULL,0.00),(57,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:30:11',NULL,NULL,0.00),(58,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đông Thành, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-28 15:35:58',NULL,NULL,0.00),(59,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đồng Phú, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-28 15:40:56',NULL,NULL,0.00),(60,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tân Bình, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'delivered','cod','2025-11-28 15:43:20',NULL,NULL,0.00),(61,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thông Hòa, Huyện Cầu Kè, Tỉnh Trà Vinh',110000.00,'delivered','cod','2025-11-30 15:25:38',NULL,NULL,0.00),(62,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thông Hòa, Huyện Cầu Kè, Tỉnh Trà Vinh',165000.00,'delivered','cod','2025-11-30 15:26:16',NULL,NULL,0.00),(63,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thông Hòa, Huyện Cầu Kè, Tỉnh Trà Vinh',115000.00,'pending','cod','2025-11-30 15:27:04',NULL,NULL,0.00),(64,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thông Hòa, Huyện Cầu Kè, Tỉnh Trà Vinh',115000.00,'confirmed','cod','2025-11-30 15:28:12',NULL,NULL,0.00),(65,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thông Hòa, Huyện Cầu Kè, Tỉnh Trà Vinh',100000.00,'confirmed','cod','2025-12-02 09:37:46',NULL,NULL,0.00),(66,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thông Hòa, Huyện Cầu Kè, Tỉnh Trà Vinh',100000.00,'confirmed','cod','2025-12-02 09:44:22',NULL,NULL,0.00);
/*!40000 ALTER TABLE `don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `du_lieu_tim_kiem`
--

DROP TABLE IF EXISTS `du_lieu_tim_kiem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `du_lieu_tim_kiem` (
  `ma_tim_kiem` bigint NOT NULL AUTO_INCREMENT,
  `tu_khoa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ma_nguoi_dung` int DEFAULT NULL,
  `thoi_gian_tim` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_tim_kiem`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  KEY `tu_khoa` (`tu_khoa`),
  CONSTRAINT `du_lieu_tim_kiem_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `du_lieu_tim_kiem`
--

LOCK TABLES `du_lieu_tim_kiem` WRITE;
/*!40000 ALTER TABLE `du_lieu_tim_kiem` DISABLE KEYS */;
INSERT INTO `du_lieu_tim_kiem` VALUES (1,'cơm tấm',1,'2025-10-30 08:31:02'),(2,'lẩu mắm',2,'2025-10-30 08:31:02'),(3,'bánh xèo',3,'2025-10-30 08:31:02'),(4,'món chay',4,'2025-10-30 08:31:02'),(5,'gỏi cuốn',5,'2025-10-30 08:31:02'),(6,'cà phê',1,'2025-10-30 08:31:02'),(7,'chè',2,'2025-10-30 08:31:02'),(8,'hủ tiếu',NULL,'2025-10-30 08:31:02'),(9,'đồ uống',3,'2025-10-30 08:31:02'),(10,'khuyến mãi',NULL,'2025-10-30 08:31:02');
/*!40000 ALTER TABLE `du_lieu_tim_kiem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verification`
--

DROP TABLE IF EXISTS `email_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verification_code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_data` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON string chứa thông tin đăng ký tạm thời',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime NOT NULL,
  `is_verified` tinyint DEFAULT '0' COMMENT '0: Chưa xác thực, 1: Đã xác thực',
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `verification_code` (`verification_code`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verification`
--

LOCK TABLES `email_verification` WRITE;
/*!40000 ALTER TABLE `email_verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gio_hang`
--

DROP TABLE IF EXISTS `gio_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gio_hang` (
  `ma_gio_hang` int NOT NULL AUTO_INCREMENT,
  `ma_nguoi_dung` int NOT NULL,
  `thoi_gian_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` enum('active','ordered','abandoned') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  PRIMARY KEY (`ma_gio_hang`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `gio_hang_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gio_hang`
--

LOCK TABLES `gio_hang` WRITE;
/*!40000 ALTER TABLE `gio_hang` DISABLE KEYS */;
INSERT INTO `gio_hang` VALUES (1,1,'2025-10-30 08:31:01','active'),(2,2,'2025-10-30 08:31:01','ordered'),(3,3,'2025-10-30 08:31:01','active'),(4,4,'2025-10-30 08:31:01','active'),(5,5,'2025-10-30 08:31:01','abandoned'),(6,7,'2025-11-05 15:48:43','active'),(7,6,'2025-11-22 11:34:58','ordered'),(8,6,'2025-11-22 13:04:03','ordered'),(9,6,'2025-11-22 13:06:00','ordered'),(10,6,'2025-11-22 13:07:44','ordered'),(11,6,'2025-11-22 13:09:27','ordered'),(12,6,'2025-11-22 13:12:27','ordered'),(13,6,'2025-11-22 13:13:53','ordered'),(14,6,'2025-11-22 13:15:31','ordered'),(15,6,'2025-11-22 13:17:16','ordered'),(16,6,'2025-11-22 13:20:16','ordered'),(17,6,'2025-11-22 13:26:13','ordered'),(18,6,'2025-11-22 13:27:47','ordered'),(19,6,'2025-11-22 13:30:02','ordered'),(20,6,'2025-11-22 13:37:50','ordered'),(21,6,'2025-11-22 13:39:30','ordered'),(22,6,'2025-11-22 13:42:53','ordered'),(23,6,'2025-11-22 13:46:31','ordered'),(24,6,'2025-11-22 13:50:22','ordered'),(25,6,'2025-11-22 13:50:46','ordered'),(26,6,'2025-11-22 13:51:45','ordered'),(27,6,'2025-11-22 14:02:57','ordered'),(28,6,'2025-11-22 14:14:18','ordered'),(29,6,'2025-11-22 14:17:25','ordered'),(30,6,'2025-11-22 14:18:37','ordered'),(31,6,'2025-11-22 14:20:09','ordered'),(32,6,'2025-11-22 14:25:10','ordered'),(33,6,'2025-11-22 14:31:40','ordered'),(34,6,'2025-11-22 14:35:57','ordered'),(35,6,'2025-11-22 14:47:33','ordered'),(36,6,'2025-11-22 14:55:48','ordered'),(37,6,'2025-11-23 12:51:44','ordered'),(38,6,'2025-11-30 15:25:38','ordered'),(39,6,'2025-11-30 15:25:40','ordered'),(40,6,'2025-11-30 15:26:16','ordered'),(41,6,'2025-11-30 15:26:18','ordered'),(42,6,'2025-11-30 15:30:58','ordered'),(43,6,'2025-12-02 09:45:46','active'),(44,8,'2025-12-06 15:46:58','active');
/*!40000 ALTER TABLE `gio_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoa_don`
--

DROP TABLE IF EXISTS `hoa_don`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoa_don` (
  `ma_hoa_don` int NOT NULL AUTO_INCREMENT,
  `ma_don_hang` int NOT NULL,
  `ma_thanh_toan` int DEFAULT NULL,
  `ma_nguoi_dat` int DEFAULT NULL,
  `tong_tien` decimal(14,2) NOT NULL,
  `thoi_diem_xuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` enum('issued','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'issued',
  PRIMARY KEY (`ma_hoa_don`),
  KEY `ma_don_hang` (`ma_don_hang`),
  KEY `ma_thanh_toan` (`ma_thanh_toan`),
  KEY `ma_nguoi_dat` (`ma_nguoi_dat`),
  CONSTRAINT `hoa_don_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE,
  CONSTRAINT `hoa_don_ibfk_2` FOREIGN KEY (`ma_thanh_toan`) REFERENCES `thanh_toan` (`ma_thanh_toan`) ON DELETE SET NULL,
  CONSTRAINT `hoa_don_ibfk_3` FOREIGN KEY (`ma_nguoi_dat`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoa_don`
--

LOCK TABLES `hoa_don` WRITE;
/*!40000 ALTER TABLE `hoa_don` DISABLE KEYS */;
INSERT INTO `hoa_don` VALUES (1,1,1,1,120000.00,'2025-10-30 08:31:01','issued'),(2,2,2,2,315000.00,'2025-10-30 08:31:01','issued'),(3,3,3,3,180000.00,'2025-10-30 08:31:01','issued'),(4,4,4,NULL,450000.00,'2025-10-30 08:31:01','issued'),(5,5,5,4,560000.00,'2025-10-30 08:31:01','cancelled'),(6,6,6,6,100000.00,'2025-11-22 12:00:12','issued'),(7,7,7,6,115000.00,'2025-11-22 13:04:18','issued'),(8,8,8,6,155000.00,'2025-11-22 13:06:11','issued'),(9,9,10,6,115000.00,'2025-11-22 13:08:00','issued'),(10,10,12,6,115000.00,'2025-11-22 13:09:40','issued'),(11,11,14,6,155000.00,'2025-11-22 13:12:44','issued'),(12,12,16,6,115000.00,'2025-11-22 13:14:05','issued'),(13,13,18,6,115000.00,'2025-11-22 13:15:52','issued'),(14,14,20,6,100000.00,'2025-11-22 13:18:06','issued'),(15,15,22,6,115000.00,'2025-11-22 13:20:45','issued'),(16,16,24,6,115000.00,'2025-11-22 13:26:22','issued'),(17,17,26,6,115000.00,'2025-11-22 13:27:57','issued'),(18,18,28,6,110000.00,'2025-11-22 13:30:14','issued'),(19,19,30,6,115000.00,'2025-11-22 13:38:03','issued'),(20,20,32,6,115000.00,'2025-11-22 13:39:49','issued'),(21,21,34,6,115000.00,'2025-11-22 13:43:02','issued'),(22,22,36,6,115000.00,'2025-11-22 13:46:39','issued'),(23,23,38,6,110000.00,'2025-11-22 13:50:31','issued'),(24,24,40,6,115000.00,'2025-11-22 13:50:55','issued'),(25,25,41,6,60000.00,'2025-11-22 13:51:55','issued'),(26,26,43,6,115000.00,'2025-11-22 14:03:06','issued'),(27,27,45,6,115000.00,'2025-11-22 14:14:27','issued'),(28,28,47,6,100000.00,'2025-11-22 14:17:36','issued'),(29,29,49,6,115000.00,'2025-11-22 14:18:47','issued'),(30,30,51,6,70000.00,'2025-11-22 14:20:19','issued'),(31,31,53,6,115000.00,'2025-11-22 14:25:21','issued'),(32,32,55,6,165000.00,'2025-11-22 14:31:54','issued'),(33,33,57,6,115000.00,'2025-11-22 14:36:15','issued'),(34,34,59,6,115000.00,'2025-11-22 14:47:44','cancelled'),(35,35,61,6,110000.00,'2025-11-22 14:56:07','issued'),(36,36,66,6,110000.00,'2025-11-23 12:52:04','cancelled'),(37,37,68,6,115000.00,'2025-11-23 13:00:02','issued'),(38,38,69,6,110000.00,'2025-11-23 13:03:17','issued'),(39,39,70,6,115000.00,'2025-11-23 14:47:33','issued'),(40,40,72,6,115000.00,'2025-11-23 14:52:43','issued'),(41,41,74,6,115000.00,'2025-11-23 14:55:25','issued'),(42,42,76,6,115000.00,'2025-11-23 14:58:44','issued'),(43,43,78,6,115000.00,'2025-11-23 15:03:43','issued'),(44,44,80,6,115000.00,'2025-11-23 15:07:26','issued'),(45,45,82,6,115000.00,'2025-11-23 15:15:41','issued'),(46,46,84,6,115000.00,'2025-11-23 15:24:56','issued'),(47,47,86,6,115000.00,'2025-11-23 15:26:35','issued'),(48,48,88,6,115000.00,'2025-11-23 15:39:13','issued'),(49,49,90,6,115000.00,'2025-11-23 15:40:54','issued'),(50,50,92,6,115000.00,'2025-11-23 15:47:23','issued'),(51,51,94,6,115000.00,'2025-11-23 16:03:30','issued'),(52,52,96,6,115000.00,'2025-11-23 16:07:47','issued'),(53,53,98,6,115000.00,'2025-11-23 16:12:16','issued'),(54,54,100,6,115000.00,'2025-11-23 16:19:37','issued'),(55,55,101,6,115000.00,'2025-11-23 16:22:19','issued'),(56,56,102,6,115000.00,'2025-11-23 16:30:05','issued'),(57,57,103,6,115000.00,'2025-11-23 16:30:11','issued'),(58,58,104,6,115000.00,'2025-11-28 15:35:58','issued'),(59,59,105,6,115000.00,'2025-11-28 15:40:56','issued'),(60,60,106,6,115000.00,'2025-11-28 15:43:20','issued'),(61,61,107,6,110000.00,'2025-11-30 15:25:38','issued'),(62,62,108,6,165000.00,'2025-11-30 15:26:16','issued'),(63,63,109,6,115000.00,'2025-11-30 15:27:04','issued'),(64,64,110,6,115000.00,'2025-11-30 15:28:12','issued'),(65,65,111,6,100000.00,'2025-12-02 09:37:46','issued'),(66,66,112,6,100000.00,'2025-12-02 09:44:22','issued');
/*!40000 ALTER TABLE `hoa_don` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khuyen_mai`
--

DROP TABLE IF EXISTS `khuyen_mai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khuyen_mai` (
  `ma_khuyen_mai` int NOT NULL AUTO_INCREMENT,
  `ma_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` text COLLATE utf8mb4_unicode_ci,
  `loai_giam_gia` enum('percentage','fixed_amount') COLLATE utf8mb4_unicode_ci NOT NULL,
  `gia_tri` decimal(10,2) NOT NULL,
  `don_hang_toi_thieu` decimal(12,2) DEFAULT '0.00',
  `ngay_bat_dau` datetime NOT NULL,
  `ngay_ket_thuc` datetime NOT NULL,
  `so_luong_gioi_han` int DEFAULT NULL,
  `so_luong_da_dung` int DEFAULT '0',
  `trang_thai` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ma_khuyen_mai`),
  UNIQUE KEY `ma_code` (`ma_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khuyen_mai`
--

LOCK TABLES `khuyen_mai` WRITE;
/*!40000 ALTER TABLE `khuyen_mai` DISABLE KEYS */;
INSERT INTO `khuyen_mai` VALUES (1,'KHAI_TRUONG','Khuyến mãi khai trương - Giảm 20%','percentage',20.00,100000.00,'2025-01-01 00:00:00','2025-12-31 23:59:59',1000,0,1),(2,'GIAM50K','Giảm ngay 50K cho đơn hàng từ 300K','fixed_amount',50000.00,300000.00,'2025-01-01 00:00:00','2025-12-31 23:59:59',500,0,1),(3,'THANHVIEN10','Ưu đãi thành viên - Giảm 10%','percentage',10.00,0.00,'2025-01-01 00:00:00','2025-12-31 23:59:59',NULL,0,1),(4,'FREESHIP','Miễn phí giao hàng','fixed_amount',30000.00,150000.00,'2025-01-01 00:00:00','2025-12-31 23:59:59',2000,0,1),(5,'CUOITUAN','Khuyến mãi cuối tuần - Giảm 15%','percentage',15.00,200000.00,'2025-01-01 00:00:00','2025-12-31 23:59:59',300,0,1);
/*!40000 ALTER TABLE `khuyen_mai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_su_chat`
--

DROP TABLE IF EXISTS `lich_su_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lich_su_chat` (
  `ma_tin_nhan` int NOT NULL AUTO_INCREMENT,
  `ma_nguoi_dung` int DEFAULT NULL,
  `userchat` varchar(150) DEFAULT NULL,
  `noi_dung_chat` text NOT NULL,
  `thoi_diem_chat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_tin_nhan`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `lich_su_chat_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_chat`
--

LOCK TABLES `lich_su_chat` WRITE;
/*!40000 ALTER TABLE `lich_su_chat` DISABLE KEYS */;
INSERT INTO `lich_su_chat` VALUES (1,1,'Nguyen Van A','Nhà hàng còn bàn trống cho 5 người không?','2025-09-09 23:24:24'),(2,2,'Tran Thi B','Tôi muốn đặt 2 phần bánh xèo','2025-09-09 23:24:24');
/*!40000 ALTER TABLE `lich_su_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_su_chatbot`
--

DROP TABLE IF EXISTS `lich_su_chatbot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lich_su_chatbot` (
  `ma_tin_nhan` int NOT NULL AUTO_INCREMENT,
  `ma_nguoi_dung` int DEFAULT NULL,
  `session_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nguoi_gui` enum('user','bot') COLLATE utf8mb4_unicode_ci NOT NULL,
  `noi_dung` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `thoi_diem_chat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_tin_nhan`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `lich_su_chatbot_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_chatbot`
--

LOCK TABLES `lich_su_chatbot` WRITE;
/*!40000 ALTER TABLE `lich_su_chatbot` DISABLE KEYS */;
INSERT INTO `lich_su_chatbot` VALUES (1,1,'SESSION_001','user','Cho tôi xem menu món chính','2025-10-30 08:31:01'),(2,1,'SESSION_001','bot','Dạ, đây là danh sách các món chính: Cơm Tấm Sườn Bì Chả, Hủ Tiếu Nam Vang, Bánh Xèo Miền Tây...','2025-10-30 08:31:01'),(3,2,'SESSION_002','user','Món nào dưới 50k?','2025-10-30 08:31:01'),(4,2,'SESSION_002','bot','Các món dưới 50k gồm: Hủ Tiếu Nam Vang (40k), Bánh Xèo Miền Tây (35k), Gỏi Cuốn (30k)...','2025-10-30 08:31:01'),(5,3,'SESSION_003','user','Nhà hàng có giao hàng không?','2025-10-30 08:31:01'),(6,3,'SESSION_003','bot','Có ạ, chúng tôi có dịch vụ giao hàng tận nơi. Miễn phí ship cho đơn từ 150k','2025-10-30 08:31:01'),(7,4,'SESSION_004','user','Làm sao để đặt bàn?','2025-10-30 08:31:01'),(8,4,'SESSION_004','bot','Quý khách có thể đặt bàn qua website hoặc gọi hotline: 1900-xxxx','2025-10-30 08:31:01'),(9,5,'SESSION_005','user','Có khuyến mãi gì không?','2025-10-30 08:31:01'),(10,5,'SESSION_005','bot','Hiện tại có mã KHAI_TRUONG giảm 20% và GIAM50K giảm 50k cho đơn từ 300k ạ','2025-10-30 08:31:01'),(11,NULL,'session_1764580751758_bb3gh4cq0','user','1 + 1 bằng mấy','2025-12-01 16:20:31'),(12,NULL,'session_1764580751758_bb3gh4cq0','bot','Xin chào! Tôi là trợ lý của Nhà hàng Ẩm thực Phương Nam. Bạn cần hỗ trợ đặt bàn, xem thực đơn hay đặt món ăn miền Tây nào ạ? ? Gọi hotline 0123 456 789 nhé!','2025-12-01 16:20:31'),(13,NULL,'session_1764580751758_bb3gh4cq0','user','hi','2025-12-01 16:23:58'),(14,NULL,'session_1764580751758_bb3gh4cq0','bot','Xin chào! ? Chào mừng anh/chị đến với Nhà hàng Ẩm thực Phương Nam. Anh/chị cần đặt bàn, xem thực đơn hay hỗ trợ gì ạ? ?','2025-12-01 16:23:58'),(15,NULL,'session_1764580751758_bb3gh4cq0','user','Xem thực đơn','2025-12-01 16:24:24'),(16,NULL,'session_1764580751758_bb3gh4cq0','bot','Chào bạn! ? Thực đơn Nhà hàng Ẩm thực Phương Nam chuyên món miền Tây như lẩu mắm, cá lóc nướng trui, bún nước lèo, bánh xèo... Để xem chi tiết giá cả và hình ảnh, gọi hotline 0123 456 789 nhé! Bạn muốn đặt bàn hay giao hàng ạ? ?','2025-12-01 16:24:24'),(17,NULL,'session_1764581231445_9oq1r815z','user','hi','2025-12-01 16:27:26'),(18,NULL,'session_1764581231445_9oq1r815z','bot','Xin chào quý khách! ?  \nChào mừng đến Nhà hàng Ẩm thực Phương Nam. Quý khách cần đặt bàn, xem thực đơn hay giao hàng ạ?','2025-12-01 16:27:26'),(19,NULL,'session_1764581231445_9oq1r815z','user','Địa chỉ nhà hàng','2025-12-01 16:27:51'),(20,NULL,'session_1764581231445_9oq1r815z','bot','Nhà hàng Ẩm thực Phương Nam tại 123 Đường ABC, Phường 1, TP. Vĩnh Long, Việt Nam. ?  \nQuý khách cần đặt bàn hay hỗ trợ gì thêm ạ? ?','2025-12-01 16:27:51'),(21,NULL,'session_1764591604423_2ufqb0be0','user','hi','2025-12-01 19:20:20'),(22,NULL,'session_1764591604423_2ufqb0be0','bot','Xin chào! ? Chào mừng bạn đến Nhà hàng Ẩm thực Phương Nam. Bạn cần đặt bàn, xem thực đơn hay hỗ trợ gì ạ? ?','2025-12-01 19:20:20'),(23,NULL,'session_1764591726149_40f8s50f3','user','hi','2025-12-01 19:22:37'),(24,NULL,'session_1764591726149_40f8s50f3','bot','Xin chào! ? Chào mừng bạn đến Nhà hàng Ẩm thực Phương Nam. Bạn cần đặt bàn, xem thực đơn hay hỗ trợ gì ạ? ?','2025-12-01 19:22:37'),(25,NULL,'session_1764593994530_atpiq7ux6','user','hi Trà My','2025-12-01 20:03:10'),(26,NULL,'session_1764593994530_atpiq7ux6','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! ?  \nAnh/chị khỏe không ạ? Em sẵn sàng tư vấn món ngon miền Tây nha ? ?','2025-12-01 20:03:23'),(27,6,'session_1764593994530_atpiq7ux6','user','có món gì nhậu được không My','2025-12-01 20:13:09'),(28,6,'session_1764593994530_atpiq7ux6','bot','Dạ anh ơi, nhà em có nhiều món nhậu ngon miền Tây lắm nha! ? Như Cà Nướng Mỡ Hành 70k/con, Tôm Nướng Mật Ong 80k/xiên, Đuồi Gà Chiên 55k/dĩa hay Gỏi Heo Xủa Hành 50k/dĩa siêu hợp bia rượu luôn ạ ??. Anh đặt bàn qua hotline 0123 456 789 nhé ?','2025-12-01 20:13:28'),(29,6,'session_1764593994530_atpiq7ux6','user','hi','2025-12-01 20:18:54'),(30,6,'session_1764593994530_atpiq7ux6','bot','Dạ chào anh/chị ạ! ? Em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam đây ạ! ? Anh/chị muốn em tư vấn món ngon miền Tây hay đặt bàn nha? ?','2025-12-01 20:19:05'),(31,6,'session_1764595163201_ysg9witi6','user','Giờ mở cửa','2025-12-01 20:20:06'),(32,6,'session_1764595163201_ysg9witi6','bot','Dạ nhà hàng em mở cửa từ 10:00 - 22:00 hàng ngày ạ! Anh/chị ghé thăm em nhé ? ?','2025-12-01 20:20:12'),(33,6,'session_1764595498151_jba9tnkwz','user','hi My, quán mình có Đào phục vụ hông','2025-12-01 20:25:12'),(34,6,'session_1764595498151_jba9tnkwz','bot','Dạ hi anh ạ! ? Em là Trà My, trợ lý ảo dễ thương của Nhà hàng Ẩm thực Phương Nam nha ?. Nhà hàng có đội ngũ phục vụ chu đáo lắm ạ, anh muốn đặt bàn hay gọi món gì em tư vấn nhé! ?','2025-12-01 20:25:26'),(35,6,'session_1764595498151_jba9tnkwz','user','mấy cô gái trẻ trẻ phục vụ á, có hông','2025-12-01 20:25:46'),(36,6,'session_1764595498151_jba9tnkwz','bot','Dạ em là Trà My, tiếp viên ảo siêu dễ thương của nhà hàng đây ạ, sẵn sàng phục vụ anh tận tình luôn nha ?? Anh ghé Ẩm thực Phương Nam thưởng thức món lẩu mắm miền Tây nhé, giảm 10% đặt bàn online luôn ạ! ?','2025-12-01 20:25:51'),(37,NULL,'session_1764595692721_ob7seo2tq','user','chủ nhà  hàng tên gì','2025-12-01 21:39:52'),(38,NULL,'session_1764595692721_ob7seo2tq','bot','Dạ em không rõ thông tin về chủ nhà hàng ạ ?. Anh/chị muốn em giới thiệu món ngon miền Tây hay đặt bàn nha? ??','2025-12-01 21:40:00'),(39,NULL,'session_1764595692721_ob7seo2tq','user','chủ nhà hàng là ai','2025-12-01 21:42:47'),(40,NULL,'session_1764595692721_ob7seo2tq','bot','Dạ em không rõ thông tin về chủ nhà hàng ạ ? Anh/chị gọi hotline 0123 456 789 để hỏi thêm nhé ? Em sẵn sàng giới thiệu món ngon miền Tây cho anh/chị đây ạ! ?','2025-12-01 21:42:55'),(41,NULL,'session_1764595692721_ob7seo2tq','user','chủ nhà hàng tên gì','2025-12-01 21:45:50'),(42,NULL,'session_1764595692721_ob7seo2tq','bot','Dạ em không có thông tin về chủ nhà hàng ạ ?. Anh/chị muốn em tư vấn món ngon miền Tây hay đặt bàn qua hotline 0388853044 nha? ??','2025-12-01 21:46:04'),(43,NULL,'session_1764595692721_ob7seo2tq','user','xin địa chỉ đi MY','2025-12-01 21:47:04'),(44,NULL,'session_1764595692721_ob7seo2tq','bot','Dạ địa chỉ nhà hàng em là 168, Ấp Phú Hòa, Phường Long Đức, Tỉnh Vĩnh Long ạ! ? Anh/chị ghé chơi nhé, em chờ anh/chị nha ? Hotline: 0388853044! ?','2025-12-01 21:47:14'),(45,NULL,'session_1764595692721_ob7seo2tq','user','cho tôi hỏi chủ nhà hàng tên gì','2025-12-01 21:48:39'),(46,NULL,'session_1764595692721_ob7seo2tq','bot','Dạ chủ nhà hàng em là chị Hoàng Thục Linh ạ, chị ấy có 10 năm kinh nghiệm và là người sáng lập luôn đó anh! ? Chị Linh rất tận tâm với ẩm thực miền Tây nha ? Anh cần hỏi thêm gì nữa không ạ? ?','2025-12-01 21:48:48'),(47,NULL,'session_1764638411550_casf8xg5a','user','hi','2025-12-02 08:20:11'),(48,NULL,'session_1764638411550_casf8xg5a','bot','Dạ chào anh/chị ạ! Em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam đây ạ ??  \nAnh/chị cần em tư vấn món ngon hay đặt bàn nhé? ?','2025-12-02 08:20:23'),(49,NULL,'session_1764638411550_casf8xg5a','user','quán mình có món gì lai rai không','2025-12-02 08:21:00'),(50,NULL,'session_1764638411550_casf8xg5a','bot','Dạ anh ơi, quán em có mấy món lai rai siêu ngon như Gỏi Miền Tây (40k), Tép Rong Cháy Sả (40k), Cá Nướng Mỡ Hành (70k/con) hay Tôm Nướng Mật Ong (80k/xiên) nha! ?? Anh thử gọi hotline 0388853044 đặt bàn hoặc giao hàng nhé ??','2025-12-02 08:21:12'),(51,NULL,'session_1764638411550_casf8xg5a','user','cho tôi xem ảnh chị Linh','2025-12-02 08:21:50'),(52,NULL,'session_1764638411550_casf8xg5a','bot','Dạ anh ơi, chị Hoàng Thục Linh là chủ nhà hàng của em, với 10 năm kinh nghiệm sáng lập và điều hành ạ! ? Em không có ảnh trực tiếp được gửi ở đây, anh ghé website https://amthucphuongnam.com hoặc gọi hotline 0388853044 để xem thêm nha ?. Anh muốn đặt bàn hay hỏi món gì khác không ạ? ?','2025-12-02 08:21:59'),(53,NULL,'session_1764638411550_casf8xg5a','user','chủ nhà hàng tên gì','2025-12-02 08:46:42'),(54,NULL,'session_1764638411550_casf8xg5a','bot','Dạ chủ nhà hàng em là chị Hoàng Thục Linh ạ, chị ấy có 10 năm kinh nghiệm và là người sáng lập luôn nha ? ? Anh/chị muốn biết thêm về đội ngũ hay món ăn gì nữa không ạ? ?','2025-12-02 08:46:49'),(55,6,'session_1764642568246_7qyg0v886','user','hi','2025-12-02 09:29:35'),(56,6,'session_1764642568246_7qyg0v886','bot','Dạ chào anh/chị ạ! Em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam nha ? ?  \nAnh/chị cần em tư vấn món ngon hay đặt bàn gì ạ? ?','2025-12-02 09:29:47'),(57,6,'session_1764642568246_7qyg0v886','user','hôm nay trời lạnh, ăn gì cho ấm áp nhỉ','2025-12-02 09:32:15'),(58,6,'session_1764642568246_7qyg0v886','bot','Dạ anh/chị ơi, trời lạnh thì em recommend lẩu ấm bụng nha! ?️? Lẩu Mắm Miền Tây 270k/nồi hay Lẩu Rau Đồng 180k/nồi siêu ngon, ấm áp lắm ạ ?. Anh/chị đặt bàn qua hotline 0388853044 nhé! ?','2025-12-02 09:32:28'),(59,6,'session_1764642568246_7qyg0v886','user','đầu bếp mình tên gì nhỉ','2025-12-02 09:33:17'),(60,6,'session_1764642568246_7qyg0v886','bot','Dạ đầu bếp trưởng của nhà hàng em là anh Nguyễn Nhật Trường với 20 năm kinh nghiệm ạ! ? Anh ấy chịu trách nhiệm toàn bộ món ăn siêu ngon luôn nha ? ?','2025-12-02 09:33:25'),(61,6,'session_1764642568246_7qyg0v886','user','em đi với số lượng 10 người, vậy mỗi món em cần đặt bao nhiêu phần mới đủ ạ,','2025-12-02 09:34:10'),(63,6,'session_1764900206462_4an09yo9i','user','bữa nay trời nóng ăn gì','2025-12-05 09:03:26'),(64,6,'session_1764900206462_4an09yo9i','user','bữa nay trời nóng ăn gì','2025-12-05 09:07:18'),(65,6,'session_1764900488139_c98g4rk7j','user','hi','2025-12-05 09:08:10'),(66,6,'session_1764900488139_c98g4rk7j','user','hi','2025-12-05 09:09:03'),(67,6,'session_1764900488139_c98g4rk7j','user','hi','2025-12-05 09:09:14'),(68,NULL,'session_1764917576920_aphe3892i','user','hi','2025-12-05 13:52:56'),(69,NULL,'session_1764917576920_aphe3892i','user','Giờ mở cửa','2025-12-05 13:53:37'),(70,NULL,'session_1764917576920_aphe3892i','user','hi','2025-12-05 14:12:34'),(71,NULL,'session_1764917576920_aphe3892i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! ?','2025-12-05 14:12:36'),(72,NULL,'session_1764917576920_aphe3892i','user','hello','2025-12-05 14:16:15'),(73,NULL,'session_1764917576920_aphe3892i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! ?','2025-12-05 14:16:18'),(74,NULL,'session_1764917576920_aphe3892i','user','chủ nhà hàng tên gì','2025-12-05 14:16:50'),(75,NULL,'session_1764917576920_aphe3892i','user','hi','2025-12-05 14:21:09'),(76,NULL,'session_1764917576920_aphe3892i','user','hi','2025-12-05 14:26:56'),(77,NULL,'session_1764917576920_aphe3892i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! ? Chào anh/chị, hôm nay anh/chị cần hỗ trợ gì không ạ? ?','2025-12-05 14:26:57'),(78,NULL,'session_1764917576920_aphe3892i','user','nay trời nóng quá ăn gì cho mát vậy My','2025-12-05 14:27:14'),(79,NULL,'session_1764917576920_aphe3892i','bot','Dạ anh/chị ạ, trời nóng thì em nghĩ món Gỏi Miền Tây hoặc Gỏi Heo Xủa Hành sẽ rất hợp lý nha ?! Món này mát, dễ ăn và giá cả cũng rất hợp lý, chỉ từ 40.000đ đến 50.000đ/dĩa thôi ạ ?. Anh/chị có muốn em đặt món này không ạ? ?','2025-12-05 14:27:14'),(80,NULL,'session_1764917576920_aphe3892i','user','chủ nhà hàng tên gì','2025-12-05 14:27:42'),(81,NULL,'session_1764917576920_aphe3892i','bot','Dạ, chủ nhà hàng Ẩm thực Phương Nam tên là Hoàng Thục Linh ạ, người sáng lập và điều hành nhà hàng với hơn 10 năm kinh nghiệm ?!','2025-12-05 14:27:43'),(82,NULL,'session_1764917576920_aphe3892i','user','trời nóng quá ăn gì cho mát','2025-12-05 14:28:04'),(83,NULL,'session_1764917576920_aphe3892i','bot','Dạ anh/chị ơi, trời nóng quá thì em nghĩ anh/chị nên thử món Gỏi Heo Xủa Hành hoặc Gỏi Miền Tây nha ?! Món này mát miệng, dễ ăn và rất phù hợp cho mùa hè này ạ ?. Hoặc nếu anh/chị thích món lẩu thì Lẩu Rau Đồng cũng là một lựa chọn tuyệt vời, vừa mát vừa tốt cho sức khỏe ạ ?!','2025-12-05 14:28:05'),(84,NULL,'session_1764917576920_aphe3892i','user','có món gì mát','2025-12-05 14:28:22'),(85,NULL,'session_1764917576920_aphe3892i','bot','Dạ anh/chị ạ, em có một số gợi ý về món ăn mát và ngon tại Nhà hàng Ẩm thực Phương Nam nha ?! Anh/chị có thể thử món Gỏi Heo Xúa Hành, Gỏi Miền Tây, hoặc Gỏi Ốc Đắng, đều là những món ăn mát và tươi ngon ạ ?. Hoặc nếu anh/chị muốn món gì đó nhẹ nhàng hơn, có thể thử món Rau Muống Xào Tỏi hoặc Trái Cây Tiệc Cưới nha ?!','2025-12-05 14:28:23'),(86,NULL,'session_1764917576920_aphe3892i','user','địa chỉ nhà hàng ở đâu vậy','2025-12-05 14:28:40'),(87,NULL,'session_1764917576920_aphe3892i','bot','Dạ địa chỉ của Nhà hàng Ẩm thực Phương Nam là 168, Ấp Phú Hòa, Phường Long Đức, Tỉnh Vĩnh Long ạ ?. Anh/chị có thể ghé thăm nhà hàng để trải nghiệm những món ăn miền Tây Nam Bộ ngon miệng và ấm cúng nha ?!','2025-12-05 14:28:41'),(88,NULL,'session_1764917576920_aphe3892i','user','Giờ mở cửa','2025-12-05 14:59:40'),(89,NULL,'session_1764917576920_aphe3892i','bot','Dạ, giờ mở cửa của Nhà hàng Ẩm thực Phương Nam như sau ạ:\n- Thứ 2 đến Thứ 6: 08:00-22:00\n- Thứ 7 và Chủ nhật: 07:00-23:00\nEm hy vọng thông tin này hữu ích cho anh/chị nha ?!','2025-12-05 14:59:41'),(90,NULL,'session_1764917576920_aphe3892i','user','Đặt bàn','2025-12-05 14:59:45'),(91,NULL,'session_1764917576920_aphe3892i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! Em rất vui được hỗ trợ anh/chị hôm nay ?. Anh/chị muốn đặt bàn tại Nhà hàng Ẩm thực Phương Nam phải không ạ? Anh/chị vui lòng cho em biết số lượng người và thời gian dự định đến nha ?. Anh/chị cũng có thể đặt bàn qua website hoặc hotline 0388853044 của nhà hàng ạ! ?','2025-12-05 14:59:45'),(92,NULL,'session_1764917576920_aphe3892i','user','5 người ăn nhiều đó','2025-12-05 15:00:02'),(93,NULL,'session_1764917576920_aphe3892i','bot','Dạ anh/chị muốn đặt bàn cho 5 người ăn à? Em có thể giúp anh/chị đặt bàn tại Nhà hàng Ẩm thực Phương Nam nha! Anh/chị có thể gọi hotline 0388853044 hoặc truy cập website https://amthucphuongnam.com để đặt bàn trước nhé! Em sẽ hỗ trợ anh/chị nhiệt tình nhất ạ ??','2025-12-05 15:00:03'),(94,NULL,'session_1764917576920_aphe3892i','user','nếu đi 5 người vậy 1 món kêu bao nhiêu phần mới đủ','2025-12-05 15:00:42'),(95,NULL,'session_1764917576920_aphe3892i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! Em rất vui được hỗ trợ anh/chị hôm nay ?\n\nNếu đi 5 người, anh/chị có thể gọi từ 2-3 món để mọi người cùng thưởng thức nha ?. Số phần cụ thể sẽ tùy thuộc vào món ăn và khẩu phần của mỗi người ạ. Anh/chị có thể tham khảo thực đơn của nhà hàng mình và gọi món theo ý thích nha ?. Ví dụ, nếu gọi món Cà Nướng Mỡ Hành, anh/chị có thể gọi 2-3 con để mọi người cùng thưởng thức ạ ?.','2025-12-05 15:00:43'),(96,NULL,'session_1764917576920_aphe3892i','user','có món lâu không cay trẻ em ăn được không','2025-12-05 15:01:06'),(97,NULL,'session_1764917576920_aphe3892i','bot','Dạ, nhà hàng mình có một số món lẩu không cay hoặc ít cay phù hợp với trẻ em nha ?. Anh/chị có thể tham khảo món Lẩu Rau Đồng hoặc Lẩu Thác Lác Khổ Qua, những món này đều không quá cay và rất ngon miệng cho trẻ em ạ ?. Giá của những món này cũng rất hợp lý, Lẩu Rau Đồng là 180.000đ/nồi và Lẩu Thác Lác Khổ Qua là 220.000đ/nồi nha ?.','2025-12-05 15:01:07'),(98,NULL,'session_1764917576920_aphe3892i','user','quán mình có mì xào không','2025-12-05 15:01:35'),(99,NULL,'session_1764917576920_aphe3892i','bot','Dạ hiện tại nhà hàng mình chưa có món mì xào ạ, anh/chị có thể gọi hotline 0388853044 để hỏi thêm nha ?. Nhưng anh/chị có thể tham khảo các món ăn ngon khác của nhà hàng như Cơm Chiên Cá Mặn, Cơm Chiên Hải Sản, hoặc các món lẩu như Lẩu Mắm Miền Tây, Lẩu Rau Đồng,... nha ?.','2025-12-05 15:01:36'),(100,NULL,'session_1764917576920_aphe3892i','user','trời nóng quá ăn món gì cho mát nhỉ','2025-12-05 15:01:55'),(101,NULL,'session_1764917576920_aphe3892i','bot','Dạ anh/chị ạ, trời nóng quá thì em nghĩ anh/chị nên thử món Gỏi Miền Tây hoặc Gỏi Ốc Đắng nha ?. Những món này mát lạnh, dễ ăn và rất hợp với thời tiết nắng nóng như này ạ ?. Hoặc nếu anh/chị thích món canh, thì Canh Gà Chiên cũng là một lựa chọn tuyệt vời, canh gà chiên có vị ngọt thanh, rất giúp anh/chị cảm thấy mát mẻ hơn ạ ?. Em hy vọng anh/chị sẽ tìm được món ăn合 ý nha ?!','2025-12-05 15:01:56'),(102,NULL,'session_1764917576920_aphe3892i','user','quán mình có trái cây gì','2025-12-05 15:09:10'),(103,NULL,'session_1764917576920_aphe3892i','bot','Dạ, quán mình có Trái Cây Tiệc Cưới ạ, giá 60.000đ/dĩa nha ?. Nếu anh/chị muốn biết thêm thông tin hoặc đặt hàng, có thể gọi hotline 0388853044 để được hỗ trợ thêm nhé ?!','2025-12-05 15:09:11'),(104,NULL,'session_1764917576920_aphe3892i','user','còn trái cây nào mát mát không','2025-12-05 15:09:26'),(105,NULL,'session_1764917576920_aphe3892i','bot','Dạ, anh/chị có thể thử món Trái Cây Tiệc Cưới của nhà hàng mình nha ??, với giá 60.000đ/dĩa ạ ?. Nếu anh/chị muốn biết thêm thông tin hoặc muốn đặt hàng, hãy gọi hotline 0388853044 nha ??!','2025-12-05 15:09:27'),(106,NULL,'session_1764917576920_aphe3892i','user','ở đây món nào được mua nhiều nhất','2025-12-05 15:10:31'),(107,NULL,'session_1764917576920_aphe3892i','bot','Dạ anh/chị ạ, ở Nhà hàng Ẩm thực Phương Nam, món Cà Nướng Mỡ Hành là một trong những món được khách hàng yêu thích và mua nhiều nhất ạ ?. Món này có giá 70.000đ/con và được chế biến bởi đầu bếp tận tâm của nhà hàng, đảm bảo hương vị đậm đà và tươi ngon ?. Nếu anh/chị muốn đặt món này, em có thể giúp anh/chị đặt hàng hoặc tư vấn thêm về thực đơn nha ?!','2025-12-05 15:10:31'),(108,NULL,'session_1764917576920_aphe3892i','user','hãy làm thơ','2025-12-05 15:10:46'),(109,NULL,'session_1764917576920_aphe3892i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! ?\nEm rất vui được hỗ trợ anh/chị hôm nay, với tâm hồn yêu thơ và ẩm thực nha ?\n\nNhà hàng Phương Nam, nơi ấm cúng và thân thiện,\nVới món ăn miền Tây, đậm đà và thơm ngon nhen ?\nCà nướng mỡ hành, cá ri ấn độ, và cơm chiên hải sản,\nLà những món ăn ngon, mà em muốn dành cho anh/chị nha ?\n\nBếp trưởng Nguyễn Nhật Trường, với kinh nghiệm 20 năm,\nLà người tạo ra những món ăn ngon, với bí quyết gia truyền nhen ?‍?\nQuản lý Hứa Thị Thảo Vy, với kinh nghiệm 8 năm,\nLà người quản lý vận hành, với tâm hồn nhiệt tình và chu đáo nha ?\n\nNhà hàng của chúng em, với không gian ấm cúng và trang trí phong cách truyền thống,\nLà nơi lý tưởng, để anh/chị thưởng thức ẩm thực miền Tây nha ?\nVậy anh/chị hãy đến, và trải nghiệm ẩm thực của chúng em,\nVới tâm hồn yêu thơ, và ẩm thực đậm đà quê nhà nha ?','2025-12-05 15:10:47'),(110,6,'session_1765001213491_di02a1cp3','user','hi','2025-12-06 13:06:53'),(111,6,'session_1765001213491_di02a1cp3','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! Em rất vui được hỗ trợ anh/chị hôm nay ?. Anh/chị cần hỗ trợ gì không ạ? ?','2025-12-06 13:06:54'),(112,NULL,'session_1765005589133_5f2c2b4j4','user','trời nóng quá uống gì cho mát','2025-12-06 14:19:49'),(113,NULL,'session_1765005589133_5f2c2b4j4','bot','Dạ anh/chị ạ, trời nóng quá thì em nghĩ anh/chị nên uống một ly nước ép dưa hấu mát lạnh nha ??! Giá của nước ép dưa hấu là 30.000đ/suất ạ. Hoặc anh/chị cũng có thể thử trà canh mùa hạ, cũng rất mát và tốt cho sức khỏe đó ạ ??! Giá của trà canh mùa hạ là 20.000đ/suất nha ?.','2025-12-06 14:19:51'),(114,8,'session_1765005589133_5f2c2b4j4','user','trời lạnh có món gì ăn ấm áp khônng hén','2025-12-06 16:00:13'),(115,8,'session_1765005589133_5f2c2b4j4','bot','Dạ, trời lạnh thì anh/chị nên thử món Cơm cháy kho quẹt hoặc Lẩu Mắm Miền Tây của nhà hàng mình nha ?! Món Cơm cháy kho quẹt có giá 300.000đ/suất, còn Lẩu Mắm Miền Tây có giá 270.000đ/nồi, cả hai món đều rất ấm áp và thơm ngon, chắc chắn sẽ làm anh/chị cảm thấy ấm áp hơn trong ngày lạnh ?✨!','2025-12-06 16:00:14'),(116,8,'session_1765005589133_5f2c2b4j4','user','hướng dẫn làm món cơm cháy','2025-12-06 16:00:38'),(117,8,'session_1765005589133_5f2c2b4j4','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! Em rất vui được hỗ trợ anh/chị hôm nay ?\n\nĐể làm món cơm cháy, anh/chị có thể tham khảo công thức sau:\n\nNguyên liệu:\n- 2 chén cơm nguội\n- 1/2 chén nước\n- 1/4 chén dầu ăn\n- 1 thìa cà phê muối\n- 1 thìa cà phê đường\n- 1 thìa cà phê hạt nêm\n- 1/2 thìa cà phê tiêu\n- 2 quả trứng gà\n- 1 củ hành tím, băm nhỏ\n- 1 củ tỏi, băm nhỏ\n- 1/2 chén nước mắm\n- 1/4 chén giấm\n- 1/4 chén đường\n- 1/4 chén nước lọc\n- Rau sống (xà lách, rau mùi, rau quế)\n\nCách làm:\n1. Trộn cơm nguội với nước, dầu ăn, muối, đường, hạt nêm, tiêu trong một bát lớn.\n2. Đập trứng gà vào bát và trộn đều.\n3. Thêm hành tím, tỏi băm nhỏ vào bát và trộn đều.\n4. Nặn cơm thành hình chữ nhật hoặc hình tròn, tùy ý.\n5. Đun nóng dầu ăn trong chảo','2025-12-06 16:00:40'),(118,NULL,'session_1765160910104_25ivqxo1i','user','hi','2025-12-08 09:28:30'),(119,NULL,'session_1765160910104_25ivqxo1i','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! Em rất vui được hỗ trợ anh/chị hôm nay ?. Anh/chị cần hỗ trợ gì không ạ?','2025-12-08 09:28:30'),(120,NULL,'session_1765160910104_25ivqxo1i','user','hôm nay là thứ mấy','2025-12-08 09:28:42'),(121,NULL,'session_1765160910104_25ivqxo1i','bot','Dạ hôm nay là thứ 2 ạ! ?','2025-12-08 09:28:43'),(122,NULL,'session_1765160910104_25ivqxo1i','user','trời nóng quá ăn gì cho mát nhỉ','2025-12-08 09:28:54'),(123,NULL,'session_1765160910104_25ivqxo1i','bot','Dạ anh/chị ạ, trời nóng quá thì ăn gì cho mát là câu hỏi hay nhỉ ?? Em nghĩ anh/chị có thể thử món \"Gỏi Heo Xứ Hàn\" hoặc \"Gỏi Miền Tây\" của nhà hàng mình nha, cả hai món đều rất mát và ngon miệng ?. Hoặc nếu anh/chị thích đồ uống thì có thể thử \"Trà dâu tầm\" hoặc \"Nước ép dưa hấu\" cũng rất mát và tốt cho sức khỏe ?. Em hy vọng anh/chị sẽ tìm được món ăn phù hợp cho ngày nóng này ạ ?!','2025-12-08 09:28:55'),(124,NULL,'session_1765160910104_25ivqxo1i','user','quán có món gì dân dã miền tây không','2025-12-08 09:51:43'),(125,NULL,'session_1765160910104_25ivqxo1i','bot','Dạ, quán Nhà hàng Ẩm thực Phương Nam của em có rất nhiều món dân dã miền Tây ngon và hấp dẫn ạ! ??\n\nEm có thể giới thiệu một số món như: Bánh tét Miền tây, Cơm cháy kho quẹt, Gỏi Miền Tây, Bánh Xèo miền, Cà Nướng Mỡ Hành,... Những món này đều là đặc sản của miền Tây và được chế biến bởi đầu bếp tận tâm của nhà hàng ạ! ?\n\nAnh/chị có thể xem thực đơn của quán để biết thêm nhiều món dân dã miền Tây khác nha! ??‍?','2025-12-08 09:51:44'),(126,NULL,'session_1765160910104_25ivqxo1i','user','bánh á','2025-12-08 09:51:58'),(127,NULL,'session_1765160910104_25ivqxo1i','bot','Dạ, hiện tại nhà hàng mình chưa có món \"bánh á\" này ạ, anh/chị có thể gọi hotline 0388853044 để hỏi thêm nha ?','2025-12-08 09:51:58'),(128,NULL,'session_1765160910104_25ivqxo1i','user','chủ nhà hàng tên gì','2025-12-08 09:52:14'),(129,NULL,'session_1765160910104_25ivqxo1i','bot','Dạ, chủ nhà hàng Ẩm thực Phương Nam tên là Hoàng Thục Linh ạ! ?','2025-12-08 09:52:15'),(130,NULL,'session_1765162352141_hap563y2r','user','Giờ mở cửa','2025-12-08 09:52:33'),(131,NULL,'session_1765162352141_hap563y2r','bot','Dạ, giờ mở cửa của Nhà hàng Ẩm thực Phương Nam như sau ạ:\n- Thứ 2 đến Thứ 6: 08:00-22:00\n- Thứ 7 và Chủ nhật: 07:00-23:00 nha ?','2025-12-08 09:52:35'),(132,NULL,'session_1765162352141_hap563y2r','user','quán mình có combo gì nhỉ','2025-12-08 09:54:10'),(133,NULL,'session_1765162352141_hap563y2r','bot','Dạ em có 2 combo hấp dẫn cho anh/chị nha ??:\n\n1. ComBo ấm áp: 1.000.000đ/suất ạ ?\n2. Combo măm cơm gia đình: 1.000.000đ/suất ạ ?\n\nEm cũng có combo giá rẻ hơn là Combo gia đình tiết kiệm từ 299.000đ nha ?\n\nAnh/chị muốn biết thêm thông tin về các combo này không ạ? ?','2025-12-08 09:54:11'),(134,8,'session_1765163786979_v061tvkm5','user','hi','2025-12-08 10:16:27'),(135,8,'session_1765163786979_v061tvkm5','bot','Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! Em rất vui được hỗ trợ anh/chị hôm nay ?','2025-12-08 10:16:27'),(136,8,'session_1765163786979_v061tvkm5','user','lẩu ăn với gì nhỉ','2025-12-08 10:16:36'),(137,8,'session_1765163786979_v061tvkm5','bot','Dạ anh/chị ạ, lẩu ăn với rất nhiều món ngon và đa dạng nha ?. Anh/chị có thể ăn lẩu với các loại rau như rau muống, rau cải, rau ngót,... hoặc các loại hải sản như tôm, mực, cá,... Ngoài ra, anh/chị cũng có thể ăn lẩu với các loại thịt như thịt bò, thịt heo, thịt gà,... và các loại bánh mì, bún, phở,... tùy theo sở thích nha ?. Tại Nhà hàng Ẩm thực Phương Nam, anh/chị có thể tham khảo các món lẩu như Lẩu mắm, Lẩu thác lác khổ qua, Lẩu tôm,... ạ ?✨','2025-12-08 10:16:37');
/*!40000 ALTER TABLE `lich_su_chatbot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_su_trang_thai_don_hang`
--

DROP TABLE IF EXISTS `lich_su_trang_thai_don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lich_su_trang_thai_don_hang` (
  `ma_lich_su` int NOT NULL AUTO_INCREMENT,
  `ma_don_hang` int NOT NULL,
  `trang_thai_cu` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trang_thai_moi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nguoi_thay_doi` int DEFAULT NULL COMMENT 'ID của admin hoặc user thay đổi',
  `loai_nguoi_thay_doi` enum('admin','user','system') COLLATE utf8mb4_unicode_ci DEFAULT 'system',
  `ghi_chu` text COLLATE utf8mb4_unicode_ci,
  `thoi_gian_thay_doi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_lich_su`),
  KEY `idx_ma_don_hang` (`ma_don_hang`),
  KEY `idx_thoi_gian` (`thoi_gian_thay_doi` DESC),
  CONSTRAINT `fk_lich_su_don_hang` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lưu lịch sử thay đổi trạng thái đơn hàng';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_trang_thai_don_hang`
--

LOCK TABLES `lich_su_trang_thai_don_hang` WRITE;
/*!40000 ALTER TABLE `lich_su_trang_thai_don_hang` DISABLE KEYS */;
INSERT INTO `lich_su_trang_thai_don_hang` VALUES (1,1,NULL,'delivered',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(2,2,NULL,'preparing',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(3,3,NULL,'confirmed',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(4,4,NULL,'delivered',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(5,5,NULL,'cancelled',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(6,6,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 05:00:12'),(7,7,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:04:18'),(8,8,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:06:11'),(9,9,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:08:00'),(10,10,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:09:40'),(11,11,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:12:44'),(12,12,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:14:05'),(13,13,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:15:52'),(14,14,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:18:06'),(15,15,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:20:45'),(16,16,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:26:21'),(17,17,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:27:57'),(18,18,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:30:14'),(19,19,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:38:03'),(20,20,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:39:49'),(21,21,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:43:02'),(22,22,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:46:39'),(23,23,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:50:31'),(24,24,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:50:55'),(25,25,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:51:55'),(26,26,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:03:06'),(27,27,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:14:27'),(28,28,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:17:36'),(29,29,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:18:47'),(30,30,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:20:19'),(31,31,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:25:21'),(32,32,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:31:54'),(33,33,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:36:15'),(34,34,NULL,'cancelled',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:47:44'),(35,35,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:56:07'),(36,36,NULL,'cancelled',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 05:52:04'),(37,37,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 06:00:02'),(38,38,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 06:03:17'),(39,39,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:47:33'),(40,40,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:52:43'),(41,41,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:55:25'),(42,42,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:58:44'),(43,43,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:03:43'),(44,44,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:07:26'),(45,45,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:15:41'),(46,46,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:24:56'),(47,47,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:26:35'),(48,48,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:39:13'),(49,49,NULL,'confirmed',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:40:54'),(50,50,NULL,'confirmed',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:47:23'),(64,51,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:03:30'),(65,52,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:07:47'),(66,53,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:12:16'),(67,54,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:19:37'),(68,55,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:22:19'),(69,56,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:30:05'),(70,57,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:30:11'),(71,48,'pending','preparing',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-25 01:03:05'),(72,58,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-28 08:35:58'),(73,59,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-28 08:40:56'),(74,60,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-28 08:43:20'),(75,60,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-28 08:49:42'),(76,60,'confirmed','preparing',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-28 08:53:48'),(77,60,'preparing','delivered',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-29 05:37:03'),(78,61,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-30 08:25:38'),(79,62,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-30 08:26:16'),(80,63,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-30 08:27:04'),(81,64,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-30 08:28:12'),(82,64,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-30 08:30:58'),(83,65,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-12-02 02:37:46'),(84,65,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-02 02:43:32'),(85,66,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-12-02 02:44:22'),(86,66,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-02 02:45:45'),(87,65,'confirmed','preparing',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-05 07:06:34'),(88,65,'preparing','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-05 07:06:35'),(89,64,'confirmed','pending',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-06 09:01:15'),(90,64,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-06 09:01:16'),(91,64,'confirmed','pending',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-06 09:01:19'),(92,64,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-06 09:01:20'),(93,61,'pending','delivered',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-06 09:02:47'),(94,62,'pending','delivered',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-12-06 09:02:48');
/*!40000 ALTER TABLE `lich_su_trang_thai_don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lien_he`
--

DROP TABLE IF EXISTS `lien_he`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lien_he` (
  `ma_lien_he` int NOT NULL AUTO_INCREMENT,
  `ho_ten` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_dien_thoai` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tieu_de` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noi_dung` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinh_anh` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Đường dẫn hình ảnh phản hồi (có thể nhiều ảnh, phân cách bằng dấu phẩy)',
  `ngay_gui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` enum('new','read','replied') COLLATE utf8mb4_unicode_ci DEFAULT 'new',
  PRIMARY KEY (`ma_lien_he`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lien_he`
--

LOCK TABLES `lien_he` WRITE;
/*!40000 ALTER TABLE `lien_he` DISABLE KEYS */;
INSERT INTO `lien_he` VALUES (1,'Nguyễn Văn A','nguyenvana@gmail.com','0911111111','Hỏi về địa chỉ chi nhánh','Cho tôi hỏi nhà hàng có chi nhánh nào ở Quận 2 không ạ?',NULL,'2025-10-30 08:31:01','replied'),(2,'Trần Thị B','tranthib@gmail.com','0922222222','Đặt tiệc sinh nhật','Tôi muốn đặt tiệc sinh nhật cho 20 người, có gói nào phù hợp không?',NULL,'2025-10-30 08:31:01','read'),(3,'Lê Văn C','levanc@gmail.com','0933333333','Góp ý về dịch vụ','Hôm qua tôi có đến nhà hàng, dịch vụ rất tốt. Cảm ơn!',NULL,'2025-10-30 08:31:01','read'),(4,'Phạm Thị D','phamthid@gmail.com','0944444444','Hỏi về menu chay','Nhà hàng có phục vụ menu chay không ạ?',NULL,'2025-10-30 08:31:01','new'),(5,'Hoàng Văn E','hoangvane@gmail.com','0955555555','Khiếu nại đơn hàng','Đơn hàng #123 của tôi bị giao thiếu món, làm sao để xử lý?',NULL,'2025-10-30 08:31:01','new');
/*!40000 ALTER TABLE `lien_he` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mon_an`
--

DROP TABLE IF EXISTS `mon_an`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mon_an` (
  `ma_mon` int NOT NULL AUTO_INCREMENT,
  `ten_mon` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta_chi_tiet` text COLLATE utf8mb4_unicode_ci,
  `gia_tien` decimal(12,2) NOT NULL,
  `so_luong_ton` int DEFAULT '0',
  `don_vi_tinh` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'suất',
  `anh_mon` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ảnh đại diện chính',
  `ma_danh_muc` int NOT NULL,
  `trang_thai` tinyint DEFAULT '1',
  `ngay_cap_nhat` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_mon`),
  KEY `ten_mon` (`ten_mon`),
  KEY `ma_danh_muc` (`ma_danh_muc`),
  CONSTRAINT `mon_an_ibfk_1` FOREIGN KEY (`ma_danh_muc`) REFERENCES `danh_muc` (`ma_danh_muc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mon_an`
--

LOCK TABLES `mon_an` WRITE;
/*!40000 ALTER TABLE `mon_an` DISABLE KEYS */;
INSERT INTO `mon_an` VALUES (1,'Cơm Chiên Hải Sản','Cơm chiên vàng ươm, thơm ngon với hải sản tươi sống và rau củ giòn ngọt.',55000.00,80,'dĩa','/images/comchienhaisan.jpg',1,1,'2025-10-30 08:31:01'),(2,'Cơm Chiên Cá Mặn','Cơm chiên cá mặn đậm đà, dẻo thơm, ăn kèm dưa leo và trứng chiên.',50000.00,70,'dĩa','/images/comchiencaman.jpg',1,1,'2025-10-30 08:31:01'),(3,'Cá Ri Ấn Độ','Cá nấu cà ri phong cách Ấn Độ, cay nồng và béo ngậy nước cốt dừa.',65000.00,50,'phần','/images/cariando.jpg',1,1,'2025-10-30 08:31:01'),(4,'Cánh Gà Chiên','Canh gà chiên giòn dùng kèm rau thơm, vị mặn mà hấp dẫn.',45000.00,3,'tô','/images/canhgachien.jpg',1,1,'2025-12-05 15:08:33'),(5,'Cá Tai Tượng Chiên Xù','Cá tai tượng chiên vàng giòn, ăn kèm rau sống và nước mắm chua ngọt.',120000.00,25,'con','/images/cataituongchienxu.jpg',1,1,'2025-10-30 09:17:48'),(6,'Gỏi Miền Tây','Gỏi tôm thịt miền Tây với rau thơm và đậu phộng rang giòn.',40000.00,70,'dĩa','/images/goimientay.jpg',2,1,'2025-10-30 08:31:01'),(7,'Gỏi Ốc Đắng','Gỏi ốc đắng chua cay, giòn sần sật hòa cùng rau răm và hành phi.',45000.00,50,'dĩa','/images/goiocdang.jpg',2,1,'2025-10-30 08:31:01'),(8,'Gỏi Heo Xứ Hàn','Gỏi thịt heo thái lát trộn hành tây, rau thơm, vị chua ngọt.',50000.00,60,'dĩa','/images/gioheoxuhan.jpg',2,1,'2025-12-05 15:08:49'),(9,'Đuồi Gà Chiên','Đuôi gà chiên nước mắm thơm giòn rụm.',55000.00,40,'dĩa','/images/duigachien.jpg',2,1,'2025-10-30 08:31:01'),(10,'Chả nguội Trung Hoa','Chả nguội kiểu Trung Hoa, hương vị mới lạ, dai giòn hấp dẫn.',45000.00,60,'phần','/images/donguoitrunghoa.jpg',2,1,'2025-10-30 08:31:01'),(11,'Lẩu Tôm','Lẩu tôm tươi ngọt nước, ăn kèm rau và bún tươi.',250000.00,30,'nồi','/images/lautom.jpg',3,1,'2025-10-30 08:31:01'),(12,'Lẩu Thác Lác Khổ Qua','Lẩu cá thác lác khổ qua thanh mát, tốt cho sức khỏe.',220000.00,25,'nồi','/images/lauthaclackhoqua.jpg',3,1,'2025-10-30 08:31:01'),(13,'Lẩu Mắm Miền Tây','Lẩu mắm đậm đà hương vị miền sông nước.',270000.00,25,'nồi','/images/laumammientay.jpg',3,1,'2025-10-30 09:19:26'),(14,'Lẩu Rau Đồng','Lẩu rau đồng dân dã với nước dùng xương hầm ngọt thanh.',180000.00,20,'nồi','/images/raudong.jpg',3,1,'2025-10-30 08:31:01'),(15,'Rau Muống Xào Tỏi','Rau muống xào tỏi độc đáo và đậm đà.',200000.00,20,'nồi','/images/raumuonxaotoi.jpg',3,1,'2025-10-30 08:31:01'),(16,'Bánh Phu Thê','Bánh phu thê dẻo thơm, tượng trưng cho tình duyên bền chặt.',15000.00,100,'cái','/images/product-1765162039391-777304629.jpg',3,1,'2025-12-08 09:47:19'),(17,'Bánh Huyên Ương Nướng','Bánh trái cây nướng truyền thống ngọt dịu và thơm bơ.',20000.00,80,'cái','/images/product-1765162086607-571572892.jpg',3,1,'2025-12-08 09:48:06'),(18,'Trái Cây Tiệc Cưới','Đĩa trái cây tươi mát, trình bày nghệ thuật.',60000.00,30,'dĩa','/images/traicaytieccuoi.jpg',3,1,'2025-11-25 15:44:36'),(19,'Hoa Quả Sơn','Tráng miệng hoa quả sơn, đa sắc màu và hương vị nhiệt đới.',50000.00,40,'dĩa','/images/hoaquason.jpg',4,1,'2025-10-30 08:31:01'),(20,'Kim Chi Tai Heo','Kim chi tai heo cay nồng, kích thích vị giác.',30000.00,49,'phần','/images/product-1765162006336-733151374.jpg',1,1,'2025-12-08 09:46:46'),(21,'Nước Rau Rừng Tây Bắc','Nước ép rau rừng thanh mát, độc đáo hương vị vùng cao.',30000.00,100,'ly','/images/raurungtaybac.jpg',5,1,'2025-10-30 08:31:01'),(22,'Tép Rong Cháy Sả','Món ăn kèm uống bia nhẹ, đậm vị miền Tây.',40000.00,59,'dĩa','/images/teprongchaysa.jpg',2,1,'2025-11-25 15:44:23'),(23,'Tôm Nướng Mật Ong','Tôm nướng mật ong vàng óng, dùng với bia lạnh.',80000.00,33,'xiên','/images/tomnuongmatong.jpg',5,1,'2025-11-30 15:26:16'),(24,'Tôm Sốt Mật Ong','Tôm chiên giòn rưới mật ong, thơm ngọt đặc biệt.',85000.00,38,'dĩa','/images/tomsotmatong.jpg',1,1,'2025-11-30 15:28:12'),(25,'Cà Nướng Mỡ Hành','Cá nướng than hoa rưới mỡ hành, thơm béo.',70000.00,43,'con','/images/canuongmohanh.jpg',1,1,'2025-12-02 09:44:22'),(26,'Gà nướng Tây Bắc','Gà nướng dưới bếp than đỏ hồng, ấm áp',20000.00,50,'suất','product-1765003856388-25725373.jpg',1,1,'2025-12-06 13:50:56'),(27,'Khoai môn sốc bơ đường ','Khoai môn giòn ngọt, áo thêm một lớp bơ đường giòn rụm',90000.00,10,'suất','/images/product-1765004585935-984646172.jpg',2,1,'2025-12-06 14:03:09'),(28,'Mực trứng hấp hành rừng','Mực đại dương tưới sống, được hấp ở nhiệt độ ',100000.00,50,'suất','/images/product-1765004677220-109550810.jpg',1,1,'2025-12-06 14:04:37'),(29,'Gỏi bò Phương Nam','Bò tươi, được cháy xén với gia vị gia truyền của đầu bếp',129000.00,50,'suất','/images/product-1765004835698-113669275.jpg',1,1,'2025-12-06 14:07:15'),(30,'Pizza Phương Nam','Pizza giòn rụm, thích hợp cho bé',129000.00,50,'suất','/images/product-1765004925766-849445682.jpg',1,1,'2025-12-06 14:08:45'),(31,'Cua hấp cách thủy','Cua đại dương, được hấp cách thủy, vẫn giữ được độ ngọt tự nhiên từ cua',350000.00,40,'suất','/images/product-1765005038835-715114647.jpg',1,1,'2025-12-06 14:10:38'),(32,'Trà canh mùa hạ','Mùa hè giải nhiệt với ly chanh mát mẻ, khiến xua tan mệt mỏi',20000.00,45,'suất','/images/product-1765005156179-535812366.webp',4,1,'2025-12-06 14:12:36'),(33,'Trà sữa chân châu đường đen','Thức uống của tuổi trẻ',20000.00,15,'suất','/images/product-1765005256330-668285201.jpg',4,1,'2025-12-06 14:14:16'),(34,'Dừa tắc','Dừa mát, uống vào là mát cả ruột gan',15000.00,30,'suất','/images/product-1765005332317-377122910.jpg',4,1,'2025-12-06 14:15:32'),(35,'Cam vắt ','Cam vắt tươi mát, cam được trồng ở môi trường không phun thuốc. An toàn sức khỏe',20000.00,50,'suất','/images/product-1765005458141-836092724.jpg',4,1,'2025-12-06 14:17:38'),(36,'Nước ép dưa hấu','Dưa hấu ép uống vào mát cả người',30000.00,20,'suất','/images/product-1765005571383-461933583.webp',4,1,'2025-12-06 14:19:31'),(37,'Nước ép lựu đỏ','Ly nước ấy đỏ căng như trái tim đang đập mạnh, thơm nhẹ kiểu ngọt – nhưng là cái ngọt thông minh, không sến, không cố gượng. Hớp một miếng là cảm giác như có nguyên một cơn sóng vitamin tràn qua người, kéo mood lên 100%, tỉnh táo, sạch sẽ, tươi mới như vừa reset lại cuộc sống.',50000.00,30,'suất','/images/product-1765005779441-957575773.jpg',4,1,'2025-12-06 14:22:59'),(38,'Trà dâu tầm','Trà dâu tằm là kiểu đồ uống mà chỉ cần liếc qua thôi đã thấy vibe thơ mộng lạc trôi giữa vườn hè.\r\n\r\nMàu của nó tím đỏ như tơ chiều, mịn màng và bí ẩn, kiểu đẹp theo dạng “không cần cố cũng hút mắt”. Nhấp một ngụm, vị chua nhẹ của dâu tằm bật lên trước, tinh nghịch như một cú kéo mood bất ngờ. Rồi cái ngọt dịu chậm rãi tràn xuống, mềm mại, tinh tế, để lại cảm giác tê tê ở đầu lưỡi như tiếng thì thầm của ai đó giữa đêm.',40000.00,8,'suất','/images/product-1765005870648-287413592.jpg',4,1,'2025-12-06 14:24:30'),(39,'Trà ổi nhiệt đới','Trà ổi nhiệt đới là kiểu đồ uống bước ra từ mùa hè—không ồn ào, không phô trương, nhưng đầy năng lượng rực rỡ.\r\n\r\nMàu của nó hồng cam như ánh nắng mới chạm mặt biển, nhìn một lần là muốn “chill” liền. Hớp đầu tiên sẽ thấy vị ổi thơm tròn, ngọt kiểu tự nhiên, không giả trân. Nhưng đằng sau lại len vào chút chua nhẹ của trái cây nhiệt đới, làm cả khoang miệng bùng lên như một bữa tiệc mini.\r\n\r\nHương thì kiểu fresh thật sự — mát, xanh, sạch, mang vibe của một buổi sáng gió lớn thổi qua tán cây. Nó đánh thức tinh thần theo cách rất mềm, rất hiền, nhưng lại đủ mạnh để kéo mood bạn từ “lụi tàn” sang “cháy sáng”.\r\n\r\nTrà ổi nhiệt đới không chỉ là một ly nước; nó giống một làn gió mới, một lời nhắc rằng cuộc đời đôi khi chỉ cần một hớp hương trái cây là mọi thứ sáng bừng. Một loại vibe khiến bạn khó mà buồn lâu được—vì chỉ cần uống vào, tâm trạng đã như chuyển màu sang rực rỡ.',30000.00,8,'suất','/images/product-1765006427605-106171090.jpg',4,1,'2025-12-06 14:33:47'),(40,'Lẩu mắm','Lẩu mắm là kiểu món ăn mà chỉ cần mở nắp nồi ra thôi là cả không gian rung chuyển — thơm nồng, đậm đà, đầy khí chất miền Tây, nghe mùi thôi là biết “đời không nhạt được đâu”.\r\n\r\nNước lẩu sôi ùng ục, màu nâu sẫm như đất phù sa đang thở. Cái hương mắm đặc trưng ấy không dễ chiều ai, nhưng một khi đã bén duyên, nó dính vào ký ức như một mối tình khó quên: mạnh, sâu, đậm đến mức trái tim cũng phải nở ra.\r\n\r\nRau thì cả một vườn: bông súng, rau đắng, cà tím, hẹ… từng loại đều bước vào nồi như những mảnh màu xanh xé toạc sự nhàm chán. Hải sản và thịt cá thì tươi rói, thả vào là hòa vào dòng nước mắm sôi cuồn cuộn, tạo nên cái vị umami miền Tây mà không nơi nào copy được.\r\n\r\nMột miếng đưa lên miệng — vị mắm lan ra trước, ấm, mặn ngọt vừa đủ, rồi đến vị rau giòn, cá béo, tất cả quyện lại như một bản giao hưởng dân dã nhưng “nghệ” vô cùng. Ăn mà thấy ấm lòng, ấm bụng, ấm luôn cả những ngày mệt.\r\n\r\nLẩu mắm không phải món sang, nhưng nó sang theo kiểu của riêng nó — chất, đậm, không chiều ai nhưng cũng không phụ ai. Một lần ăn là biết mình vừa chạm vào tinh thần của cả miền sông nước.',350000.00,10,'suất','/images/product-1765006542021-168507513.jpg',5,1,'2025-12-06 14:35:42'),(41,'Bánh khọt','Bánh khọt là kiểu món nhìn nhỏ xíu nhưng chất chơi thì vô hạn — đúng kiểu “bé mà có võ”.\r\n\r\nNhững chiếc bánh vàng ươm, giòn rụm như mặt trời thu nhỏ nằm gọn trong khuôn. Bẻ nhẹ một miếng là nghe tiếng giòn bật lên như pháo giấy — vui tai mà gây nghiện. Bên trong thì mềm, thơm, béo béo vị nước cốt dừa, lại thêm con tôm đỏ au nằm chễm chệ như muốn nói: “Tôi nhỏ nhưng tôi không tầm thường”.\r\n\r\nĂn chung với rau sống các kiểu — cải xanh, xà lách, tía tô, rau thơm — cuốn lại rồi chấm miếng nước mắm chua ngọt, là cả bầu trời flavor nổ tung trong miệng. Cái giòn – cái béo – cái tươi – cái đậm… tất cả trộn vào nhau nghe như playlist tâm trạng chuyển mood liên tục mà bài nào cũng hay.\r\n\r\nBánh khọt không chỉ là món ăn vặt; nó là vibe đường phố: thân thiện, náo nhiệt, giản dị nhưng luôn khiến người ta nhớ mãi. Kiểu món mà đã lỡ thương rồi thì cứ thèm hoài, thèm đến mức nghe mùi thôi là tim rung lên một nhịp.\r\n',50000.00,30,'suất','/images/product-1765006621757-193870664.webp',2,1,'2025-12-06 14:37:01'),(42,'Bánh Xèo miền ','Bánh xèo miền Tây là một cú “bùm” hương vị đúng nghĩa — vàng rực, giòn rã, thơm nức, mang cả hơi thở sông nước đập vào giác quan như cơn gió lớn giữa mùa nước nổi.\r\n\r\nCái bánh to tổ chảng, vàng óng như tấm nắng cuối chiều. Đổ cái “xèo” một phát là nghe vui tai muốn xỉu, kiểu âm thanh báo hiệu: *“Chuẩn bị, cái ngon sắp đáp xuống cuộc đời bạn.”* Viền bánh thì siêu giòn, bẻ một miếng nghe crack một cái, còn lòng bánh mềm ấm, ẩn bên dưới là tôm, thịt, đậu xanh… thơm nồng mà chân thật như tình người miệt quê.\r\n\r\nRau ăn kèm thì mênh mông như đất trời miền Tây: cải xanh, tía tô, diếp cá, lá lụa, lá bằng lăng non — cái nào cũng tươi, xanh, mang vị mộc của ruộng vườn. Cuốn một miếng bánh nóng hổi với cả rổ rau sống, chấm vào chén nước mắm chua ngọt pha kiểu quê, là cả vũ trụ vị giác xoay vòng trong miệng.\r\n\r\nBánh xèo miền Tây không sang chảnh, nhưng nó có cái hào sảng rất riêng: rộng lượng, ấm lòng, vui như một buổi gặp mặt trong xóm. Ăn một cái là thấy mình như đang ngồi trước căn bếp lửa rơm, nghe tiếng cười bà con rộn rã, thấy cuộc đời bỗng dưng nhẹ tênh và ấm lạ kỳ.\r\n',70000.00,90,'suất','/images/product-1765006723398-93498355.jpg',2,1,'2025-12-06 14:38:43'),(43,'Lẩu khổ qua thịt bầm','Lẩu khổ qua thịt bằm là kiểu món nghe tên tưởng “căng cực”, mà ăn vào lại thấy đời… dịu xuống như một câu thở dài được giải phóng.\r\n\r\nNồi lẩu xanh non, trong veo, nhìn mát mắt như một buổi sáng miền quê chưa kịp nắng. Khổ qua cắt lát mỏng, xanh biếc, thả vào nước là mềm dần nhưng vẫn giữ cái đắng thanh đặc trưng — cái đắng không làm khó ai, chỉ khiến người ta tỉnh táo hơn, mạnh mẽ hơn đúng kiểu “đời có giông cũng cứ đứng lên”.\r\n\r\nThịt bằm thì thả từng muỗng vào nồi, từng viên nhỏ tan ra, hòa vào nước lẩu tạo nên vị ngọt ấm, chân thành như lời động viên của người thương. Mùi thơm nhẹ, không gắt, không phô — kiểu vibe ôm nhẹ nhàng mà đủ làm tim mềm.\r\n\r\nHúp một muỗng nước nóng: đầu tiên là vị ngọt thanh từ xương thịt, sau đó vị đắng mảnh của khổ qua quét qua lưỡi, để lại dư vị vừa lạ vừa… chill, kiểu đau một chút nhưng tỉnh cả người. Và chính cái đắng ấy mới làm vị ngọt trở nên nổi bật — giống như trong cuộc sống, phải đi qua khó khăn thì cái ấm mới thấm sâu.\r\n\r\nLẩu khổ qua thịt bằm không phải món “wow” ngay từ đầu, nhưng càng ăn càng thấy đời hiền hơn, lòng nhẹ hơn. Một nồi lẩu nhỏ, nhưng là cả bài học về sự kiên cường và bình yên, đúng chất món ăn dành cho những ngày bạn cần reset tâm hồn.\r\n',400000.00,10,'suất','/images/product-1765006831017-993038040.jpg',5,1,'2025-12-06 14:40:31'),(44,'Cơm cháy kho quẹt','Cơm cháy kho quẹt là cú bắt tay giữa sự giòn rực và sự mặn mòi — một combo sinh ra để làm trái tim người ta “quắn quéo” không lối thoát.\r\n\r\nMiếng cơm cháy vàng ươm, giòn đến mức bẻ nhẹ thôi cũng nổ tanh tách như pháo hoa mini. Nó thơm mùi gạo rang, mùi nắng, mùi đồng quê — thứ hương dân dã mà sang theo kiểu rất riêng, kiểu “không chải chuốt nhưng vẫn đẹp chết người”.\r\n\r\nRồi tới kho quẹt — linh hồn của cả cuộc chơi. Nồi kho quẹt sền sệt, bóng mỡ, thơm nồng mùi hành tỏi cháy nhẹ, tiêu cay húng hắng và vị nước mắm đậm đà chạm sâu vào ký ức. Ba rọi rim mềm, tóp mỡ giòn, ớt đỏ lấp lánh như muốn cảnh báo: *“Coi chừng nghiện nha.”*\r\n\r\nChấm một miếng cơm cháy vào kho quẹt là cả thế giới như đứng yên một giây: cái giòn nổ tung, cái mặn ngọt béo bùi ôm lấy lưỡi, cay nhẹ nơi cuống họng — một bản phối hoàn hảo, đúng kiểu “tình yêu đầu đời phiên bản ẩm thực”.\r\n\r\nCơm cháy kho quẹt không phải món sang, nhưng nó có vibe “đã ăn là thương, thương là nhớ, nhớ là phải kiếm cho bằng được”. Một món khiến người ta thấy ấm bụng, vui lòng và… nghiện chút xíu cái chất quê chân thật không thể thay thế.\r\n',300000.00,10,'suất','/images/product-1765006921387-157177896.jpg',1,1,'2025-12-06 14:42:01'),(45,'Nem Nướng ','Những cây nem đỏ hồng, nướng trên than hồng kêu xèo xèo như đang hát bản nhạc mùa hè. Bên ngoài thì cháy cạnh nhẹ, bóng mỡ lấp lánh như ánh đèn đêm; bên trong thì mềm, thơm, béo, mang cái vị ngọt thịt rất chân thật — kiểu ngon không cần khoe.\r\n\r\nĂn nem nướng phải đi kèm cả “đội hình” rau xanh: xà lách, húng quế, dưa leo, khế, chuối chát… mỗi thứ một màu, gom lại thành nguyên cuộn “vũ trụ xanh”. Rồi cuộn nem trong bánh tráng, gói gọn lại như bọc cả bầu trời miền Trung vào tay.\r\n\r\nVà khoảnh khắc chấm vào chén nước chấm đặc sệt — ngọt, thơm, béo, cay nhẹ — là khoảnh khắc mọi giác quan đứng dậy vỗ tay. Cắn một miếng: cái giòn của rau, cái mềm của nem, cái béo của đậu phộng, cái thơm của tỏi… tất cả nổ tung như pháo hoa trong miệng.\r\n\r\nNem nướng không phải món để ăn cho no; nó là món để yêu, để tận hưởng, để nhớ. Một kiểu ngon vừa thân quen, vừa gây nghiện — ăn rồi là muốn “quay xe” gấp chỉ để làm thêm cuộn nữa.',100000.00,10,'suất','/images/product-1765007986797-123796795.jpg',2,1,'2025-12-06 14:59:46'),(46,'Combo mâm cơm gia đình','Combo mâm cơm Tết… đó không chỉ là bữa ăn, mà là cả linh hồn của mùa xuân được bày ra trên một mặt bàn sáng bóng, đầy đủ, tròn trịa như lời chúc năm mới gửi gắm bằng vị giác.\r\n\r\nGiữa mâm là nồi thịt kho trứng màu hổ phách, nước sánh óng ánh như ký ức của bao cái Tết cũ. Mùi nước dừa, mùi tiêu, mùi thịt kho mềm tan… tất cả quện vào nhau, thơm đến mức chỉ cần mở nắp thôi là nghe tim mình chậm lại một nhịp.\r\n\r\nKề bên là dĩa bánh tét hoặc bánh chưng xanh mướt — lớp lá dong ôm chặt những điều may mắn. Cắt ra một khoanh là hiện ra lớp nếp dẻo thơm, đậu mịn, nhân thịt mặn mà. Mỗi lát giống một trang sách nhỏ viết về sự đoàn viên.\r\n\r\nDưa món vàng cam giòn tan, chua nhẹ, ngọt nhẹ, như tiếng cười giòn trong căn bếp ngày Tết. Dưa hành tím thì thơm hăng nhưng duyên, cắn một cái là đánh thức toàn bộ vibe mùa xuân.\r\n\r\nRồi nem chả, giò lụa, thịt nguội… mỗi món một sắc, một hương, xếp vào như đội hình “all-star” của ẩm thực quê nhà. Món nào cũng mang một câu chuyện: về nhớ thương, về ấm áp, về sum vầy.\r\n\r\nKết lại là mâm trái cây ngũ quả: xanh – đỏ – vàng – tím – cam, đẹp như một lời chúc nở rộ. Chỉ cần nhìn thôi đã thấy cả tương lai sáng rực trước mắt.\r\n\r\nCombo mâm cơm Tết không chỉ làm bụng no, mà còn làm lòng yên. Nó là khoảnh khắc cả gia đình cùng ngồi lại, dưới ánh đèn ấm áp, giữa mùi hương quen thuộc, để thấy rằng dù đời có chạy nhanh cỡ nào, Tết vẫn là nơi ta quay về — nhẹ nhàng, đầy đủ, và đẹp đến nao lòng.',1000000.00,10,'suất','/images/product-1765008109645-599958024.jpg',1,1,'2025-12-08 09:54:37'),(47,'Chuối nướng cốt dừa','Chuối nướng cốt dừa là món khiến trái tim mềm lại ngay từ khoảnh khắc đầu — kiểu ấm áp, ngọt ngào, giản dị mà “chạm vibe” cực mạnh.\r\n\r\nQuả chuối chín được nướng lên vàng óng, lớp ngoài hơi cháy sém một chút như làn da rám nắng sau buổi chiều sông nước. Khi cắn vào, lớp chuối mềm, thơm, ngọt lịm, nóng hổi… tan ra như một lời ôm dịu dàng.\r\n\r\nRồi đến phần linh hồn: nước cốt dừa béo mịn, trắng muốt, chan lên nóng hổi. Vị béo không hề ngấy mà thanh, thơm, trôi nhẹ như mây. Rắc thêm chút đậu phộng rang giòn tan, nghe vui tai và làm hương vị bật lên như một cú drop trong bài nhạc quen.\r\n\r\nKhi tất cả chạm nhau — chuối nóng, cốt dừa béo, đậu phộng giòn — là cả một bản phối ngọt ngào kiểu “quên buồn trong một nốt nhạc”. Nó vừa dân dã, vừa tình cảm, vừa có chút gì đó khiến người ta nhớ về những buổi tối quê nhà, mùi than gió, mùi chuối chín, mùi cốt dừa thơm đến nao lòng.\r\n\r\nChuối nướng cốt dừa không cầu kỳ, không màu mè, nhưng lại khiến người ăn cảm thấy đời bỗng mềm đi — ngọt một cách chân thật, ấm một cách rất người, rất miền Tây. Một món nhỏ, nhưng đầy năng lượng chữa lành.\r\n',500000.00,10,'suất','/images/product-1765008232035-627892393.jpg',2,1,'2025-12-06 15:03:52'),(48,'Bánh da lợn nước cốt dừa','Từng lớp bánh xanh – vàng – trắng xếp chồng lên nhau mịn mượt như những trang ký ức được ép lại. Chạm nhẹ đầu ngón tay là cảm giác đàn hồi mềm mại, kiểu sờ một cái là biết ngon liền. Khi cắn vào, lớp bánh dẻo dẻo tan nhẹ như mưa rơi chậm, thơm mùi lá dứa, đậu xanh, và đặc biệt là cái béo tinh tế của nước cốt dừa — vừa đủ để mê, không đủ để ngán.\r\n\r\nHương cốt dừa lan nhẹ, ngọt thanh, ấm áp kiểu lời ru chiều. Mỗi lớp bánh vừa độc lập vừa hòa quyện, giống như những mảnh cảm xúc đa sắc nhưng lại khớp vào nhau hoàn hảo.\r\n\r\nĂn một miếng là nghe như tuổi thơ chạy ùa về: bếp củi, nồi hấp nghi ngút, tiếng cười rộn rã. Một món nhỏ xíu mà giữ được cả tâm hồn của những ngày bình yên.\r\n\r\nBánh da lợn nước cốt dừa — mềm, thơm, ngọt, và đầy vibe “healing” — kiểu món ăn khiến cuộc đời bớt gắt lại chỉ trong một lần cắn.',50000.00,10,'suất','/images/product-1765008497317-29377490.jpg',2,1,'2025-12-06 15:08:17'),(49,'Bánh tai yến','Bánh tai yến là kiểu món nhìn thì mộc mạc, nhưng đã vào miệng rồi là *bung lụa cảm xúc*.\r\n\r\nChiếc bánh nhỏ xinh, viền ngoài giòn rụm như cánh hoa nắng, còn phần giữa thì phồng mềm, bóng mịn như trái tim mới chớm thương ai đó. Màu vàng mật ong nhìn ấm áp, thân thiện, kiểu “nhìn là muốn cầm liền”.\r\n\r\nCắn một miếng: viền bánh giòn tan như tiếng cười giòn buổi chiều quê, còn lõi bánh dẻo nhẹ, thơm ngọt mùi đường thốt nốt, mùi bột gạo, mùi tuổi thơ. Cái giòn – cái mềm – cái béo nhẹ quyện vào nhau, nghe như playlist chill cuối ngày: nhẹ, êm, và gây nghiện.\r\n\r\nMùi thơm của bánh khi vừa kéo ra khỏi chảo dầu thì đúng chuẩn vibe hạnh phúc: ấm, ngọt, lan nhanh như một lời chúc “ngày mới đẹp hơn”. Không quá cầu kỳ, không màu mè, chỉ là chiếc bánh nhỏ nhưng đủ khiến tim mềm lại một nhịp.\r\n\r\nBánh tai yến là món ngọt của những ngày bình yên — giản dị, thơm thảo, và có sức mạnh chữa lành theo kiểu rất quê, rất thật, mà vẫn *đỉnh* theo vibe Gen Z mê đồ ngon.\r\n',60000.00,10,'suất','/images/product-1765008584625-490187031.png',2,1,'2025-12-06 15:09:44'),(50,'ComBo ấm áp','Combo nướng ấm áp là kiểu bữa ăn biến cả không gian thành một chiếc ôm — nóng, thơm, rộn ràng, và đủ sức kéo mood bạn từ “tụt pin” lên “full charge” trong vài giây.\r\n\r\nThan đỏ hồng cháy tí tách như những ngôi sao nhỏ, còn mùi thịt nướng thì lan ra dịu dàng mà quyến rũ, kiểu hương thơm khiến người ta bất giác mỉm cười. Thịt ba chỉ lát mỏng, bò cuộn nấm, gà ướp mật ong, hải sản tươi rói… tất cả nằm trên vỉ, xém cạnh nhẹ, bóng mỡ lấp lánh như ánh đèn vàng đêm lạnh.\r\n\r\nCắn một miếng: tiếng giòn nhẹ, vị đậm đà thấm vào lưỡi, béo – mặn – ngọt hòa vào nhau như một bản nhạc ấm áp. Rau xanh, kim chi, củ quả nướng kèm lại khiến cả combo cân bằng, vừa sung sướng vừa không ngấy. Chấm thêm miếng sốt mè rang hay sốt cay cay là thiệt sự *bùng nổ*.\r\n\r\nKhông chỉ ngon, combo nướng còn mang vibe tụ họp: ngồi quanh bếp lửa, chuyền nhau từng miếng nóng hổi, kể chuyện, cười lớn… ấm đến mức gió lạnh cũng phải đứng ngoài nhìn.\r\n\r\nĐây không chỉ là combo đồ ăn — mà là combo cảm xúc. Một buổi tối ấm hơn, một bàn tay gần hơn, và một chút hạnh phúc len vào giữa những làn khói thơm.\r\n',1000000.00,10,'suất','/images/product-1765008775484-846410112.jpg',1,1,'2025-12-06 15:12:55'),(51,'Bánh bò nước cốt dừa','Đó là thứ bánh mà khi bẻ đôi, từng sợi rễ nhỏ li ti bung ra như đang thở — dấu ấn của men gạo, của thời gian, của sự kiên nhẫn. Mỗi miếng bánh bò là một lời thì thầm: nhẹ, dẻo, ngọt vừa đủ, không phô trương mà vẫn khiến tim người ăn rung nhè nhẹ.\r\n\r\nHương nước cốt dừa quện vào, béo nhưng không nặng, như kiểu crush ai đó mà không nói ra — chỉ để vị ngọt tự lan. Cắn một miếng, cảm giác như cả tuổi thơ Gen Z tụi mình bật lại: tiếng rao “bánh bò đây!”, cái nóng hổi từ xửng tre, và cảm giác hạnh phúc đơn giản đến mức không cần filter.\r\n\r\nBánh bò là vậy — mộc mà sâu, giản dị mà gây thương nhớ. Một món ăn không chỉ để ăn, mà để nhớ, để thương, để giữ một góc mềm của tâm hồn.',40000.00,10,'suất','/images/product-1765161314750-8392053.jpg',2,1,'2025-12-08 09:35:14'),(52,'Chù ụ rang me','Chù ụ rang me là kiểu món nhìn thôi đã thấy trời ơi… hết hồn vì thèm, ăn vào thì đúng nghĩa “tan nát con tim vì mê”.\r\n\r\nCon chù ụ mập ú, vỏ sậm màu như vừa bước ra từ vùng sình mặn, thịt bên trong thì chắc nịch, ngọt kiểu tự nhiên – không cần makeup. Khi rang lên với me, cả gian bếp như sáng rực vị chua thanh, ngọt dịu, thơm nức kiểu khiến bụng réo ầm ầm.\r\n\r\nNước sốt me sánh lại, ôm lấy từng khớp càng, từng thớ thịt. Vị chua làm thức tỉnh, vị ngọt kéo người ta lại gần, còn chút cay nhẹ thì như lời thả thính tinh tế: đủ để nhớ, đủ để nghiện. Gỡ miếng càng, chấm vào lớp sốt nâu bóng ấy, cảm giác như cả biển mặn – đất bùn – nắng chiều quê nhà hợp nhất trong một khoảnh khắc.',450000.00,10,'suất','/images/product-1765161397607-407823374.jpg',1,1,'2025-12-08 09:36:37'),(53,'Bánh tét Miền tây','Bánh tét miền Tây là linh hồn của những ngày sum vầy, một cuộn ký ức được gói chặt trong lá chuối, buộc dây lạt mà gửi gắm cả tấm lòng quê.\r\n\r\nChiếc bánh dài, tròn, mộc như bản tính người miền sông nước. Khi cắt ra, từng khoanh bánh hiện lên như mặt trời bé nhỏ: nếp dẻo óng ánh, nhân đậu xanh vàng ruộm, ở giữa là miếng thịt ba rọi béo ngọt – tất cả hòa lại thành một bức tranh ấm áp, chan chứa yêu thương.\r\n\r\nNếp được ngâm nước lá dứa hay lá cẩm thì khoanh bánh lại thêm xanh, thêm tím, nhìn là muốn “wow” theo đúng vibe Gen Z: vừa đẹp vừa chất. Mùi thơm từ nếp, từ đậu, từ lá chuối quyện vào nhau, nhẹ thôi mà đủ làm tim người xa xứ chao liệng.',600000.00,10,'suất','/images/product-1765161976758-662706824.jpg',1,1,'2025-12-08 09:46:16');
/*!40000 ALTER TABLE `mon_an` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muc_tieu_chi_tiet`
--

DROP TABLE IF EXISTS `muc_tieu_chi_tiet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muc_tieu_chi_tiet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `thang` int NOT NULL,
  `nam` int NOT NULL,
  `loai_muc_tieu` enum('doanh_thu','don_hang','khach_hang_moi','dat_ban','danh_gia') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ten_muc_tieu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` text COLLATE utf8mb4_unicode_ci,
  `gia_tri_muc_tieu` decimal(15,2) NOT NULL DEFAULT '0.00',
  `gia_tri_hien_tai` decimal(15,2) NOT NULL DEFAULT '0.00',
  `don_vi` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'đơn vị',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 0xF09F8EAF,
  `thu_tu` int DEFAULT '1',
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ngay_cap_nhat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `thang_nam_loai` (`thang`,`nam`,`loai_muc_tieu`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muc_tieu_chi_tiet`
--

LOCK TABLES `muc_tieu_chi_tiet` WRITE;
/*!40000 ALTER TABLE `muc_tieu_chi_tiet` DISABLE KEYS */;
INSERT INTO `muc_tieu_chi_tiet` VALUES (16,12,2025,'doanh_thu','Doanh thu tháng','Tăng 10% so với tháng trước (390.000đ)',400000.00,0.00,'đồng','?',1,'2025-12-07 13:35:29','2025-12-07 13:35:29'),(17,12,2025,'don_hang','Số đơn hàng','Tăng 10% so với tháng trước (59 đơn)',65.00,0.00,'đơn','?',2,'2025-12-07 13:35:29','2025-12-07 13:35:29'),(18,12,2025,'khach_hang_moi','Khách hàng mới','Tăng 15% so với tháng trước (6 khách)',7.00,0.00,'người','?',3,'2025-12-07 13:35:29','2025-12-07 13:35:29'),(19,12,2025,'dat_ban','Lượt đặt bàn','Mục tiêu đặt bàn cho quán',5.00,0.00,'lượt','?️',4,'2025-12-07 13:35:29','2025-12-07 13:35:29'),(20,12,2025,'danh_gia','Đánh giá tích cực','Tăng 20% so với tháng trước (4 đánh giá)',5.00,0.00,'đánh giá','⭐',5,'2025-12-07 13:35:29','2025-12-07 13:35:29');
/*!40000 ALTER TABLE `muc_tieu_chi_tiet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muc_tieu_thang`
--

DROP TABLE IF EXISTS `muc_tieu_thang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muc_tieu_thang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `thang` int NOT NULL,
  `nam` int NOT NULL,
  `muc_tieu_doanh_thu` decimal(15,2) NOT NULL DEFAULT '0.00',
  `muc_tieu_don_hang` int NOT NULL DEFAULT '0',
  `muc_tieu_khach_hang` int DEFAULT '0',
  `muc_tieu_dat_ban` int DEFAULT '0',
  `ghi_chu` text COLLATE utf8mb4_unicode_ci,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ngay_cap_nhat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `thang_nam` (`thang`,`nam`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muc_tieu_thang`
--

LOCK TABLES `muc_tieu_thang` WRITE;
/*!40000 ALTER TABLE `muc_tieu_thang` DISABLE KEYS */;
INSERT INTO `muc_tieu_thang` VALUES (1,12,2025,50000000.00,100,0,0,'Mục tiêu tháng 12 - Mùa lễ hội','2025-12-06 16:08:44','2025-12-06 16:08:44');
/*!40000 ALTER TABLE `muc_tieu_thang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoi_dung`
--

DROP TABLE IF EXISTS `nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoi_dung` (
  `ma_nguoi_dung` int NOT NULL AUTO_INCREMENT,
  `ten_nguoi_dung` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_dien_thoai` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mat_khau_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dia_chi` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gioi_tinh` enum('khac','nam','nu') COLLATE utf8mb4_unicode_ci DEFAULT 'khac',
  `anh_dai_dien` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` tinyint DEFAULT '1' COMMENT '1: Hoạt động, 0: Bị khóa',
  PRIMARY KEY (`ma_nguoi_dung`),
  UNIQUE KEY `email` (`email`),
  KEY `email_2` (`email`),
  KEY `so_dien_thoai` (`so_dien_thoai`),
  KEY `idx_google_id` (`google_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES (1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','0901234567','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','123 Lê Lợi, Q1, TP.HCM','nu',NULL,NULL,'2025-10-30 08:31:01',1),(2,'Trần Văn Hùng','hung.tran@gmail.com','0902345678','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','456 Nguyễn Huệ, Q1, TP.HCM','nam',NULL,NULL,'2025-10-30 08:31:01',1),(3,'Lê Thị Hoa','hoa.le@gmail.com','0903456789','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','789 Trần Hưng Đạo, Q5, TP.HCM','nu',NULL,NULL,'2025-10-30 08:31:01',1),(4,'Phạm Minh Tuấn','tuan.pham@gmail.com','0904567890','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','321 Điện Biên Phủ, Q3, TP.HCM','nam',NULL,NULL,'2025-10-30 08:31:01',1),(5,'Võ Thị Lan','lan.vo@gmail.com','0905678901','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','654 Cách Mạng Tháng 8, Q10, TP.HCM','nu',NULL,NULL,'2025-10-30 08:31:01',1),(6,'Hồ Quang Vinh','quangvinhho000@gmail.com','0355745120','$2a$10$B1CofOIMDupHM/ZGQmjcM.8QJT1cPmRlLnJDVnYeULUZJdmg4Y9Oe','Cầu Kè','nam','/images/avatars/avatar-1763781885466-232406390.jpg',NULL,'2025-11-04 15:11:36',1),(7,'Lê Thị Hồng Thắm','let752149@gmail.com','0388853049','$2a$10$3ZCNLjqHnMjERIaD.KFgZ.mFGdcqZb6WaojO38WWl/zcPf6oCgh5S','Nguyễn Thiện Thành Phường Trà Vinh','nu',NULL,NULL,'2025-11-05 12:53:53',0),(8,'Đỗ Thiên Vũ','dothienvu84tv@gmail.com','0388853048','$2a$10$uLwDCYzo0TdgodcYQZM.POhR.CBxZ/oTQgCxtO/ZU8Fm17GULuVha','Phú Hòa Long Đức Trà Vinh','nam','https://lh3.googleusercontent.com/a/ACg8ocJtGsRrsTVGZKZl9h9Ug3fZgeVQ9O8hVafBB1jaWnRpKAW6rA=s200-c','105227688268935859438','2025-11-05 14:52:13',1),(9,'Lê Thị Hồng Quyên','leq94328@gmail.com','0388853045','$2a$10$Dzg4gJpaulrUaPsVc3NZmOFSLERB2KkFlGfMAJo2EkaqGYjEoRb92','Phường Long Đức Tỉnh Vĩnh Long','nu',NULL,NULL,'2025-11-05 16:11:40',1),(10,'Nhi Đinh','yennhivk82@gmail.com',NULL,NULL,NULL,'khac','https://lh3.googleusercontent.com/a/ACg8ocLuUQ5bSPcB2F55AB0j4ITUWK_Quphfvc74CRpZEShEFszO910=s200-c','106455236021628128201','2025-11-30 13:31:35',1),(11,'Thuật Thuật','nguyenhuynhkithuat84tv@gmail.com',NULL,NULL,NULL,'khac','https://lh3.googleusercontent.com/a/ACg8ocIo90HHFVO_TpBzGlbr-kcFij7f4VyqjWwWZYUSGqJIjRzSHp85=s200-c','102458705850277446461','2025-11-30 14:59:18',1);
/*!40000 ALTER TABLE `nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset`
--

DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ma_nguoi_dung` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` datetime NOT NULL,
  `da_su_dung` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  KEY `token` (`token`),
  CONSTRAINT `password_reset_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
INSERT INTO `password_reset` VALUES (1,1,'reset_token_123','2025-09-10 23:24:28',0),(2,2,'reset_token_456','2025-09-10 23:24:28',1);
/*!40000 ALTER TABLE `password_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quang_cao`
--

DROP TABLE IF EXISTS `quang_cao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quang_cao` (
  `ma_quang_cao` int NOT NULL AUTO_INCREMENT,
  `tieu_de` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinh_anh` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duong_dan_lien_ket` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vi_tri` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_bat_dau` datetime DEFAULT NULL,
  `ngay_ket_thuc` datetime DEFAULT NULL,
  `trang_thai` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ma_quang_cao`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quang_cao`
--

LOCK TABLES `quang_cao` WRITE;
/*!40000 ALTER TABLE `quang_cao` DISABLE KEYS */;
INSERT INTO `quang_cao` VALUES (1,'Banner Khuyến Mãi Tháng 10','/images/banner-khuyen-mai-10.jpg','/khuyen-mai','homepage-slider','2025-10-01 00:00:00','2025-10-31 23:59:59',1),(2,'Giới thiệu Món Mới','/images/banner-mon-moi.jpg','/menu/mon-moi','homepage-slider','2025-10-01 00:00:00','2025-12-31 23:59:59',1),(3,'Đặt Bàn Trực Tuyến','/images/banner-dat-ban.jpg','/dat-ban','sidebar','2025-01-01 00:00:00','2025-12-31 23:59:59',1),(4,'Chương Trình Thành Viên','/images/banner-thanh-vien.jpg','/thanh-vien','footer','2025-01-01 00:00:00','2025-12-31 23:59:59',1),(5,'Giao Hàng Miễn Phí','/images/banner-freeship.jpg','/chinh-sach-giao-hang','popup','2025-10-01 00:00:00','2025-10-31 23:59:59',1);
/*!40000 ALTER TABLE `quang_cao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset_password`
--

DROP TABLE IF EXISTS `reset_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reset_password` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ma_nguoi_dung` int NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired_at` datetime NOT NULL,
  `da_su_dung` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  KEY `token` (`token`),
  CONSTRAINT `reset_password_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset_password`
--

LOCK TABLES `reset_password` WRITE;
/*!40000 ALTER TABLE `reset_password` DISABLE KEYS */;
INSERT INTO `reset_password` VALUES (1,1,'TOKEN_ABC123XYZ789','2025-10-14 10:30:00',0),(2,2,'TOKEN_DEF456UVW012','2025-10-13 15:45:00',1),(3,3,'TOKEN_GHI789RST345','2025-10-15 09:20:00',0),(4,4,'TOKEN_JKL012OPQ678','2025-10-12 14:00:00',1),(5,5,'TOKEN_MNO345ABC901','2025-10-16 11:30:00',0);
/*!40000 ALTER TABLE `reset_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thanh_toan`
--

DROP TABLE IF EXISTS `thanh_toan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thanh_toan` (
  `ma_thanh_toan` int NOT NULL AUTO_INCREMENT,
  `ma_don_hang` int NOT NULL,
  `so_tien` decimal(14,2) NOT NULL,
  `phuong_thuc` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'cash',
  `ma_giao_dich` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trang_thai` enum('pending','success','failed','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `thoi_gian_thanh_toan` datetime DEFAULT NULL,
  `thong_tin_them` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ma_thanh_toan`),
  KEY `ma_don_hang` (`ma_don_hang`),
  KEY `ma_giao_dich` (`ma_giao_dich`),
  CONSTRAINT `thanh_toan_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thanh_toan`
--

LOCK TABLES `thanh_toan` WRITE;
/*!40000 ALTER TABLE `thanh_toan` DISABLE KEYS */;
INSERT INTO `thanh_toan` VALUES (1,1,120000.00,'momo','MOMO123456789','success','2025-10-10 11:30:00','Thanh toán qua MoMo'),(2,2,315000.00,'cash',NULL,'pending',NULL,'Thanh toán khi nhận hàng'),(3,3,180000.00,'vnpay','VNPAY987654321','success','2025-10-11 14:20:00','Thanh toán qua VNPay'),(4,4,450000.00,'cash',NULL,'success','2025-10-09 18:45:00','Thanh toán tiền mặt'),(5,5,560000.00,'zalopay','ZALO111222333','cancelled',NULL,'Giao dịch bị hủy'),(6,6,100000.00,'cod',NULL,'pending',NULL,NULL),(7,7,115000.00,'vnpay',NULL,'pending',NULL,NULL),(8,8,155000.00,'vnpay',NULL,'pending',NULL,NULL),(9,8,155000.00,'vnpay','8_1763791571734','pending',NULL,NULL),(10,9,115000.00,'vnpay',NULL,'pending',NULL,NULL),(11,9,115000.00,'vnpay','9_1763791680772','pending',NULL,NULL),(12,10,115000.00,'vnpay',NULL,'pending',NULL,NULL),(13,10,115000.00,'vnpay','10_1763791780780','pending',NULL,NULL),(14,11,155000.00,'vnpay',NULL,'pending',NULL,NULL),(15,11,155000.00,'vnpay','11_1763791964413','pending',NULL,NULL),(16,12,115000.00,'vnpay',NULL,'pending',NULL,NULL),(17,12,115000.00,'vnpay','12_1763792045154','pending',NULL,NULL),(18,13,115000.00,'vnpay',NULL,'pending',NULL,NULL),(19,13,115000.00,'vnpay','13_1763792152860','pending',NULL,NULL),(20,14,100000.00,'vnpay',NULL,'pending',NULL,NULL),(21,14,100000.00,'vnpay','14_1763792286652','pending',NULL,NULL),(22,15,115000.00,'vnpay',NULL,'pending',NULL,NULL),(23,15,115000.00,'vnpay','15_1763792445733','pending',NULL,NULL),(24,16,115000.00,'vnpay',NULL,'pending',NULL,NULL),(25,16,115000.00,'vnpay','16_1763792782011','pending',NULL,NULL),(26,17,115000.00,'vnpay',NULL,'pending',NULL,NULL),(27,17,115000.00,'vnpay','17_1763792877381','pending',NULL,NULL),(28,18,110000.00,'vnpay',NULL,'pending',NULL,NULL),(29,18,110000.00,'vnpay','18_1763793014062','pending',NULL,NULL),(30,19,115000.00,'vnpay',NULL,'pending',NULL,NULL),(31,19,115000.00,'vnpay','19_1763793484003','pending',NULL,NULL),(32,20,115000.00,'vnpay',NULL,'pending',NULL,NULL),(33,20,115000.00,'vnpay','20_1763793589750','pending',NULL,NULL),(34,21,115000.00,'vnpay',NULL,'pending',NULL,NULL),(35,21,115000.00,'vnpay','21_1763793782404','pending',NULL,NULL),(36,22,115000.00,'vnpay',NULL,'pending',NULL,NULL),(37,22,115000.00,'vnpay','22_1763793999789','pending',NULL,NULL),(38,23,110000.00,'vnpay',NULL,'pending',NULL,NULL),(39,23,110000.00,'vnpay','23_1763794231101','pending',NULL,NULL),(40,24,115000.00,'cod',NULL,'pending',NULL,NULL),(41,25,60000.00,'vnpay',NULL,'pending',NULL,NULL),(42,25,60000.00,'vnpay','25_1763794316001','pending',NULL,NULL),(43,26,115000.00,'vnpay',NULL,'pending',NULL,NULL),(44,26,115000.00,'vnpay','26_1763794986814','pending',NULL,NULL),(45,27,115000.00,'vnpay',NULL,'pending',NULL,NULL),(46,27,115000.00,'vnpay','27_1763795667459','pending',NULL,NULL),(47,28,100000.00,'vnpay',NULL,'pending',NULL,NULL),(48,28,100000.00,'vnpay','28_1763795856265','pending',NULL,NULL),(49,29,115000.00,'vnpay',NULL,'pending',NULL,NULL),(50,29,115000.00,'vnpay','29_1763795927235','pending',NULL,NULL),(51,30,70000.00,'vnpay',NULL,'pending',NULL,NULL),(52,30,70000.00,'vnpay','30_1763796019277','pending',NULL,NULL),(53,31,115000.00,'vnpay',NULL,'pending',NULL,NULL),(54,31,115000.00,'vnpay','31_1763796321442','pending',NULL,NULL),(55,32,165000.00,'vnpay',NULL,'pending',NULL,NULL),(56,32,165000.00,'vnpay','32_1763796714985','pending',NULL,NULL),(57,33,115000.00,'vnpay',NULL,'pending',NULL,NULL),(58,33,115000.00,'vnpay','33_1763796975609','pending',NULL,NULL),(59,34,115000.00,'vnpay',NULL,'cancelled',NULL,NULL),(60,34,115000.00,'vnpay','34_1763797664112','cancelled',NULL,NULL),(61,35,110000.00,'vnpay',NULL,'pending',NULL,NULL),(62,35,110000.00,'vnpay','35_1763798167082','pending',NULL,NULL),(63,35,110000.00,'vnpay','35_1763800113023','pending',NULL,NULL),(64,26,115000.00,'vnpay','26_1763800446906','pending',NULL,NULL),(65,26,115000.00,'vnpay','26_1763801127914','pending',NULL,NULL),(66,36,110000.00,'bank',NULL,'cancelled',NULL,NULL),(67,36,110000.00,'vnpay','36_1763877376236','cancelled',NULL,NULL),(68,37,115000.00,'cod',NULL,'pending',NULL,NULL),(69,38,110000.00,'cod',NULL,'pending',NULL,NULL),(70,39,115000.00,'vnpay',NULL,'pending',NULL,NULL),(71,39,115000.00,'vnpay','39_1763884053100','pending',NULL,NULL),(72,40,115000.00,'vnpay',NULL,'pending',NULL,NULL),(73,40,115000.00,'vnpay','40_1763884363205','pending',NULL,NULL),(74,41,115000.00,'vnpay',NULL,'pending',NULL,NULL),(75,41,115000.00,'vnpay','41_1763884525119','pending',NULL,NULL),(76,42,115000.00,'vnpay',NULL,'pending',NULL,NULL),(77,42,115000.00,'vnpay','42_1763884724309','pending',NULL,NULL),(78,43,115000.00,'vnpay',NULL,'pending',NULL,NULL),(79,43,115000.00,'vnpay','43_23150343','pending',NULL,NULL),(80,44,115000.00,'vnpay',NULL,'pending',NULL,NULL),(81,44,115000.00,'vnpay','44_23150726','pending',NULL,NULL),(82,45,115000.00,'vnpay',NULL,'pending',NULL,NULL),(83,45,115000.00,'vnpay','45_23151541','pending',NULL,NULL),(84,46,115000.00,'vnpay',NULL,'pending',NULL,NULL),(85,46,115000.00,'vnpay','46_23152456','pending',NULL,NULL),(86,47,115000.00,'vnpay',NULL,'pending',NULL,NULL),(87,47,115000.00,'vnpay','47_23152635','pending',NULL,NULL),(88,48,115000.00,'vnpay',NULL,'pending',NULL,NULL),(89,48,115000.00,'vnpay','48_23153913','pending',NULL,NULL),(90,49,115000.00,'vnpay',NULL,'pending',NULL,NULL),(91,49,115000.00,'vnpay','1763887408283','success','2025-11-23 08:43:28','{\"bankCode\":\"NCB\",\"amount\":115000}'),(92,50,115000.00,'vnpay',NULL,'pending',NULL,NULL),(93,50,115000.00,'vnpay','1763887658738','success','2025-11-23 08:47:38','{\"bankCode\":\"VCB\",\"amount\":115000}'),(94,51,115000.00,'vnpay',NULL,'pending',NULL,NULL),(95,51,115000.00,'vnpay','51_23160330','pending',NULL,NULL),(96,52,115000.00,'vnpay',NULL,'pending',NULL,NULL),(97,52,115000.00,'vnpay','52_23160747','pending',NULL,NULL),(98,53,115000.00,'vnpay',NULL,'pending',NULL,NULL),(99,53,115000.00,'vnpay','53_23161216','pending',NULL,NULL),(100,54,115000.00,'vnpay','54_23161937','pending',NULL,NULL),(101,55,115000.00,'vnpay','55_23162219','pending',NULL,NULL),(102,56,115000.00,'vnpay','56_23163005','pending',NULL,NULL),(103,57,115000.00,'momo','57_1764318771019','failed',NULL,'{\"resultCode\":\"1006\",\"message\":\"Giao dịch bị từ chối bởi người dùng.\"}'),(104,58,115000.00,'momo_demo',NULL,'pending',NULL,NULL),(105,59,115000.00,'momo','59_1764319256725','failed',NULL,'{\"resultCode\":\"1006\",\"message\":\"Giao dịch bị từ chối bởi người dùng.\"}'),(106,60,115000.00,'momo','60_1764319710766','success','2025-11-28 15:49:42','{\"transId\":\"4618590443\",\"payType\":\"napas\",\"message\":\"Successful.\"}'),(107,61,110000.00,'momo_demo',NULL,'pending',NULL,NULL),(108,62,165000.00,'qr',NULL,'pending',NULL,NULL),(109,63,115000.00,'momo','63_1764491224578','pending',NULL,NULL),(110,64,115000.00,'momo','64_1764491292587','success','2025-11-30 15:30:58','{\"transId\":\"4619947095\",\"payType\":\"napas\",\"message\":\"Successful.\"}'),(111,65,100000.00,'momo','65_1764643066964','success','2025-12-02 09:43:32','{\"transId\":\"4620793581\",\"payType\":\"napas\",\"message\":\"Successful.\"}'),(112,66,100000.00,'momo','66_1764643462250','success','2025-12-02 09:45:45','{\"transId\":\"4620833731\",\"payType\":\"napas\",\"message\":\"Successful.\"}');
/*!40000 ALTER TABLE `thanh_toan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thong_ke_hang_ngay`
--

DROP TABLE IF EXISTS `thong_ke_hang_ngay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thong_ke_hang_ngay` (
  `ma_thong_ke` int NOT NULL AUTO_INCREMENT,
  `ngay_thong_ke` date NOT NULL,
  `doanh_thu` decimal(15,2) DEFAULT '0.00',
  `so_don_hang` int DEFAULT '0',
  `so_khach_hang_moi` int DEFAULT '0',
  `luot_truy_cap` int DEFAULT '0',
  PRIMARY KEY (`ma_thong_ke`),
  UNIQUE KEY `ngay_thong_ke` (`ngay_thong_ke`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thong_ke_hang_ngay`
--

LOCK TABLES `thong_ke_hang_ngay` WRITE;
/*!40000 ALTER TABLE `thong_ke_hang_ngay` DISABLE KEYS */;
INSERT INTO `thong_ke_hang_ngay` VALUES (1,'2025-10-08',5600000.00,42,8,1250),(2,'2025-10-09',6200000.00,48,12,1380),(3,'2025-10-10',7100000.00,53,15,1520),(4,'2025-10-11',5900000.00,45,9,1420),(5,'2025-10-12',6800000.00,51,11,1650);
/*!40000 ALTER TABLE `thong_ke_hang_ngay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tin_tuc`
--

DROP TABLE IF EXISTS `tin_tuc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tin_tuc` (
  `ma_tin_tuc` int NOT NULL AUTO_INCREMENT,
  `tieu_de` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tom_tat` text COLLATE utf8mb4_unicode_ci,
  `noi_dung` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `anh_dai_dien` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ma_admin_dang` int DEFAULT NULL,
  `ngay_dang` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` tinyint(1) DEFAULT '1',
  `luot_xem` int DEFAULT '0',
  PRIMARY KEY (`ma_tin_tuc`),
  KEY `ma_admin_dang` (`ma_admin_dang`),
  KEY `tieu_de` (`tieu_de`),
  CONSTRAINT `tin_tuc_ibfk_1` FOREIGN KEY (`ma_admin_dang`) REFERENCES `admin` (`ma_admin`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tin_tuc`
--

LOCK TABLES `tin_tuc` WRITE;
/*!40000 ALTER TABLE `tin_tuc` DISABLE KEYS */;
INSERT INTO `tin_tuc` VALUES (6,'Khai Trương Chi Nhánh Mới Tại Vĩnh Long','Chúng tôi vui mừng thông báo khai trương chi nhánh thứ 5 tại trung tâm thành phố Vĩnh Long với không gian hiện đại và đội ngũ chuyên nghiệp.','<p>Chúng tôi vui mừng thông báo khai trương chi nhánh thứ 5 tại trung tâm thành phố Vĩnh Long. Với không gian hiện đại, rộng rãi và đội ngũ nhân viên chuyên nghiệp, chúng tôi cam kết mang đến trải nghiệm ẩm thực tuyệt vời nhất cho quý khách hàng.</p>\r\n                \r\n                <h2>Thông tin chi nhánh mới</h2>\r\n                <ul>\r\n                    <li>Địa chỉ: 123 Đường Phạm Thái Bường, Phường 4, Vĩnh Long</li>\r\n                    <li>Diện tích: 500m² với sức chứa 200 khách</li>\r\n                    <li>Giờ mở cửa: 10:00 - 22:00 hàng ngày</li>\r\n                    <li>Đặc biệt: Không gian VIP riêng tư, phù hợp tổ chức tiệc</li>\r\n                </ul>\r\n\r\n                <h2>Ưu đãi khai trương</h2>\r\n                <p>Nhân dịp khai trương, chúng tôi dành tặng quý khách:</p>\r\n                <ul>\r\n                    <li>Giảm 20% toàn bộ thực đơn trong tuần đầu tiên</li>\r\n                    <li>Tặng món tráng miệng khi hóa đơn từ 500.000đ</li>\r\n                    <li>Ưu đãi đặc biệt cho khách hàng thân thiết</li>\r\n                </ul>','images/tt2.jpg',1,'2025-11-15 15:18:50',1,928),(7,'Ra Mắt Thực Đơn Mùa Thu 2025','Khám phá những món ăn đặc trưng mùa thu với hương vị độc đáo, được chế biến từ nguyên liệu tươi ngon nhất.','<p>Chào đón mùa thu 2025, Nhà hàng Phương Nam tự hào giới thiệu thực đơn mới với những món ăn đặc trưng mang hương vị mùa thu đậm đà.</p>\n\n                <h2>Món ăn nổi bật</h2>\n                <ul>\n                    <li>Lẩu cá kèo lá giang - 350.000đ</li>\n                    <li>Gỏi bưởi tôm thịt - 180.000đ</li>\n                    <li>Cơm tấm sườn bì chả - 55.000đ</li>\n                    <li>Bánh xèo Vĩnh Long - 45.000đ</li>\n                </ul>\n\n                <p>Tất cả món ăn đều được chế biến từ nguyên liệu tươi sống, đảm bảo vệ sinh an toàn thực phẩm.</p>','images/tt1.jpg',1,'2025-11-15 15:18:50',1,948),(8,'Workshop Ẩm Thực Miền Tây - Tháng 11/2025','Tham gia workshop học nấu các món ăn truyền thống miền Tây cùng đầu bếp chuyên nghiệp của nhà hàng.','<p>Nhà hàng Phương Nam tổ chức workshop ẩm thực miền Tây dành cho những ai yêu thích nấu ăn và muốn khám phá bí quyết chế biến các món ăn truyền thống.</p>\r\n\r\n                <h2>Thông tin workshop</h2>\r\n                <ul>\r\n                    <li>Thời gian: Thứ 7 hàng tuần, 14:00 - 17:00</li>\r\n                    <li>Địa điểm: Nhà hàng Phương Nam - Chi nhánh 1</li>\r\n                    <li>Học phí: 350.000đ/người (bao gồm nguyên liệu)</li>\r\n                    <li>Số lượng: Giới hạn 15 người/buổi</li>\r\n                </ul>\r\n\r\n                <h2>Nội dung học</h2>\r\n                <ul>\r\n                    <li>Cách chọn nguyên liệu tươi ngon</li>\r\n                    <li>Kỹ thuật chế biến món lẩu</li>\r\n                    <li>Bí quyết làm nước mắm pha</li>\r\n                    <li>Trình bày món ăn chuyên nghiệp</li>\r\n                </ul>','images/news-1765008835766-946416300.jpg',1,'2025-11-15 15:18:50',1,804),(9,'Chương Trình Khuyến Mãi Cuối Tuần','Giảm giá 15% cho tất cả các món ăn vào thứ 7 và Chủ nhật. Áp dụng cho cả đơn hàng tại nhà hàng và giao hàng.','<p>Cuối tuần này hãy đến Nhà hàng Phương Nam để thưởng thức những món ăn ngon với ưu đãi đặc biệt!</p>\r\n\r\n                <h2>Ưu đãi chi tiết</h2>\r\n                <ul>\r\n                    <li>Giảm 15% toàn bộ thực đơn</li>\r\n                    <li>Tặng nước uống cho hóa đơn từ 300.000đ</li>\r\n                    <li>Freeship cho đơn hàng từ 200.000đ trong bán kính 5km</li>\r\n                </ul>\r\n\r\n                <h2>Điều kiện áp dụng</h2>\r\n                <ul>\r\n                    <li>Áp dụng: Thứ 7 và Chủ nhật hàng tuần</li>\r\n                    <li>Không áp dụng đồng thời với chương trình khuyến mãi khác</li>\r\n                    <li>Đặt bàn trước để được phục vụ tốt nhất</li>\r\n                </ul>','images/news-1765008868848-145298250.jpg',1,'2025-11-15 15:18:50',1,452),(10,'Đặc Sản Mùa Vụ - Tháng 11','Thưởng thức các món ăn được chế biến từ đặc sản mùa vụ của miền Tây, mang đến hương vị đậm đà nhất.','<p>Tháng 11 là mùa của nhiều đặc sản miền Tây. Nhà hàng Phương Nam chọn lọc những nguyên liệu tươi ngon nhất để chế biến các món ăn đặc trưng.</p>\r\n\r\n                <h2>Món ăn mùa vụ</h2>\r\n                <ul>\r\n                    <li>Lẩu mắm cá linh - 380.000đ</li>\r\n                    <li>Cá kèo kho tộ - 220.000đ</li>\r\n                    <li>Ốc hấp sả - 150.000đ</li>\r\n                    <li>Gỏi cá trích - 180.000đ</li>\r\n                </ul>\r\n\r\n                <p>Các món ăn chỉ có trong mùa, không thể bỏ lỡ!</p>','images/news-1765008939288-580994995.jpg',1,'2025-11-15 15:18:50',1,867);
/*!40000 ALTER TABLE `tin_tuc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tra_loi_danh_gia`
--

DROP TABLE IF EXISTS `tra_loi_danh_gia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tra_loi_danh_gia` (
  `ma_tra_loi` int NOT NULL AUTO_INCREMENT,
  `ma_danh_gia` int NOT NULL COMMENT 'ID đánh giá được trả lời',
  `noi_dung` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nội dung trả lời',
  `ten_admin` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT 'Admin' COMMENT 'Tên admin trả lời',
  `ngay_tra_loi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_tra_loi`),
  KEY `ma_danh_gia` (`ma_danh_gia`),
  CONSTRAINT `tra_loi_danh_gia_ibfk_1` FOREIGN KEY (`ma_danh_gia`) REFERENCES `danh_gia_san_pham` (`ma_danh_gia`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lưu trả lời của admin cho đánh giá sản phẩm';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tra_loi_danh_gia`
--

LOCK TABLES `tra_loi_danh_gia` WRITE;
/*!40000 ALTER TABLE `tra_loi_danh_gia` DISABLE KEYS */;
/*!40000 ALTER TABLE `tra_loi_danh_gia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xac_nhan_thanh_toan`
--

DROP TABLE IF EXISTS `xac_nhan_thanh_toan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xac_nhan_thanh_toan` (
  `ma_xac_nhan` int NOT NULL AUTO_INCREMENT,
  `ma_don_hang` int NOT NULL,
  `so_tien` decimal(14,2) NOT NULL,
  `phuong_thuc` varchar(50) DEFAULT 'cash',
  `ma_giao_dich` varchar(255) DEFAULT NULL,
  `ket_qua` enum('pending','success','failed','cancel') DEFAULT 'pending',
  `thoi_gian_xac_nhan` datetime DEFAULT NULL,
  `thong_tin_them` text,
  PRIMARY KEY (`ma_xac_nhan`),
  KEY `ma_don_hang` (`ma_don_hang`),
  KEY `ma_giao_dich` (`ma_giao_dich`),
  CONSTRAINT `xac_nhan_thanh_toan_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xac_nhan_thanh_toan`
--

LOCK TABLES `xac_nhan_thanh_toan` WRITE;
/*!40000 ALTER TABLE `xac_nhan_thanh_toan` DISABLE KEYS */;
INSERT INTO `xac_nhan_thanh_toan` VALUES (1,1,125000.00,'momo','GD123456','success','2025-09-09 23:24:07',NULL),(2,2,60000.00,'cash',NULL,'pending',NULL,NULL);
/*!40000 ALTER TABLE `xac_nhan_thanh_toan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xac_thuc_email`
--

DROP TABLE IF EXISTS `xac_thuc_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xac_thuc_email` (
  `ma_xac_thuc` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ma_code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ten_nguoi_dung` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `so_dien_thoai` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mat_khau_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dia_chi` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gioi_tinh` enum('khac','nam','nu') COLLATE utf8mb4_unicode_ci DEFAULT 'khac',
  `anh_dai_dien` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ngay_het_han` datetime NOT NULL,
  `trang_thai` enum('pending','verified','expired','reset_password') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`ma_xac_thuc`),
  KEY `email` (`email`),
  KEY `ma_code` (`ma_code`),
  KEY `ngay_het_han` (`ngay_het_han`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xac_thuc_email`
--

LOCK TABLES `xac_thuc_email` WRITE;
/*!40000 ALTER TABLE `xac_thuc_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `xac_thuc_email` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-09  7:52:41
