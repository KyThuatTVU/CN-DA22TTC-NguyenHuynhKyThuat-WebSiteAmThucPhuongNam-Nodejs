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
  `quyen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'superadmin',
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_admin`),
  UNIQUE KEY `tai_khoan` (`tai_khoan`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin1','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Nguyễn Văn An','admin1@phuongnam.vn','superadmin','2025-10-30 08:31:01'),(2,'admin2','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Trần Thị Bình','admin2@phuongnam.vn','admin','2025-10-30 08:31:01'),(3,'admin3','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Lê Văn Cường','admin3@phuongnam.vn','moderator','2025-10-30 08:31:01'),(4,'admin4','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Phạm Thị Dung','admin4@phuongnam.vn','admin','2025-10-30 08:31:01'),(5,'admin5','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','Hoàng Văn Em','admin5@phuongnam.vn','moderator','2025-10-30 08:31:01');
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
  `duong_dan_anh` varchar(500) NOT NULL,
  `loai_anh` varchar(100) DEFAULT 'khong_ro',
  `mo_ta` varchar(255) DEFAULT NULL,
  `ngay_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_album`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_anh`
--

LOCK TABLES `album_anh` WRITE;
/*!40000 ALTER TABLE `album_anh` DISABLE KEYS */;
INSERT INTO `album_anh` VALUES (1,'nhahang1.jpg','khong_gian','Không gian nhà hàng buổi tối','2025-09-09 23:24:19'),(2,'monan1.jpg','mon_an','Món bánh xèo miền Tây','2025-09-09 23:24:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang`
--

LOCK TABLES `chi_tiet_don_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang` VALUES (1,1,1,2,45000.00),(2,1,6,1,30000.00),(3,1,16,2,25000.00),(4,2,2,3,40000.00),(5,2,7,2,35000.00),(6,2,11,5,20000.00),(7,3,3,2,35000.00),(8,3,8,1,45000.00),(9,3,12,4,15000.00),(10,4,21,1,250000.00),(11,4,4,2,50000.00),(12,4,16,4,25000.00),(13,5,5,3,55000.00),(14,5,10,2,50000.00),(15,5,22,1,280000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_gio_hang`
--

LOCK TABLES `chi_tiet_gio_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_gio_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_gio_hang` VALUES (1,1,1,2,45000.00),(2,1,6,1,30000.00),(3,3,11,3,20000.00),(4,4,16,2,25000.00),(5,4,21,1,250000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_hoa_don`
--

LOCK TABLES `chi_tiet_hoa_don` WRITE;
/*!40000 ALTER TABLE `chi_tiet_hoa_don` DISABLE KEYS */;
INSERT INTO `chi_tiet_hoa_don` VALUES (1,1,1,'Cơm Tấm Sườn Bì Chả',2,45000.00,90000.00),(2,1,6,'Gỏi Cuốn Tôm Thịt',1,30000.00,30000.00),(3,2,2,'Hủ Tiếu Nam Vang',3,40000.00,120000.00),(4,2,7,'Chả Giò Rế',2,35000.00,70000.00),(5,2,11,'Chè Ba Màu',5,20000.00,100000.00),(6,3,3,'Bánh Xèo Miền Tây',2,35000.00,70000.00),(7,3,8,'Gỏi Khô Bò',1,45000.00,45000.00),(8,3,12,'Bánh Flan Caramen',4,15000.00,60000.00),(9,4,21,'Lẩu Mắm Miền Tây',1,250000.00,250000.00),(10,4,4,'Bún Mắm Miền Tây',2,50000.00,100000.00),(11,4,16,'Cà Phê Sữa Đá',4,25000.00,100000.00),(12,5,5,'Cơm Chiên Dương Châu',3,55000.00,165000.00),(13,5,10,'Nem Nướng Nha Trang',2,50000.00,100000.00),(14,5,22,'Lẩu Thái Hải Sản',1,280000.00,280000.00);
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
  `ngay_danh_gia` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trang_thai` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`ma_danh_gia`),
  KEY `ma_mon` (`ma_mon`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `danh_gia_san_pham_ibfk_1` FOREIGN KEY (`ma_mon`) REFERENCES `mon_an` (`ma_mon`) ON DELETE CASCADE,
  CONSTRAINT `danh_gia_san_pham_ibfk_2` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_gia_san_pham`
--

LOCK TABLES `danh_gia_san_pham` WRITE;
/*!40000 ALTER TABLE `danh_gia_san_pham` DISABLE KEYS */;
INSERT INTO `danh_gia_san_pham` VALUES (1,1,1,5,'Cơm tấm rất ngon, sườn mềm thơm. Sẽ quay lại!','2025-10-30 08:31:01','approved'),(2,2,2,4,'Hủ tiếu nước dùng ngọt, nhưng hơi ít tôm','2025-10-30 08:31:01','approved'),(3,6,3,5,'Gỏi cuốn tươi ngon, rau sạch. Nước chấm đậm đà','2025-10-30 08:31:01','approved'),(4,21,1,5,'Lẩu mắm đậm đà chuẩn vị miền Tây. Tuyệt vời!','2025-10-30 08:31:01','approved'),(5,11,4,3,'Chè bình thường, không có gì đặc biệt','2025-10-30 08:31:01','pending');
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
  `thoi_gian_tao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ghi_chu` text COLLATE utf8mb4_unicode_ci,
  `ma_khuyen_mai` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tien_giam_gia` decimal(14,2) DEFAULT '0.00',
  PRIMARY KEY (`ma_don_hang`),
  KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_hang`
--

LOCK TABLES `don_hang` WRITE;
/*!40000 ALTER TABLE `don_hang` DISABLE KEYS */;
INSERT INTO `don_hang` VALUES (1,1,NULL,NULL,'123 Lê Lợi, Q1, TP.HCM',120000.00,'delivered','2025-10-30 08:31:01','Giao trước 12h','GIAM50K',50000.00),(2,2,NULL,NULL,'456 Nguyễn Huệ, Q1, TP.HCM',315000.00,'preparing','2025-10-30 08:31:01','Không giao cuối tuần',NULL,0.00),(3,3,NULL,NULL,'789 Trần Hưng Đạo, Q5, TP.HCM',180000.00,'confirmed','2025-10-30 08:31:01',NULL,'THANHVIEN10',18000.00),(4,NULL,'Võ Văn F','0916666666','111 Pasteur, Q3, TP.HCM',450000.00,'delivered','2025-10-30 08:31:01','Khách vãng lai',NULL,0.00),(5,4,NULL,NULL,'321 Điện Biên Phủ, Q3, TP.HCM',560000.00,'cancelled','2025-10-30 08:31:01','Khách hủy đơn',NULL,0.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gio_hang`
--

LOCK TABLES `gio_hang` WRITE;
/*!40000 ALTER TABLE `gio_hang` DISABLE KEYS */;
INSERT INTO `gio_hang` VALUES (1,1,'2025-10-30 08:31:01','active'),(2,2,'2025-10-30 08:31:01','ordered'),(3,3,'2025-10-30 08:31:01','active'),(4,4,'2025-10-30 08:31:01','active'),(5,5,'2025-10-30 08:31:01','abandoned');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoa_don`
--

LOCK TABLES `hoa_don` WRITE;
/*!40000 ALTER TABLE `hoa_don` DISABLE KEYS */;
INSERT INTO `hoa_don` VALUES (1,1,1,1,120000.00,'2025-10-30 08:31:01','issued'),(2,2,2,2,315000.00,'2025-10-30 08:31:01','issued'),(3,3,3,3,180000.00,'2025-10-30 08:31:01','issued'),(4,4,4,NULL,450000.00,'2025-10-30 08:31:01','issued'),(5,5,5,4,560000.00,'2025-10-30 08:31:01','cancelled');
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
INSERT INTO `lien_he` VALUES (1,'Nguyễn Văn A','nguyenvana@gmail.com','0911111111','Hỏi về địa chỉ chi nhánh','Cho tôi hỏi nhà hàng có chi nhánh nào ở Quận 2 không ạ?','2025-10-30 08:31:01','replied'),(2,'Trần Thị B','tranthib@gmail.com','0922222222','Đặt tiệc sinh nhật','Tôi muốn đặt tiệc sinh nhật cho 20 người, có gói nào phù hợp không?','2025-10-30 08:31:01','read'),(3,'Lê Văn C','levanc@gmail.com','0933333333','Góp ý về dịch vụ','Hôm qua tôi có đến nhà hàng, dịch vụ rất tốt. Cảm ơn!','2025-10-30 08:31:01','read'),(4,'Phạm Thị D','phamthid@gmail.com','0944444444','Hỏi về menu chay','Nhà hàng có phục vụ menu chay không ạ?','2025-10-30 08:31:01','new'),(5,'Hoàng Văn E','hoangvane@gmail.com','0955555555','Khiếu nại đơn hàng','Đơn hàng #123 của tôi bị giao thiếu món, làm sao để xử lý?','2025-10-30 08:31:01','new');
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
INSERT INTO `mon_an` VALUES (1,'Cơm Chiên Hải Sản','Cơm chiên vàng ươm, thơm ngon với hải sản tươi sống và rau củ giòn ngọt.',55000.00,80,'dĩa','/images/comchienhaisan.jpg',1,1,'2025-10-30 08:31:01'),(2,'Cơm Chiên Cá Mặn','Cơm chiên cá mặn đậm đà, dẻo thơm, ăn kèm dưa leo và trứng chiên.',50000.00,70,'dĩa','/images/comchiencaman.jpg',1,1,'2025-10-30 08:31:01'),(3,'Cá Ri Ấn Độ','Cá nấu cà ri phong cách Ấn Độ, cay nồng và béo ngậy nước cốt dừa.',65000.00,50,'phần','/images/cariando.jpg',1,1,'2025-10-30 08:31:01'),(4,'Canh Gà Chiên','Canh gà chiên giòn dùng kèm rau thơm, vị mặn mà hấp dẫn.',45000.00,60,'tô','/images/canhgachien.jpg',1,1,'2025-10-30 08:31:01'),(5,'Cá Tai Tượng Chiên Xù','Cá tai tượng chiên vàng giòn, ăn kèm rau sống và nước mắm chua ngọt.',120000.00,25,'con','/images/cataituongchienxu.jpg',1,1,'2025-10-30 09:17:48'),(6,'Gỏi Miền Tây','Gỏi tôm thịt miền Tây với rau thơm và đậu phộng rang giòn.',40000.00,70,'dĩa','/images/goimientay.jpg',2,1,'2025-10-30 08:31:01'),(7,'Gỏi Ốc Đắng','Gỏi ốc đắng chua cay, giòn sần sật hòa cùng rau răm và hành phi.',45000.00,50,'dĩa','/images/goiocdang.jpg',2,1,'2025-10-30 08:31:01'),(8,'Gỏi Heo Xủa Hành','Gỏi thịt heo thái lát trộn hành tây, rau thơm, vị chua ngọt.',50000.00,60,'dĩa','/images/gioheoxuhan.jpg',2,1,'2025-10-30 08:31:01'),(9,'Đuồi Gà Chiên','Đuôi gà chiên nước mắm thơm giòn rụm.',55000.00,40,'dĩa','/images/duigachien.jpg',2,1,'2025-10-30 08:31:01'),(10,'Chả nguội Trung Hoa','Chả nguội kiểu Trung Hoa, hương vị mới lạ, dai giòn hấp dẫn.',45000.00,60,'phần','/images/donguoitrunghoa.jpg',2,1,'2025-10-30 08:31:01'),(11,'Lẩu Tôm','Lẩu tôm tươi ngọt nước, ăn kèm rau và bún tươi.',250000.00,30,'nồi','/images/lautom.jpg',3,1,'2025-10-30 08:31:01'),(12,'Lẩu Thác Lác Khổ Qua','Lẩu cá thác lác khổ qua thanh mát, tốt cho sức khỏe.',220000.00,25,'nồi','/images/lauthaclackhoqua.jpg',3,1,'2025-10-30 08:31:01'),(13,'Lẩu Mắm Miền Tây','Lẩu mắm đậm đà hương vị miền sông nước.',270000.00,25,'nồi','/images/laumammientay.jpg',3,1,'2025-10-30 09:19:26'),(14,'Lẩu Rau Đồng','Lẩu rau đồng dân dã với nước dùng xương hầm ngọt thanh.',180000.00,20,'nồi','/images/raudong.jpg',3,1,'2025-10-30 08:31:01'),(15,'Rau Muống Xào Tỏi','Rau muống xào tỏi độc đáo và đậm đà.',200000.00,20,'nồi','/images/raumuonxaotoi.jpg',3,1,'2025-10-30 08:31:01'),(16,'Bánh Phu Thê','Bánh phu thê dẻo thơm, tượng trưng cho tình duyên bền chặt.',15000.00,100,'cái','/images/banhphuthe.jpg',4,1,'2025-10-30 08:31:01'),(17,'Bánh Huyên Ướng Nướng','Bánh trái cây nướng truyền thống ngọt dịu và thơm bơ.',20000.00,80,'cái','/images/banhuyenuong.jpg',4,1,'2025-10-30 09:19:26'),(18,'Trái Cây Tiệc Cưới','Đĩa trái cây tươi mát, trình bày nghệ thuật.',60000.00,30,'dĩa','/images/traicaytieccuoi.jpg',4,1,'2025-10-30 08:31:01'),(19,'Hoa Quả Sơn','Tráng miệng hoa quả sơn, đa sắc màu và hương vị nhiệt đới.',50000.00,40,'dĩa','/images/hoaquason.jpg',4,1,'2025-10-30 08:31:01'),(20,'Kim Chi Tai Heo','Kim chi tai heo cay nồng, kích thích vị giác.',30000.00,50,'phần','/images/kimchitauheo.jpg',4,1,'2025-10-30 08:31:01'),(21,'Nước Rau Rừng Tây Bắc','Nước ép rau rừng thanh mát, độc đáo hương vị vùng cao.',30000.00,100,'ly','/images/raurungtaybac.jpg',5,1,'2025-10-30 08:31:01'),(22,'Tép Rong Cháy Sả','Món ăn kèm uống bia nhẹ, đậm vị miền Tây.',40000.00,60,'dĩa','/images/teprongchaysa.jpg',5,1,'2025-10-30 08:31:01'),(23,'Tôm Nướng Mật Ong','Tôm nướng mật ong vàng óng, dùng với bia lạnh.',80000.00,40,'xiên','/images/tomnuongmatong.jpg',5,1,'2025-10-30 08:31:01'),(24,'Tôm Sốt Mật Ong','Tôm chiên giòn rưới mật ong, thơm ngọt đặc biệt.',85000.00,35,'dĩa','/images/tomsotmatong.jpg',5,1,'2025-10-30 08:31:01'),(25,'Cà Nướng Mỡ Hành','Cá nướng than hoa rưới mỡ hành, thơm béo.',70000.00,50,'con','/images/canuongmohanh.jpg',5,1,'2025-10-30 08:31:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES (1,'Nguyễn Thị Mai','mai.nguyen@gmail.com','0901234567','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','123 Lê Lợi, Q1, TP.HCM','nu',NULL,'2025-10-30 08:31:01',1),(2,'Trần Văn Hùng','hung.tran@gmail.com','0902345678','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','456 Nguyễn Huệ, Q1, TP.HCM','nam',NULL,'2025-10-30 08:31:01',1),(3,'Lê Thị Hoa','hoa.le@gmail.com','0903456789','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','789 Trần Hưng Đạo, Q5, TP.HCM','nu',NULL,'2025-10-30 08:31:01',1),(4,'Phạm Minh Tuấn','tuan.pham@gmail.com','0904567890','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','321 Điện Biên Phủ, Q3, TP.HCM','nam',NULL,'2025-10-30 08:31:01',1),(5,'Võ Thị Lan','lan.vo@gmail.com','0905678901','$2a$10$EixZaYVK1fsbw1ZfbX3OXe','654 Cách Mạng Tháng 8, Q10, TP.HCM','nu',NULL,'2025-10-30 08:31:01',1),(6,'Hồ Quang Vinh','quangvinhho000@gmail.com','0355745120','$2a$10$B1CofOIMDupHM/ZGQmjcM.8QJT1cPmRlLnJDVnYeULUZJdmg4Y9Oe','Cầu Kè','nam',NULL,'2025-11-04 15:11:36',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thanh_toan`
--

LOCK TABLES `thanh_toan` WRITE;
/*!40000 ALTER TABLE `thanh_toan` DISABLE KEYS */;
INSERT INTO `thanh_toan` VALUES (1,1,120000.00,'momo','MOMO123456789','success','2025-10-10 11:30:00','Thanh toán qua MoMo'),(2,2,315000.00,'cash',NULL,'pending',NULL,'Thanh toán khi nhận hàng'),(3,3,180000.00,'vnpay','VNPAY987654321','success','2025-10-11 14:20:00','Thanh toán qua VNPay'),(4,4,450000.00,'cash',NULL,'success','2025-10-09 18:45:00','Thanh toán tiền mặt'),(5,5,560000.00,'zalopay','ZALO111222333','cancelled',NULL,'Giao dịch bị hủy');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tin_tuc`
--

LOCK TABLES `tin_tuc` WRITE;
/*!40000 ALTER TABLE `tin_tuc` DISABLE KEYS */;
INSERT INTO `tin_tuc` VALUES (1,'Khai trương chi nhánh mới tại Quận 7','Nhà hàng Phương Nam tự hào thông báo khai trương chi nhánh mới tại Quận 7, TP.HCM','<p>Nhà hàng Phương Nam tự hào thông báo khai trương chi nhánh mới tại Quận 7, TP.HCM. Với không gian rộng rãi, thoáng mát và menu đa dạng...</p>','/images/news-khai-truong.jpg',1,'2025-10-30 08:31:01',1,150),(2,'Top 10 món ăn đặc sản miền Nam phải thử','Cùng khám phá 10 món ăn đặc sản miền Nam không thể bỏ qua khi đến với Phương Nam','<p>Miền Nam Việt Nam nổi tiếng với ẩm thực phong phú, đa dạng. Cùng chúng tôi khám phá 10 món ăn đặc sản...</p>','/images/news-top10.jpg',1,'2025-10-30 08:31:01',1,320),(3,'Bí quyết làm bánh xèo giòn rụm','Chia sẻ bí quyết làm bánh xèo giòn rụm, vàng ươm đúng chuẩn miền Tây','<p>Bánh xèo là món ăn truyền thống của người miền Nam. Để có một chiếc bánh xèo giòn rụm...</p>','/images/news-banh-xeo.jpg',2,'2025-10-30 08:31:01',1,280),(4,'Khuyến mãi tháng 10 - Giảm giá đến 30%','Chương trình khuyến mãi lớn trong tháng 10 với nhiều ưu đãi hấp dẫn','<p>Nhân dịp tháng 10, nhà hàng Phương Nam triển khai chương trình khuyến mãi với nhiều ưu đãi...</p>','/images/news-khuyen-mai.jpg',1,'2025-10-30 08:31:01',1,450),(5,'Lẩu mắm - Tinh hoa ẩm thực miền Tây','Tìm hiểu về lẩu mắm - món ăn đậm đà bản sắc văn hóa miền Tây sông nước','<p>Lẩu mắm là món ăn đặc trưng của vùng đồng bằng sông Cửu Long. Với nước dùng đậm đà từ mắm...</p>','/images/news-lau-mam.jpg',2,'2025-10-30 08:31:01',1,190);
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
  `trang_thai` enum('pending','verified','expired') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`ma_xac_thuc`),
  KEY `email` (`email`),
  KEY `ma_code` (`ma_code`),
  KEY `ngay_het_han` (`ngay_het_han`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xac_thuc_email`
--

LOCK TABLES `xac_thuc_email` WRITE;
/*!40000 ALTER TABLE `xac_thuc_email` DISABLE KEYS */;
INSERT INTO `xac_thuc_email` VALUES (1,'nguyenhuynhkithuat84tv@gmail.com','920563','Nguyễn Huỳnh Kỹ Thuật','0388853044','$2a$10$aGqeqnRZsZmyRDNF624hJe4ZG5GtjpHSj.Uf.mB.3HdYWgcwF0slq','Định An Trà Cú Tà Vinh','nam',NULL,'2025-11-04 15:01:03','2025-11-04 15:11:03','pending'),(2,'quangvinhho000@gmail.com','372081','Hồ Quang Vinh','0355745120','$2a$10$B1CofOIMDupHM/ZGQmjcM.8QJT1cPmRlLnJDVnYeULUZJdmg4Y9Oe','Cầu Kè','nam',NULL,'2025-11-04 15:10:58','2025-11-04 15:20:58','verified');
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

-- Dump completed on 2025-11-04 15:17:32
