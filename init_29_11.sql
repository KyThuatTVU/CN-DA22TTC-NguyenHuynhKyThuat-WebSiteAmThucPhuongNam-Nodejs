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
INSERT INTO `album_anh` VALUES (1,'nhahang1.jpg','khong_gian','Không gian nhà hàng buổi tối','2025-09-09 23:24:19'),(2,'monan1.jpg','mon_an','Món bánh xèo miền Tây','2025-09-09 23:24:19'),(3,'album-1764226128539-217565771.jpg','mon_an','Cá lóc nướng trui - món đặc sản miền Tây','2025-11-15 15:39:42'),(4,'https://images.unsplash.com/photo-1625944525533-473f1a3d54e7?w=800','mon_an','Lẩu mắm miền Tây - hương vị đậm đà','2025-11-15 15:39:42'),(5,'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800','mon_an','Bánh xèo miền Tây giòn rụm','2025-11-15 15:39:42'),(6,'https://images.unsplash.com/photo-1567337710282-00832b415979?w=800','mon_an','Gỏi cuốn tôm thịt tươi ngon','2025-11-15 15:39:42'),(7,'https://images.unsplash.com/photo-1562059390-a761a084768e?w=800','mon_an','Cơm tấm sườn bì chả trứng','2025-11-15 15:39:42'),(8,'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=800','mon_an','Bánh mì Sài Gòn đặc biệt','2025-11-15 15:39:42'),(9,'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800','khong_gian','Không gian nhà hàng sang trọng','2025-11-15 15:39:42'),(10,'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800','khong_gian','Phòng VIP cho sự kiện đặc biệt','2025-11-15 15:39:42'),(11,'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800','khong_gian','Khu vực sân vườn thoáng mát','2025-11-15 15:39:42'),(12,'https://images.unsplash.com/photo-1592861956120-e524fc739696?w=800','khong_gian','Quầy bar hiện đại','2025-11-15 15:39:42'),(13,'https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?w=800','khong_gian','Bàn ăn gia đình ấm cúng','2025-11-15 15:39:42'),(14,'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800','su_kien','Tiệc cưới lãng mạn','2025-11-15 15:39:42'),(15,'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=800','su_kien','Tiệc sinh nhật vui vẻ','2025-11-15 15:39:42'),(16,'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800','su_kien','Sự kiện công ty chuyên nghiệp','2025-11-15 15:39:42'),(17,'https://images.unsplash.com/photo-1505236858219-8359eb29e329?w=800','su_kien','Tiệc tất niên cuối năm','2025-11-15 15:39:42'),(18,'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800','khach_hang','Gia đình sum vầy hạnh phúc','2025-11-15 15:39:42'),(19,'https://images.unsplash.com/photo-1544025162-d76694265947?w=800','khach_hang','Khách hàng hài lòng với dịch vụ','2025-11-15 15:39:42'),(20,'https://images.unsplash.com/photo-1529119368496-2dfda6ec2804?w=800','khach_hang','Bạn bè quây quần vui vẻ','2025-11-15 15:39:42'),(21,'https://images.unsplash.com/photo-1543007631-283050bb3e8c?w=800','khach_hang','Khoảnh khắc đáng nhớ của khách hàng','2025-11-15 15:39:42');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `binh_luan_tin_tuc`
--

LOCK TABLES `binh_luan_tin_tuc` WRITE;
/*!40000 ALTER TABLE `binh_luan_tin_tuc` DISABLE KEYS */;
INSERT INTO `binh_luan_tin_tuc` VALUES (11,6,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Chúc mừng nhà hàng khai trương chi nhánh mới! Mình rất mong được đến thử không gian mới này.',NULL,'2025-11-15 10:30:00','approved',NULL),(12,6,2,'Trần Văn Hùng','hung.tran@gmail.com','Ưu đãi khai trương rất hấp dẫn! Mình sẽ rủ gia đình đến ăn cuối tuần này.',NULL,'2025-11-15 14:20:00','approved',NULL),(13,6,3,'Lê Thị Hoa','hoa.le@gmail.com','Không gian nhìn rất đẹp và sang trọng. Chắc chắn sẽ ghé thăm!',NULL,'2025-11-16 09:15:00','approved',NULL),(14,7,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Bài viết rất hữu ích! Mình đã biết thêm nhiều món ăn ngon của miền Nam.',NULL,'2025-11-15 16:45:00','approved',NULL),(15,7,5,'Võ Thị Lan','lan.vo@gmail.com','Cảm ơn nhà hàng đã chia sẻ. Mình sẽ thử hết các món này!',NULL,'2025-11-16 11:30:00','approved',NULL),(16,8,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Workshop rất bổ ích! Mình đã học được nhiều kỹ năng nấu ăn mới.',NULL,'2025-11-16 15:20:00','approved',NULL),(17,9,2,'Trần Văn Hùng','hung.tran@gmail.com','Khuyến mãi cuối tuần quá tuyệt vời! Đã đặt bàn cho gia đình rồi.',NULL,'2025-11-17 10:00:00','approved',NULL),(18,9,3,'Lê Thị Hoa','hoa.le@gmail.com','Mình vừa sử dụng mã giảm giá, rất hài lòng với dịch vụ!',NULL,'2025-11-17 14:30:00','approved',NULL),(19,10,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Đặc sản mùa vụ rất tươi ngon! Đúng chuẩn vị miền Tây.',NULL,'2025-11-18 12:45:00','approved',NULL),(20,10,5,'Võ Thị Lan','lan.vo@gmail.com','Bài viết giới thiệu rất chi tiết. Mình sẽ đến thử món này!',NULL,'2025-11-18 16:00:00','approved',NULL),(21,6,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Chúc mừng nhà hàng khai trương chi nhánh mới! Mình rất mong được đến thử không gian mới này.',NULL,'2025-11-15 10:30:00','approved',NULL),(22,6,2,'Trần Văn Hùng','hung.tran@gmail.com','Ưu đãi khai trương rất hấp dẫn! Mình sẽ rủ gia đình đến ăn cuối tuần này.',NULL,'2025-11-15 14:20:00','approved',NULL),(23,6,3,'Lê Thị Hoa','hoa.le@gmail.com','Không gian nhìn rất đẹp và sang trọng. Chắc chắn sẽ ghé thăm!',NULL,'2025-11-16 09:15:00','approved',NULL),(24,7,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Bài viết rất hữu ích! Mình đã biết thêm nhiều món ăn ngon của miền Nam.',NULL,'2025-11-15 16:45:00','approved',NULL),(25,7,5,'Võ Thị Lan','lan.vo@gmail.com','Cảm ơn nhà hàng đã chia sẻ. Mình sẽ thử hết các món này!',NULL,'2025-11-16 11:30:00','approved',NULL),(26,8,1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','Workshop rất bổ ích! Mình đã học được nhiều kỹ năng nấu ăn mới.',NULL,'2025-11-16 15:20:00','approved',NULL),(27,9,2,'Trần Văn Hùng','hung.tran@gmail.com','Khuyến mãi cuối tuần quá tuyệt vời! Đã đặt bàn cho gia đình rồi.',NULL,'2025-11-17 10:00:00','approved',NULL),(28,9,3,'Lê Thị Hoa','hoa.le@gmail.com','Mình vừa sử dụng mã giảm giá, rất hài lòng với dịch vụ!',NULL,'2025-11-17 14:30:00','approved',NULL),(29,10,4,'Phạm Minh Tuấn','tuan.pham@gmail.com','Đặc sản mùa vụ rất tươi ngon! Đúng chuẩn vị miền Tây.',NULL,'2025-11-18 12:45:00','approved',NULL),(30,10,5,'Võ Thị Lan','lan.vo@gmail.com','Bài viết giới thiệu rất chi tiết. Mình sẽ đến thử món này!',NULL,'2025-11-18 16:00:00','approved',NULL),(31,6,6,'Hồ Quang Vinh','quangvinhho000@gmail.com','Sẽ ghé lại',NULL,'2025-11-29 13:40:59','approved',NULL),(32,6,6,'Hồ Quang Vinh','quangvinhho000@gmail.com','ko',NULL,'2025-11-29 13:50:47','approved',23);
/*!40000 ALTER TABLE `binh_luan_tin_tuc` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cam_xuc_binh_luan`
--

LOCK TABLES `cam_xuc_binh_luan` WRITE;
/*!40000 ALTER TABLE `cam_xuc_binh_luan` DISABLE KEYS */;
INSERT INTO `cam_xuc_binh_luan` VALUES (1,31,6,'love','2025-11-29 13:52:39'),(2,22,6,'haha','2025-11-29 13:55:12');
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang`
--

LOCK TABLES `chi_tiet_don_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang` VALUES (1,1,1,2,45000.00),(2,1,6,1,30000.00),(3,1,16,2,25000.00),(4,2,2,3,40000.00),(5,2,7,2,35000.00),(6,2,11,5,20000.00),(7,3,3,2,35000.00),(8,3,8,1,45000.00),(9,3,12,4,15000.00),(10,4,21,1,250000.00),(11,4,4,2,50000.00),(12,4,16,4,25000.00),(13,5,5,3,55000.00),(14,5,10,2,50000.00),(15,5,22,1,280000.00),(16,6,25,1,70000.00),(17,7,24,1,85000.00),(18,8,24,1,85000.00),(19,8,25,1,70000.00),(20,9,24,1,85000.00),(21,10,24,1,85000.00),(22,11,24,1,85000.00),(23,11,25,1,70000.00),(24,12,24,1,85000.00),(25,13,24,1,85000.00),(26,14,25,1,70000.00),(27,15,24,1,85000.00),(28,16,24,1,85000.00),(29,17,24,1,85000.00),(30,18,23,1,80000.00),(31,19,24,1,85000.00),(32,20,24,1,85000.00),(33,21,24,1,85000.00),(34,22,24,1,85000.00),(35,23,23,1,80000.00),(36,24,24,1,85000.00),(37,25,20,1,30000.00),(38,26,24,1,85000.00),(39,27,24,1,85000.00),(40,28,25,1,70000.00),(41,29,24,1,85000.00),(42,30,22,1,40000.00),(43,31,24,1,85000.00),(44,32,24,1,85000.00),(45,32,23,1,80000.00),(46,33,24,1,85000.00),(47,34,24,1,85000.00),(48,35,23,1,80000.00),(49,36,23,1,80000.00),(50,37,24,1,85000.00),(51,38,23,1,80000.00),(52,39,24,1,85000.00),(53,40,24,1,85000.00),(54,41,24,1,85000.00),(55,42,24,1,85000.00),(56,43,24,1,85000.00),(57,44,24,1,85000.00),(58,45,24,1,85000.00),(59,46,24,1,85000.00),(60,47,24,1,85000.00),(61,48,24,1,85000.00),(62,49,24,1,85000.00),(63,50,24,1,85000.00),(64,51,24,1,85000.00),(65,52,24,1,85000.00),(66,53,24,1,85000.00),(67,54,24,1,85000.00),(68,55,24,1,85000.00),(69,56,24,1,85000.00),(70,57,24,1,85000.00),(71,58,24,1,85000.00),(72,59,24,1,85000.00),(73,60,24,1,85000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_gio_hang`
--

LOCK TABLES `chi_tiet_gio_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_gio_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_gio_hang` VALUES (1,1,1,2,45000.00),(2,1,6,1,30000.00),(3,3,11,3,20000.00),(4,4,16,2,25000.00),(5,4,21,1,250000.00),(6,6,24,1,85000.00),(7,6,22,1,40000.00),(8,6,21,1,30000.00),(9,6,25,1,70000.00),(10,7,25,1,70000.00),(11,8,24,1,85000.00),(12,9,24,1,85000.00),(13,9,25,1,70000.00),(14,10,24,1,85000.00),(15,11,24,1,85000.00),(16,12,24,1,85000.00),(17,12,25,1,70000.00),(18,13,24,1,85000.00),(19,14,24,1,85000.00),(20,15,25,1,70000.00),(21,16,24,1,85000.00),(22,17,24,1,85000.00),(23,18,24,1,85000.00),(24,19,23,1,80000.00),(25,20,24,1,85000.00),(26,21,24,1,85000.00),(27,22,24,1,85000.00),(28,23,24,1,85000.00),(29,24,23,1,80000.00),(30,25,24,1,85000.00),(31,26,20,1,30000.00),(32,27,24,1,85000.00),(33,28,24,1,85000.00),(34,29,25,1,70000.00),(35,30,24,1,85000.00),(36,31,22,1,40000.00),(37,32,24,1,85000.00),(38,33,24,1,85000.00),(39,33,23,1,80000.00),(40,34,24,1,85000.00),(41,35,24,1,85000.00),(42,36,23,1,80000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_hoa_don`
--

LOCK TABLES `chi_tiet_hoa_don` WRITE;
/*!40000 ALTER TABLE `chi_tiet_hoa_don` DISABLE KEYS */;
INSERT INTO `chi_tiet_hoa_don` VALUES (1,1,1,'Cơm Tấm Sườn Bì Chả',2,45000.00,90000.00),(2,1,6,'Gỏi Cuốn Tôm Thịt',1,30000.00,30000.00),(3,2,2,'Hủ Tiếu Nam Vang',3,40000.00,120000.00),(4,2,7,'Chả Giò Rế',2,35000.00,70000.00),(5,2,11,'Chè Ba Màu',5,20000.00,100000.00),(6,3,3,'Bánh Xèo Miền Tây',2,35000.00,70000.00),(7,3,8,'Gỏi Khô Bò',1,45000.00,45000.00),(8,3,12,'Bánh Flan Caramen',4,15000.00,60000.00),(9,4,21,'Lẩu Mắm Miền Tây',1,250000.00,250000.00),(10,4,4,'Bún Mắm Miền Tây',2,50000.00,100000.00),(11,4,16,'Cà Phê Sữa Đá',4,25000.00,100000.00),(12,5,5,'Cơm Chiên Dương Châu',3,55000.00,165000.00),(13,5,10,'Nem Nướng Nha Trang',2,50000.00,100000.00),(14,5,22,'Lẩu Thái Hải Sản',1,280000.00,280000.00),(15,6,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(16,7,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(17,8,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(18,8,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(19,9,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(20,10,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(21,11,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(22,11,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(23,12,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(24,13,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(25,14,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(26,15,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(27,16,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(28,17,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(29,18,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(30,19,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(31,20,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(32,21,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(33,22,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(34,23,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(35,24,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(36,25,20,'Kim Chi Tai Heo',1,30000.00,30000.00),(37,26,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(38,27,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(39,28,25,'Cà Nướng Mỡ Hành',1,70000.00,70000.00),(40,29,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(41,30,22,'Tép Rong Cháy Sả',1,40000.00,40000.00),(42,31,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(43,32,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(44,32,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(45,33,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(46,34,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(47,35,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(48,36,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(49,37,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(50,38,23,'Tôm Nướng Mật Ong',1,80000.00,80000.00),(51,39,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(52,40,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(53,41,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(54,42,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(55,43,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(56,44,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(57,45,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(58,46,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(59,47,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(60,48,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(61,49,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(62,50,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(63,51,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(64,52,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(65,53,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(66,54,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(67,55,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(68,56,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(69,57,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(70,58,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(71,59,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00),(72,60,24,'Tôm Sốt Mật Ong',1,85000.00,85000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_gia_san_pham`
--

LOCK TABLES `danh_gia_san_pham` WRITE;
/*!40000 ALTER TABLE `danh_gia_san_pham` DISABLE KEYS */;
INSERT INTO `danh_gia_san_pham` VALUES (1,1,1,5,'Cơm tấm rất ngon, sườn mềm thơm. Sẽ quay lại!',NULL,'2025-10-30 08:31:01','approved'),(2,2,2,4,'Hủ tiếu nước dùng ngọt, nhưng hơi ít tôm',NULL,'2025-10-30 08:31:01','approved'),(3,6,3,5,'Gỏi cuốn tươi ngon, rau sạch. Nước chấm đậm đà',NULL,'2025-10-30 08:31:01','approved'),(4,21,1,5,'Lẩu mắm đậm đà chuẩn vị miền Tây. Tuyệt vời!',NULL,'2025-10-30 08:31:01','approved'),(5,11,4,3,'Chè bình thường, không có gì đặc biệt',NULL,'2025-10-30 08:31:01','pending'),(6,24,6,3,'Món ăn hấp dẫn, sẽ ủng hộ\n',NULL,'2025-11-28 13:43:59','approved');
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
INSERT INTO `dat_ban` VALUES (1,'Nguyễn Văn A','0906123456',4,'2025-10-15','12:00:00','Đặt bàn gần cửa sổ','confirmed','2025-10-30 08:31:01'),(2,'Trần Thị B','0907234567',6,'2025-10-15','18:30:00','Có trẻ em, cần ghế cao','pending','2025-10-30 08:31:01'),(3,'Lê Văn C','0908345678',2,'2025-10-16','19:00:00','Đặt bàn riêng tư','confirmed','2025-10-30 08:31:01'),(4,'Phạm Thị D','0909456789',8,'2025-10-17','12:30:00','Tiệc sinh nhật, cần trang trí','pending','2025-10-30 08:31:01'),(5,'Hoàng Văn E','0910567890',3,'2025-10-18','20:00:00','Không ghi chú','confirmed','2025-10-30 08:31:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_hang`
--

LOCK TABLES `don_hang` WRITE;
/*!40000 ALTER TABLE `don_hang` DISABLE KEYS */;
INSERT INTO `don_hang` VALUES (1,1,NULL,NULL,'123 Lê Lợi, Q1, TP.HCM',120000.00,'delivered','cod','2025-10-30 08:31:01','Giao trước 12h','GIAM50K',50000.00),(2,2,NULL,NULL,'456 Nguyễn Huệ, Q1, TP.HCM',315000.00,'preparing','cod','2025-10-30 08:31:01','Không giao cuối tuần',NULL,0.00),(3,3,NULL,NULL,'789 Trần Hưng Đạo, Q5, TP.HCM',180000.00,'confirmed','cod','2025-10-30 08:31:01',NULL,'THANHVIEN10',18000.00),(4,NULL,'Võ Văn F','0916666666','111 Pasteur, Q3, TP.HCM',450000.00,'delivered','cod','2025-10-30 08:31:01','Khách vãng lai',NULL,0.00),(5,4,NULL,NULL,'321 Điện Biên Phủ, Q3, TP.HCM',560000.00,'cancelled','cod','2025-10-30 08:31:01','Khách hủy đơn',NULL,0.00),(6,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đông Thạnh, Thị xã Bình Minh, Tỉnh Vĩnh Long',100000.00,'pending','cod','2025-11-22 12:00:12',NULL,NULL,0.00),(7,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Long Mỹ, Huyện Giồng Trôm, Tỉnh Bến Tre',115000.00,'pending','cod','2025-11-22 13:04:18',NULL,NULL,0.00),(8,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',155000.00,'pending','cod','2025-11-22 13:06:11',NULL,NULL,0.00),(9,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:08:00',NULL,NULL,0.00),(10,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Đông Thuận, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:09:40',NULL,NULL,0.00),(11,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',155000.00,'pending','cod','2025-11-22 13:12:44',NULL,NULL,0.00),(12,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã An Ngãi Tây, Huyện Ba Tri, Tỉnh Bến Tre',115000.00,'pending','cod','2025-11-22 13:14:05',NULL,NULL,0.00),(13,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Ea Ral, Huyện Ea H\'leo, Tỉnh Đắk Lắk',115000.00,'pending','cod','2025-11-22 13:15:52',NULL,NULL,0.00),(14,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phú Quới, Huyện Long Hồ, Tỉnh Vĩnh Long',100000.00,'pending','cod','2025-11-22 13:18:06',NULL,NULL,0.00),(15,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tích Thiện, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:20:45',NULL,NULL,0.00),(16,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:26:21',NULL,NULL,0.00),(17,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Thị trấn Tân Quới, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:27:57',NULL,NULL,0.00),(18,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường 2, Thành phố Bảo Lộc, Tỉnh Lâm Đồng',110000.00,'pending','cod','2025-11-22 13:30:14',NULL,NULL,0.00),(19,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường 5, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:38:03',NULL,NULL,0.00),(20,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Bình Hòa Phước, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:39:49',NULL,NULL,0.00),(21,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Trường An, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:43:02',NULL,NULL,0.00),(22,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Thuận, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:46:39',NULL,NULL,0.00),(23,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hòa, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',110000.00,'pending','cod','2025-11-22 13:50:31',NULL,NULL,0.00),(24,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 13:50:55',NULL,NULL,0.00),(25,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Vĩnh Hòa, Huyện Ba Tri, Tỉnh Bến Tre',60000.00,'pending','cod','2025-11-22 13:51:55',NULL,NULL,0.00),(26,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Bình Hòa Phước, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:03:06',NULL,NULL,0.00),(27,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:14:27',NULL,NULL,0.00),(28,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',100000.00,'pending','cod','2025-11-22 14:17:36',NULL,NULL,0.00),(29,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Thanh Đức, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:18:47',NULL,NULL,0.00),(30,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Hòa, Thị xã Bình Minh, Tỉnh Vĩnh Long',70000.00,'pending','cod','2025-11-22 14:20:19',NULL,NULL,0.00),(31,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ An, Huyện Mang Thít, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:25:21',NULL,NULL,0.00),(32,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Lộc, Huyện Tam Bình, Tỉnh Vĩnh Long',165000.00,'pending','cod','2025-11-22 14:31:54',NULL,NULL,0.00),(33,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-22 14:36:15',NULL,NULL,0.00),(34,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phú Quới, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'cancelled','cod','2025-11-22 14:47:44','\nKhách hàng hủy đơn',NULL,0.00),(35,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Phước, Huyện Mang Thít, Tỉnh Vĩnh Long',110000.00,'pending','cod','2025-11-22 14:56:07',NULL,NULL,0.00),(36,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',110000.00,'cancelled','cod','2025-11-23 12:52:04','\nKhách hàng hủy đơn',NULL,0.00),(37,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phong Phú, Huyện Cầu Kè, Tỉnh Trà Vinh',115000.00,'pending','cod','2025-11-23 13:00:02',NULL,NULL,0.00),(38,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',110000.00,'pending','cod','2025-11-23 13:03:17',NULL,NULL,0.00),(39,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường 4, Thành phố Trà Vinh, Tỉnh Trà Vinh',115000.00,'pending','cod','2025-11-23 14:47:33',NULL,NULL,0.00),(40,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 14:52:43',NULL,NULL,0.00),(41,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tân Long, Huyện Mang Thít, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 14:55:25',NULL,NULL,0.00),(42,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 14:58:44',NULL,NULL,0.00),(43,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã An Bình, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:03:43',NULL,NULL,0.00),(44,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã An Bình, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:07:26',NULL,NULL,0.00),(45,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Phú Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:15:41',NULL,NULL,0.00),(46,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tân Bình, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:24:56',NULL,NULL,0.00),(47,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 15:26:35',NULL,NULL,0.00),(48,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Mỹ Hòa, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'preparing','cod','2025-11-23 15:39:13',NULL,NULL,0.00),(49,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Đông Thuận, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'confirmed','cod','2025-11-23 15:40:54',NULL,NULL,0.00),(50,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Thị trấn Tân Quới, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'confirmed','cod','2025-11-23 15:47:23',NULL,NULL,0.00),(51,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đông Thành, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:03:30',NULL,NULL,0.00),(52,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:07:47',NULL,NULL,0.00),(53,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Đông Thuận, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:12:16',NULL,NULL,0.00),(54,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:19:37',NULL,NULL,0.00),(55,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Lục Sỹ Thành, Huyện Trà Ôn, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:22:19',NULL,NULL,0.00),(56,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:30:05',NULL,NULL,0.00),(57,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Phường Tân Hội, Thành phố Vĩnh Long, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-23 16:30:11',NULL,NULL,0.00),(58,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đông Thành, Thị xã Bình Minh, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-28 15:35:58',NULL,NULL,0.00),(59,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Đồng Phú, Huyện Long Hồ, Tỉnh Vĩnh Long',115000.00,'pending','cod','2025-11-28 15:40:56',NULL,NULL,0.00),(60,6,'Hồ Quang Vinh','0355745120','Cầu Kè, Xã Tân Bình, Huyện Bình Tân, Tỉnh Vĩnh Long',115000.00,'delivered','cod','2025-11-28 15:43:20',NULL,NULL,0.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gio_hang`
--

LOCK TABLES `gio_hang` WRITE;
/*!40000 ALTER TABLE `gio_hang` DISABLE KEYS */;
INSERT INTO `gio_hang` VALUES (1,1,'2025-10-30 08:31:01','active'),(2,2,'2025-10-30 08:31:01','ordered'),(3,3,'2025-10-30 08:31:01','active'),(4,4,'2025-10-30 08:31:01','active'),(5,5,'2025-10-30 08:31:01','abandoned'),(6,7,'2025-11-05 15:48:43','active'),(7,6,'2025-11-22 11:34:58','ordered'),(8,6,'2025-11-22 13:04:03','ordered'),(9,6,'2025-11-22 13:06:00','ordered'),(10,6,'2025-11-22 13:07:44','ordered'),(11,6,'2025-11-22 13:09:27','ordered'),(12,6,'2025-11-22 13:12:27','ordered'),(13,6,'2025-11-22 13:13:53','ordered'),(14,6,'2025-11-22 13:15:31','ordered'),(15,6,'2025-11-22 13:17:16','ordered'),(16,6,'2025-11-22 13:20:16','ordered'),(17,6,'2025-11-22 13:26:13','ordered'),(18,6,'2025-11-22 13:27:47','ordered'),(19,6,'2025-11-22 13:30:02','ordered'),(20,6,'2025-11-22 13:37:50','ordered'),(21,6,'2025-11-22 13:39:30','ordered'),(22,6,'2025-11-22 13:42:53','ordered'),(23,6,'2025-11-22 13:46:31','ordered'),(24,6,'2025-11-22 13:50:22','ordered'),(25,6,'2025-11-22 13:50:46','ordered'),(26,6,'2025-11-22 13:51:45','ordered'),(27,6,'2025-11-22 14:02:57','ordered'),(28,6,'2025-11-22 14:14:18','ordered'),(29,6,'2025-11-22 14:17:25','ordered'),(30,6,'2025-11-22 14:18:37','ordered'),(31,6,'2025-11-22 14:20:09','ordered'),(32,6,'2025-11-22 14:25:10','ordered'),(33,6,'2025-11-22 14:31:40','ordered'),(34,6,'2025-11-22 14:35:57','ordered'),(35,6,'2025-11-22 14:47:33','ordered'),(36,6,'2025-11-22 14:55:48','ordered'),(37,6,'2025-11-23 12:51:44','active');
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoa_don`
--

LOCK TABLES `hoa_don` WRITE;
/*!40000 ALTER TABLE `hoa_don` DISABLE KEYS */;
INSERT INTO `hoa_don` VALUES (1,1,1,1,120000.00,'2025-10-30 08:31:01','issued'),(2,2,2,2,315000.00,'2025-10-30 08:31:01','issued'),(3,3,3,3,180000.00,'2025-10-30 08:31:01','issued'),(4,4,4,NULL,450000.00,'2025-10-30 08:31:01','issued'),(5,5,5,4,560000.00,'2025-10-30 08:31:01','cancelled'),(6,6,6,6,100000.00,'2025-11-22 12:00:12','issued'),(7,7,7,6,115000.00,'2025-11-22 13:04:18','issued'),(8,8,8,6,155000.00,'2025-11-22 13:06:11','issued'),(9,9,10,6,115000.00,'2025-11-22 13:08:00','issued'),(10,10,12,6,115000.00,'2025-11-22 13:09:40','issued'),(11,11,14,6,155000.00,'2025-11-22 13:12:44','issued'),(12,12,16,6,115000.00,'2025-11-22 13:14:05','issued'),(13,13,18,6,115000.00,'2025-11-22 13:15:52','issued'),(14,14,20,6,100000.00,'2025-11-22 13:18:06','issued'),(15,15,22,6,115000.00,'2025-11-22 13:20:45','issued'),(16,16,24,6,115000.00,'2025-11-22 13:26:22','issued'),(17,17,26,6,115000.00,'2025-11-22 13:27:57','issued'),(18,18,28,6,110000.00,'2025-11-22 13:30:14','issued'),(19,19,30,6,115000.00,'2025-11-22 13:38:03','issued'),(20,20,32,6,115000.00,'2025-11-22 13:39:49','issued'),(21,21,34,6,115000.00,'2025-11-22 13:43:02','issued'),(22,22,36,6,115000.00,'2025-11-22 13:46:39','issued'),(23,23,38,6,110000.00,'2025-11-22 13:50:31','issued'),(24,24,40,6,115000.00,'2025-11-22 13:50:55','issued'),(25,25,41,6,60000.00,'2025-11-22 13:51:55','issued'),(26,26,43,6,115000.00,'2025-11-22 14:03:06','issued'),(27,27,45,6,115000.00,'2025-11-22 14:14:27','issued'),(28,28,47,6,100000.00,'2025-11-22 14:17:36','issued'),(29,29,49,6,115000.00,'2025-11-22 14:18:47','issued'),(30,30,51,6,70000.00,'2025-11-22 14:20:19','issued'),(31,31,53,6,115000.00,'2025-11-22 14:25:21','issued'),(32,32,55,6,165000.00,'2025-11-22 14:31:54','issued'),(33,33,57,6,115000.00,'2025-11-22 14:36:15','issued'),(34,34,59,6,115000.00,'2025-11-22 14:47:44','cancelled'),(35,35,61,6,110000.00,'2025-11-22 14:56:07','issued'),(36,36,66,6,110000.00,'2025-11-23 12:52:04','cancelled'),(37,37,68,6,115000.00,'2025-11-23 13:00:02','issued'),(38,38,69,6,110000.00,'2025-11-23 13:03:17','issued'),(39,39,70,6,115000.00,'2025-11-23 14:47:33','issued'),(40,40,72,6,115000.00,'2025-11-23 14:52:43','issued'),(41,41,74,6,115000.00,'2025-11-23 14:55:25','issued'),(42,42,76,6,115000.00,'2025-11-23 14:58:44','issued'),(43,43,78,6,115000.00,'2025-11-23 15:03:43','issued'),(44,44,80,6,115000.00,'2025-11-23 15:07:26','issued'),(45,45,82,6,115000.00,'2025-11-23 15:15:41','issued'),(46,46,84,6,115000.00,'2025-11-23 15:24:56','issued'),(47,47,86,6,115000.00,'2025-11-23 15:26:35','issued'),(48,48,88,6,115000.00,'2025-11-23 15:39:13','issued'),(49,49,90,6,115000.00,'2025-11-23 15:40:54','issued'),(50,50,92,6,115000.00,'2025-11-23 15:47:23','issued'),(51,51,94,6,115000.00,'2025-11-23 16:03:30','issued'),(52,52,96,6,115000.00,'2025-11-23 16:07:47','issued'),(53,53,98,6,115000.00,'2025-11-23 16:12:16','issued'),(54,54,100,6,115000.00,'2025-11-23 16:19:37','issued'),(55,55,101,6,115000.00,'2025-11-23 16:22:19','issued'),(56,56,102,6,115000.00,'2025-11-23 16:30:05','issued'),(57,57,103,6,115000.00,'2025-11-23 16:30:11','issued'),(58,58,104,6,115000.00,'2025-11-28 15:35:58','issued'),(59,59,105,6,115000.00,'2025-11-28 15:40:56','issued'),(60,60,106,6,115000.00,'2025-11-28 15:43:20','issued');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_chatbot`
--

LOCK TABLES `lich_su_chatbot` WRITE;
/*!40000 ALTER TABLE `lich_su_chatbot` DISABLE KEYS */;
INSERT INTO `lich_su_chatbot` VALUES (1,1,'SESSION_001','user','Cho tôi xem menu món chính','2025-10-30 08:31:01'),(2,1,'SESSION_001','bot','Dạ, đây là danh sách các món chính: Cơm Tấm Sườn Bì Chả, Hủ Tiếu Nam Vang, Bánh Xèo Miền Tây...','2025-10-30 08:31:01'),(3,2,'SESSION_002','user','Món nào dưới 50k?','2025-10-30 08:31:01'),(4,2,'SESSION_002','bot','Các món dưới 50k gồm: Hủ Tiếu Nam Vang (40k), Bánh Xèo Miền Tây (35k), Gỏi Cuốn (30k)...','2025-10-30 08:31:01'),(5,3,'SESSION_003','user','Nhà hàng có giao hàng không?','2025-10-30 08:31:01'),(6,3,'SESSION_003','bot','Có ạ, chúng tôi có dịch vụ giao hàng tận nơi. Miễn phí ship cho đơn từ 150k','2025-10-30 08:31:01'),(7,4,'SESSION_004','user','Làm sao để đặt bàn?','2025-10-30 08:31:01'),(8,4,'SESSION_004','bot','Quý khách có thể đặt bàn qua website hoặc gọi hotline: 1900-xxxx','2025-10-30 08:31:01'),(9,5,'SESSION_005','user','Có khuyến mãi gì không?','2025-10-30 08:31:01'),(10,5,'SESSION_005','bot','Hiện tại có mã KHAI_TRUONG giảm 20% và GIAM50K giảm 50k cho đơn từ 300k ạ','2025-10-30 08:31:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lưu lịch sử thay đổi trạng thái đơn hàng';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_trang_thai_don_hang`
--

LOCK TABLES `lich_su_trang_thai_don_hang` WRITE;
/*!40000 ALTER TABLE `lich_su_trang_thai_don_hang` DISABLE KEYS */;
INSERT INTO `lich_su_trang_thai_don_hang` VALUES (1,1,NULL,'delivered',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(2,2,NULL,'preparing',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(3,3,NULL,'confirmed',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(4,4,NULL,'delivered',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(5,5,NULL,'cancelled',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-10-30 01:31:01'),(6,6,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 05:00:12'),(7,7,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:04:18'),(8,8,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:06:11'),(9,9,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:08:00'),(10,10,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:09:40'),(11,11,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:12:44'),(12,12,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:14:05'),(13,13,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:15:52'),(14,14,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:18:06'),(15,15,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:20:45'),(16,16,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:26:21'),(17,17,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:27:57'),(18,18,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:30:14'),(19,19,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:38:03'),(20,20,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:39:49'),(21,21,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:43:02'),(22,22,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:46:39'),(23,23,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:50:31'),(24,24,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:50:55'),(25,25,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 06:51:55'),(26,26,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:03:06'),(27,27,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:14:27'),(28,28,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:17:36'),(29,29,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:18:47'),(30,30,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:20:19'),(31,31,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:25:21'),(32,32,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:31:54'),(33,33,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:36:15'),(34,34,NULL,'cancelled',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:47:44'),(35,35,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-22 07:56:07'),(36,36,NULL,'cancelled',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 05:52:04'),(37,37,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 06:00:02'),(38,38,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 06:03:17'),(39,39,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:47:33'),(40,40,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:52:43'),(41,41,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:55:25'),(42,42,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 07:58:44'),(43,43,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:03:43'),(44,44,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:07:26'),(45,45,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:15:41'),(46,46,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:24:56'),(47,47,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:26:35'),(48,48,NULL,'pending',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:39:13'),(49,49,NULL,'confirmed',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:40:54'),(50,50,NULL,'confirmed',NULL,'system','Dữ liệu khởi tạo từ đơn hàng hiện có','2025-11-23 08:47:23'),(64,51,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:03:30'),(65,52,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:07:47'),(66,53,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:12:16'),(67,54,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:19:37'),(68,55,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:22:19'),(69,56,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:30:05'),(70,57,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-23 09:30:11'),(71,48,'pending','preparing',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-25 01:03:05'),(72,58,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-28 08:35:58'),(73,59,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-28 08:40:56'),(74,60,NULL,'pending',NULL,'system','Đơn hàng được tạo','2025-11-28 08:43:20'),(75,60,'pending','confirmed',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-28 08:49:42'),(76,60,'confirmed','preparing',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-28 08:53:48'),(77,60,'preparing','delivered',NULL,'system','Trạng thái đơn hàng được cập nhật','2025-11-29 05:37:03');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mon_an`
--

LOCK TABLES `mon_an` WRITE;
/*!40000 ALTER TABLE `mon_an` DISABLE KEYS */;
INSERT INTO `mon_an` VALUES (1,'Cơm Chiên Hải Sản','Cơm chiên vàng ươm, thơm ngon với hải sản tươi sống và rau củ giòn ngọt.',55000.00,80,'dĩa','/images/comchienhaisan.jpg',1,1,'2025-10-30 08:31:01'),(2,'Cơm Chiên Cá Mặn','Cơm chiên cá mặn đậm đà, dẻo thơm, ăn kèm dưa leo và trứng chiên.',50000.00,70,'dĩa','/images/comchiencaman.jpg',1,1,'2025-10-30 08:31:01'),(3,'Cá Ri Ấn Độ','Cá nấu cà ri phong cách Ấn Độ, cay nồng và béo ngậy nước cốt dừa.',65000.00,50,'phần','/images/cariando.jpg',1,1,'2025-10-30 08:31:01'),(4,'Canh Gà Chiên','Canh gà chiên giòn dùng kèm rau thơm, vị mặn mà hấp dẫn.',45000.00,60,'tô','/images/canhgachien.jpg',1,1,'2025-10-30 08:31:01'),(5,'Cá Tai Tượng Chiên Xù','Cá tai tượng chiên vàng giòn, ăn kèm rau sống và nước mắm chua ngọt.',120000.00,25,'con','/images/cataituongchienxu.jpg',1,1,'2025-10-30 09:17:48'),(6,'Gỏi Miền Tây','Gỏi tôm thịt miền Tây với rau thơm và đậu phộng rang giòn.',40000.00,70,'dĩa','/images/goimientay.jpg',2,1,'2025-10-30 08:31:01'),(7,'Gỏi Ốc Đắng','Gỏi ốc đắng chua cay, giòn sần sật hòa cùng rau răm và hành phi.',45000.00,50,'dĩa','/images/goiocdang.jpg',2,1,'2025-10-30 08:31:01'),(8,'Gỏi Heo Xủa Hành','Gỏi thịt heo thái lát trộn hành tây, rau thơm, vị chua ngọt.',50000.00,60,'dĩa','/images/gioheoxuhan.jpg',2,1,'2025-10-30 08:31:01'),(9,'Đuồi Gà Chiên','Đuôi gà chiên nước mắm thơm giòn rụm.',55000.00,40,'dĩa','/images/duigachien.jpg',2,1,'2025-10-30 08:31:01'),(10,'Chả nguội Trung Hoa','Chả nguội kiểu Trung Hoa, hương vị mới lạ, dai giòn hấp dẫn.',45000.00,60,'phần','/images/donguoitrunghoa.jpg',2,1,'2025-10-30 08:31:01'),(11,'Lẩu Tôm','Lẩu tôm tươi ngọt nước, ăn kèm rau và bún tươi.',250000.00,30,'nồi','/images/lautom.jpg',3,1,'2025-10-30 08:31:01'),(12,'Lẩu Thác Lác Khổ Qua','Lẩu cá thác lác khổ qua thanh mát, tốt cho sức khỏe.',220000.00,25,'nồi','/images/lauthaclackhoqua.jpg',3,1,'2025-10-30 08:31:01'),(13,'Lẩu Mắm Miền Tây','Lẩu mắm đậm đà hương vị miền sông nước.',270000.00,25,'nồi','/images/laumammientay.jpg',3,1,'2025-10-30 09:19:26'),(14,'Lẩu Rau Đồng','Lẩu rau đồng dân dã với nước dùng xương hầm ngọt thanh.',180000.00,20,'nồi','/images/raudong.jpg',3,1,'2025-10-30 08:31:01'),(15,'Rau Muống Xào Tỏi','Rau muống xào tỏi độc đáo và đậm đà.',200000.00,20,'nồi','/images/raumuonxaotoi.jpg',3,1,'2025-10-30 08:31:01'),(16,'Bánh Phu Thê','Bánh phu thê dẻo thơm, tượng trưng cho tình duyên bền chặt.',15000.00,100,'cái','/images/banhphuthe.jpg',4,1,'2025-10-30 08:31:01'),(17,'Bánh Huyên Ướng Nướng','Bánh trái cây nướng truyền thống ngọt dịu và thơm bơ.',20000.00,80,'cái','/images/banhuyenuong.jpg',4,1,'2025-10-30 09:19:26'),(18,'Trái Cây Tiệc Cưới','Đĩa trái cây tươi mát, trình bày nghệ thuật.',60000.00,30,'dĩa','/images/traicaytieccuoi.jpg',3,1,'2025-11-25 15:44:36'),(19,'Hoa Quả Sơn','Tráng miệng hoa quả sơn, đa sắc màu và hương vị nhiệt đới.',50000.00,40,'dĩa','/images/hoaquason.jpg',4,1,'2025-10-30 08:31:01'),(20,'Kim Chi Tai Heo','Kim chi tai heo cay nồng, kích thích vị giác.',30000.00,49,'phần','/images/kimchitauheo.jpg',4,1,'2025-11-22 13:51:55'),(21,'Nước Rau Rừng Tây Bắc','Nước ép rau rừng thanh mát, độc đáo hương vị vùng cao.',30000.00,100,'ly','/images/raurungtaybac.jpg',5,1,'2025-10-30 08:31:01'),(22,'Tép Rong Cháy Sả','Món ăn kèm uống bia nhẹ, đậm vị miền Tây.',40000.00,59,'dĩa','/images/teprongchaysa.jpg',2,1,'2025-11-25 15:44:23'),(23,'Tôm Nướng Mật Ong','Tôm nướng mật ong vàng óng, dùng với bia lạnh.',80000.00,35,'xiên','/images/tomnuongmatong.jpg',5,1,'2025-11-23 13:03:17'),(24,'Tôm Sốt Mật Ong','Tôm chiên giòn rưới mật ong, thơm ngọt đặc biệt.',85000.00,41,'dĩa','/images/tomsotmatong.jpg',1,1,'2025-11-28 15:43:20'),(25,'Cà Nướng Mỡ Hành','Cá nướng than hoa rưới mỡ hành, thơm béo.',70000.00,45,'con','/images/canuongmohanh.jpg',1,1,'2025-11-28 14:56:44');
/*!40000 ALTER TABLE `mon_an` ENABLE KEYS */;
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
  `mat_khau_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dia_chi` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gioi_tinh` enum('khac','nam','nu') COLLATE utf8mb4_unicode_ci DEFAULT 'khac',
  `anh_dai_dien` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` tinyint DEFAULT '1' COMMENT '1: Hoạt động, 0: Bị khóa',
  PRIMARY KEY (`ma_nguoi_dung`),
  UNIQUE KEY `email` (`email`),
  KEY `email_2` (`email`),
  KEY `so_dien_thoai` (`so_dien_thoai`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES (1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','0901234567','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','123 Lê Lợi, Q1, TP.HCM','nu',NULL,'2025-10-30 08:31:01',1),(2,'Trần Văn Hùng','hung.tran@gmail.com','0902345678','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','456 Nguyễn Huệ, Q1, TP.HCM','nam',NULL,'2025-10-30 08:31:01',1),(3,'Lê Thị Hoa','hoa.le@gmail.com','0903456789','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','789 Trần Hưng Đạo, Q5, TP.HCM','nu',NULL,'2025-10-30 08:31:01',1),(4,'Phạm Minh Tuấn','tuan.pham@gmail.com','0904567890','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','321 Điện Biên Phủ, Q3, TP.HCM','nam',NULL,'2025-10-30 08:31:01',1),(5,'Võ Thị Lan','lan.vo@gmail.com','0905678901','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','654 Cách Mạng Tháng 8, Q10, TP.HCM','nu',NULL,'2025-10-30 08:31:01',1),(6,'Hồ Quang Vinh','quangvinhho000@gmail.com','0355745120','$2a$10$B1CofOIMDupHM/ZGQmjcM.8QJT1cPmRlLnJDVnYeULUZJdmg4Y9Oe','Cầu Kè','nam','/images/avatars/avatar-1763781885466-232406390.jpg','2025-11-04 15:11:36',1),(7,'Lê Thị Hồng Thắm','let752149@gmail.com','0388853049','$2a$10$3ZCNLjqHnMjERIaD.KFgZ.mFGdcqZb6WaojO38WWl/zcPf6oCgh5S','Nguyễn Thiện Thành Phường Trà Vinh','nu',NULL,'2025-11-05 12:53:53',0),(8,'Đỗ Thiên Vũ','dothienvu84tv@gmail.com','0388853048','$2a$10$uLwDCYzo0TdgodcYQZM.POhR.CBxZ/oTQgCxtO/ZU8Fm17GULuVha','Phú Hòa Long Đức Trà Vinh','nam',NULL,'2025-11-05 14:52:13',1),(9,'Lê Thị Hồng Quyên','leq94328@gmail.com','0388853045','$2a$10$Dzg4gJpaulrUaPsVc3NZmOFSLERB2KkFlGfMAJo2EkaqGYjEoRb92','Phường Long Đức Tỉnh Vĩnh Long','nu',NULL,'2025-11-05 16:11:40',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thanh_toan`
--

LOCK TABLES `thanh_toan` WRITE;
/*!40000 ALTER TABLE `thanh_toan` DISABLE KEYS */;
INSERT INTO `thanh_toan` VALUES (1,1,120000.00,'momo','MOMO123456789','success','2025-10-10 11:30:00','Thanh toán qua MoMo'),(2,2,315000.00,'cash',NULL,'pending',NULL,'Thanh toán khi nhận hàng'),(3,3,180000.00,'vnpay','VNPAY987654321','success','2025-10-11 14:20:00','Thanh toán qua VNPay'),(4,4,450000.00,'cash',NULL,'success','2025-10-09 18:45:00','Thanh toán tiền mặt'),(5,5,560000.00,'zalopay','ZALO111222333','cancelled',NULL,'Giao dịch bị hủy'),(6,6,100000.00,'cod',NULL,'pending',NULL,NULL),(7,7,115000.00,'vnpay',NULL,'pending',NULL,NULL),(8,8,155000.00,'vnpay',NULL,'pending',NULL,NULL),(9,8,155000.00,'vnpay','8_1763791571734','pending',NULL,NULL),(10,9,115000.00,'vnpay',NULL,'pending',NULL,NULL),(11,9,115000.00,'vnpay','9_1763791680772','pending',NULL,NULL),(12,10,115000.00,'vnpay',NULL,'pending',NULL,NULL),(13,10,115000.00,'vnpay','10_1763791780780','pending',NULL,NULL),(14,11,155000.00,'vnpay',NULL,'pending',NULL,NULL),(15,11,155000.00,'vnpay','11_1763791964413','pending',NULL,NULL),(16,12,115000.00,'vnpay',NULL,'pending',NULL,NULL),(17,12,115000.00,'vnpay','12_1763792045154','pending',NULL,NULL),(18,13,115000.00,'vnpay',NULL,'pending',NULL,NULL),(19,13,115000.00,'vnpay','13_1763792152860','pending',NULL,NULL),(20,14,100000.00,'vnpay',NULL,'pending',NULL,NULL),(21,14,100000.00,'vnpay','14_1763792286652','pending',NULL,NULL),(22,15,115000.00,'vnpay',NULL,'pending',NULL,NULL),(23,15,115000.00,'vnpay','15_1763792445733','pending',NULL,NULL),(24,16,115000.00,'vnpay',NULL,'pending',NULL,NULL),(25,16,115000.00,'vnpay','16_1763792782011','pending',NULL,NULL),(26,17,115000.00,'vnpay',NULL,'pending',NULL,NULL),(27,17,115000.00,'vnpay','17_1763792877381','pending',NULL,NULL),(28,18,110000.00,'vnpay',NULL,'pending',NULL,NULL),(29,18,110000.00,'vnpay','18_1763793014062','pending',NULL,NULL),(30,19,115000.00,'vnpay',NULL,'pending',NULL,NULL),(31,19,115000.00,'vnpay','19_1763793484003','pending',NULL,NULL),(32,20,115000.00,'vnpay',NULL,'pending',NULL,NULL),(33,20,115000.00,'vnpay','20_1763793589750','pending',NULL,NULL),(34,21,115000.00,'vnpay',NULL,'pending',NULL,NULL),(35,21,115000.00,'vnpay','21_1763793782404','pending',NULL,NULL),(36,22,115000.00,'vnpay',NULL,'pending',NULL,NULL),(37,22,115000.00,'vnpay','22_1763793999789','pending',NULL,NULL),(38,23,110000.00,'vnpay',NULL,'pending',NULL,NULL),(39,23,110000.00,'vnpay','23_1763794231101','pending',NULL,NULL),(40,24,115000.00,'cod',NULL,'pending',NULL,NULL),(41,25,60000.00,'vnpay',NULL,'pending',NULL,NULL),(42,25,60000.00,'vnpay','25_1763794316001','pending',NULL,NULL),(43,26,115000.00,'vnpay',NULL,'pending',NULL,NULL),(44,26,115000.00,'vnpay','26_1763794986814','pending',NULL,NULL),(45,27,115000.00,'vnpay',NULL,'pending',NULL,NULL),(46,27,115000.00,'vnpay','27_1763795667459','pending',NULL,NULL),(47,28,100000.00,'vnpay',NULL,'pending',NULL,NULL),(48,28,100000.00,'vnpay','28_1763795856265','pending',NULL,NULL),(49,29,115000.00,'vnpay',NULL,'pending',NULL,NULL),(50,29,115000.00,'vnpay','29_1763795927235','pending',NULL,NULL),(51,30,70000.00,'vnpay',NULL,'pending',NULL,NULL),(52,30,70000.00,'vnpay','30_1763796019277','pending',NULL,NULL),(53,31,115000.00,'vnpay',NULL,'pending',NULL,NULL),(54,31,115000.00,'vnpay','31_1763796321442','pending',NULL,NULL),(55,32,165000.00,'vnpay',NULL,'pending',NULL,NULL),(56,32,165000.00,'vnpay','32_1763796714985','pending',NULL,NULL),(57,33,115000.00,'vnpay',NULL,'pending',NULL,NULL),(58,33,115000.00,'vnpay','33_1763796975609','pending',NULL,NULL),(59,34,115000.00,'vnpay',NULL,'cancelled',NULL,NULL),(60,34,115000.00,'vnpay','34_1763797664112','cancelled',NULL,NULL),(61,35,110000.00,'vnpay',NULL,'pending',NULL,NULL),(62,35,110000.00,'vnpay','35_1763798167082','pending',NULL,NULL),(63,35,110000.00,'vnpay','35_1763800113023','pending',NULL,NULL),(64,26,115000.00,'vnpay','26_1763800446906','pending',NULL,NULL),(65,26,115000.00,'vnpay','26_1763801127914','pending',NULL,NULL),(66,36,110000.00,'bank',NULL,'cancelled',NULL,NULL),(67,36,110000.00,'vnpay','36_1763877376236','cancelled',NULL,NULL),(68,37,115000.00,'cod',NULL,'pending',NULL,NULL),(69,38,110000.00,'cod',NULL,'pending',NULL,NULL),(70,39,115000.00,'vnpay',NULL,'pending',NULL,NULL),(71,39,115000.00,'vnpay','39_1763884053100','pending',NULL,NULL),(72,40,115000.00,'vnpay',NULL,'pending',NULL,NULL),(73,40,115000.00,'vnpay','40_1763884363205','pending',NULL,NULL),(74,41,115000.00,'vnpay',NULL,'pending',NULL,NULL),(75,41,115000.00,'vnpay','41_1763884525119','pending',NULL,NULL),(76,42,115000.00,'vnpay',NULL,'pending',NULL,NULL),(77,42,115000.00,'vnpay','42_1763884724309','pending',NULL,NULL),(78,43,115000.00,'vnpay',NULL,'pending',NULL,NULL),(79,43,115000.00,'vnpay','43_23150343','pending',NULL,NULL),(80,44,115000.00,'vnpay',NULL,'pending',NULL,NULL),(81,44,115000.00,'vnpay','44_23150726','pending',NULL,NULL),(82,45,115000.00,'vnpay',NULL,'pending',NULL,NULL),(83,45,115000.00,'vnpay','45_23151541','pending',NULL,NULL),(84,46,115000.00,'vnpay',NULL,'pending',NULL,NULL),(85,46,115000.00,'vnpay','46_23152456','pending',NULL,NULL),(86,47,115000.00,'vnpay',NULL,'pending',NULL,NULL),(87,47,115000.00,'vnpay','47_23152635','pending',NULL,NULL),(88,48,115000.00,'vnpay',NULL,'pending',NULL,NULL),(89,48,115000.00,'vnpay','48_23153913','pending',NULL,NULL),(90,49,115000.00,'vnpay',NULL,'pending',NULL,NULL),(91,49,115000.00,'vnpay','1763887408283','success','2025-11-23 08:43:28','{\"bankCode\":\"NCB\",\"amount\":115000}'),(92,50,115000.00,'vnpay',NULL,'pending',NULL,NULL),(93,50,115000.00,'vnpay','1763887658738','success','2025-11-23 08:47:38','{\"bankCode\":\"VCB\",\"amount\":115000}'),(94,51,115000.00,'vnpay',NULL,'pending',NULL,NULL),(95,51,115000.00,'vnpay','51_23160330','pending',NULL,NULL),(96,52,115000.00,'vnpay',NULL,'pending',NULL,NULL),(97,52,115000.00,'vnpay','52_23160747','pending',NULL,NULL),(98,53,115000.00,'vnpay',NULL,'pending',NULL,NULL),(99,53,115000.00,'vnpay','53_23161216','pending',NULL,NULL),(100,54,115000.00,'vnpay','54_23161937','pending',NULL,NULL),(101,55,115000.00,'vnpay','55_23162219','pending',NULL,NULL),(102,56,115000.00,'vnpay','56_23163005','pending',NULL,NULL),(103,57,115000.00,'momo','57_1764318771019','failed',NULL,'{\"resultCode\":\"1006\",\"message\":\"Giao dịch bị từ chối bởi người dùng.\"}'),(104,58,115000.00,'momo_demo',NULL,'pending',NULL,NULL),(105,59,115000.00,'momo','59_1764319256725','failed',NULL,'{\"resultCode\":\"1006\",\"message\":\"Giao dịch bị từ chối bởi người dùng.\"}'),(106,60,115000.00,'momo','60_1764319710766','success','2025-11-28 15:49:42','{\"transId\":\"4618590443\",\"payType\":\"napas\",\"message\":\"Successful.\"}');
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
INSERT INTO `tin_tuc` VALUES (6,'Khai Trương Chi Nhánh Mới Tại Vĩnh Long','Chúng tôi vui mừng thông báo khai trương chi nhánh thứ 5 tại trung tâm thành phố Vĩnh Long với không gian hiện đại và đội ngũ chuyên nghiệp.','<p>Chúng tôi vui mừng thông báo khai trương chi nhánh thứ 5 tại trung tâm thành phố Vĩnh Long. Với không gian hiện đại, rộng rãi và đội ngũ nhân viên chuyên nghiệp, chúng tôi cam kết mang đến trải nghiệm ẩm thực tuyệt vời nhất cho quý khách hàng.</p>\r\n                \r\n                <h2>Thông tin chi nhánh mới</h2>\r\n                <ul>\r\n                    <li>Địa chỉ: 123 Đường Phạm Thái Bường, Phường 4, Vĩnh Long</li>\r\n                    <li>Diện tích: 500m² với sức chứa 200 khách</li>\r\n                    <li>Giờ mở cửa: 10:00 - 22:00 hàng ngày</li>\r\n                    <li>Đặc biệt: Không gian VIP riêng tư, phù hợp tổ chức tiệc</li>\r\n                </ul>\r\n\r\n                <h2>Ưu đãi khai trương</h2>\r\n                <p>Nhân dịp khai trương, chúng tôi dành tặng quý khách:</p>\r\n                <ul>\r\n                    <li>Giảm 20% toàn bộ thực đơn trong tuần đầu tiên</li>\r\n                    <li>Tặng món tráng miệng khi hóa đơn từ 500.000đ</li>\r\n                    <li>Ưu đãi đặc biệt cho khách hàng thân thiết</li>\r\n                </ul>','images/tt2.jpg',1,'2025-11-15 15:18:50',1,836),(7,'Ra Mắt Thực Đơn Mùa Thu 2025','Khám phá những món ăn đặc trưng mùa thu với hương vị độc đáo, được chế biến từ nguyên liệu tươi ngon nhất.','<p>Chào đón mùa thu 2025, Nhà hàng Phương Nam tự hào giới thiệu thực đơn mới với những món ăn đặc trưng mang hương vị mùa thu đậm đà.</p>\n\n                <h2>Món ăn nổi bật</h2>\n                <ul>\n                    <li>Lẩu cá kèo lá giang - 350.000đ</li>\n                    <li>Gỏi bưởi tôm thịt - 180.000đ</li>\n                    <li>Cơm tấm sườn bì chả - 55.000đ</li>\n                    <li>Bánh xèo Vĩnh Long - 45.000đ</li>\n                </ul>\n\n                <p>Tất cả món ăn đều được chế biến từ nguyên liệu tươi sống, đảm bảo vệ sinh an toàn thực phẩm.</p>','images/tt1.jpg',1,'2025-11-15 15:18:50',1,943),(8,'Workshop Ẩm Thực Miền Tây - Tháng 11/2025','Tham gia workshop học nấu các món ăn truyền thống miền Tây cùng đầu bếp chuyên nghiệp của nhà hàng.','<p>Nhà hàng Phương Nam tổ chức workshop ẩm thực miền Tây dành cho những ai yêu thích nấu ăn và muốn khám phá bí quyết chế biến các món ăn truyền thống.</p>\n\n                <h2>Thông tin workshop</h2>\n                <ul>\n                    <li>Thời gian: Thứ 7 hàng tuần, 14:00 - 17:00</li>\n                    <li>Địa điểm: Nhà hàng Phương Nam - Chi nhánh 1</li>\n                    <li>Học phí: 350.000đ/người (bao gồm nguyên liệu)</li>\n                    <li>Số lượng: Giới hạn 15 người/buổi</li>\n                </ul>\n\n                <h2>Nội dung học</h2>\n                <ul>\n                    <li>Cách chọn nguyên liệu tươi ngon</li>\n                    <li>Kỹ thuật chế biến món lẩu</li>\n                    <li>Bí quyết làm nước mắm pha</li>\n                    <li>Trình bày món ăn chuyên nghiệp</li>\n                </ul>','images/banner-1.jpg',1,'2025-11-15 15:18:50',1,804),(9,'Chương Trình Khuyến Mãi Cuối Tuần','Giảm giá 15% cho tất cả các món ăn vào thứ 7 và Chủ nhật. Áp dụng cho cả đơn hàng tại nhà hàng và giao hàng.','<p>Cuối tuần này hãy đến Nhà hàng Phương Nam để thưởng thức những món ăn ngon với ưu đãi đặc biệt!</p>\n\n                <h2>Ưu đãi chi tiết</h2>\n                <ul>\n                    <li>Giảm 15% toàn bộ thực đơn</li>\n                    <li>Tặng nước uống cho hóa đơn từ 300.000đ</li>\n                    <li>Freeship cho đơn hàng từ 200.000đ trong bán kính 5km</li>\n                </ul>\n\n                <h2>Điều kiện áp dụng</h2>\n                <ul>\n                    <li>Áp dụng: Thứ 7 và Chủ nhật hàng tuần</li>\n                    <li>Không áp dụng đồng thời với chương trình khuyến mãi khác</li>\n                    <li>Đặt bàn trước để được phục vụ tốt nhất</li>\n                </ul>','images/banner-2.jpg',1,'2025-11-15 15:18:50',1,447),(10,'Đặc Sản Mùa Vụ - Tháng 11','Thưởng thức các món ăn được chế biến từ đặc sản mùa vụ của miền Tây, mang đến hương vị đậm đà nhất.','<p>Tháng 11 là mùa của nhiều đặc sản miền Tây. Nhà hàng Phương Nam chọn lọc những nguyên liệu tươi ngon nhất để chế biến các món ăn đặc trưng.</p>\n\n                <h2>Món ăn mùa vụ</h2>\n                <ul>\n                    <li>Lẩu mắm cá linh - 380.000đ</li>\n                    <li>Cá kèo kho tộ - 220.000đ</li>\n                    <li>Ốc hấp sả - 150.000đ</li>\n                    <li>Gỏi cá trích - 180.000đ</li>\n                </ul>\n\n                <p>Các món ăn chỉ có trong mùa, không thể bỏ lỡ!</p>','images/album1.jpg',1,'2025-11-15 15:18:50',1,865);
/*!40000 ALTER TABLE `tin_tuc` ENABLE KEYS */;
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

-- Dump completed on 2025-11-29 16:13:51
