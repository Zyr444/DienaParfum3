-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: diena_parfum
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'Admin Diena Parfum','admin@dienaparfum.com','2026-06-28 06:00:49','$2y$12$KeWWSSwO3IveO87OusHY4Ojfny3BS0j0s5aMYagsFJGIoK0QDBRKK',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6','i:1;',1782652339),('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer','i:1782652339;',1782652339);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_parent` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` bigint unsigned DEFAULT NULL,
  `added_by` bigint unsigned DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Men\'s Fragrance','mens-fragrance',NULL,NULL,1,NULL,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(2,'Women\'s Fragrance','womens-fragrance',NULL,NULL,1,NULL,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(3,'Unisex Fragrance','unisex-fragrance',NULL,NULL,1,NULL,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(4,'Cologne','mens-cologne',NULL,NULL,0,1,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(5,'Eau de Toilette','mens-eau-de-toilette',NULL,NULL,0,1,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(6,'Eau de Parfum','mens-eau-de-parfum',NULL,NULL,0,1,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(7,'Eau de Toilette','womens-eau-de-toilette',NULL,NULL,0,2,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(8,'Eau de Parfum','womens-eau-de-parfum',NULL,NULL,0,2,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50'),(9,'Perfume','womens-perfume',NULL,NULL,0,2,NULL,'active','2026-06-28 06:00:50','2026-06-28 06:00:50');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_06_14_000002_create_categories_table',1),(5,'2026_06_14_000005_create_products_table',1),(6,'2026_06_14_000010_create_orders_table',1),(7,'2026_06_26_174549_create_order_items_table',1),(8,'2026_06_27_000000_create_admins_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `coupon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `payment_method` enum('cod','paypal','card','bank_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cod',
  `payment_status` enum('unpaid','paid','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `status` enum('new','process','shipped','delivered','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `category_id` bigint unsigned DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `added_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  UNIQUE KEY `products_sku_unique` (`sku`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Diena Parfume | Orchid & Midnight Jasmine','Orchid & Midnight Jasmine','orchid-midnight-jasmine','A masterfully crafted signature scent by Diena Parfume, blending top notes of Vetiver with base notes of Neroli for a truly unique and unforgettable experience.','Premium Orchid & Midnight Jasmine by Diena Parfume',3300000.00,4587000.00,'/images/elysian_scent.png','/images/elysian_scent.png',13,2,'DIENA-MQQJPI','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(2,'Diena Parfume | Ancient Agarwood','Ancient Agarwood','ancient-agarwood','A masterfully crafted signature scent by Diena Parfume, blending top notes of Tonka Bean with base notes of Vetiver for a truly unique and unforgettable experience.','Premium Ancient Agarwood by Diena Parfume',3000000.00,3780000.00,'/images/oud_imperial.png','/images/oud_imperial.png',14,1,'DIENA-WUVBCE','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(3,'Diena Parfume | Amber & Black Pepper','Amber & Black Pepper','amber-black-pepper','A masterfully crafted signature scent by Diena Parfume, blending top notes of Jasmine with base notes of Bergamot for a truly unique and unforgettable experience.','Premium Amber & Black Pepper by Diena Parfume',5000000.00,5850000.00,'/images/midnight_rose.png','/images/midnight_rose.png',22,3,'DIENA-VU3UQX','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(4,'Diena Parfume | Sandalwood & Cacao','Sandalwood & Cacao','sandalwood-cacao','A masterfully crafted signature scent by Diena Parfume, blending top notes of Leather with base notes of Oud for a truly unique and unforgettable experience.','Premium Sandalwood & Cacao by Diena Parfume',2800000.00,3752000.00,'/images/santal_majuscule.png','/images/santal_majuscule.png',7,2,'DIENA-6GU2H0','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(5,'Diena Parfume | Silver Reflections','Silver Reflections','silver-reflections','A masterfully crafted signature scent by Diena Parfume, blending top notes of Cardamom with base notes of Patchouli for a truly unique and unforgettable experience.','Premium Silver Reflections by Diena Parfume',2000000.00,2860000.00,'/images/noir_crystal.png','/images/noir_crystal.png',16,1,'DIENA-7XCWBX','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(6,'Diena Parfume | Carrara Legacy','Carrara Legacy','carrara-legacy','A masterfully crafted signature scent by Diena Parfume, blending top notes of Leather with base notes of Vanilla for a truly unique and unforgettable experience.','Premium Carrara Legacy by Diena Parfume',2600000.00,3302000.00,'/images/royal_gold.png','/images/royal_gold.png',11,3,'DIENA-EBUFZK','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(7,'Diena Parfume | Crimson Silk','Crimson Silk','crimson-silk','A masterfully crafted signature scent by Diena Parfume, blending top notes of Ylang-Ylang with base notes of Ylang-Ylang for a truly unique and unforgettable experience.','Premium Crimson Silk by Diena Parfume',2500000.00,3150000.00,'/images/rose_velvet.png','/images/rose_velvet.png',22,2,'DIENA-X53EO6','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(8,'Diena Parfume | Morning Stone','Morning Stone','morning-stone','A masterfully crafted signature scent by Diena Parfume, blending top notes of Patchouli with base notes of Cardamom for a truly unique and unforgettable experience.','Premium Morning Stone by Diena Parfume',3800000.00,4522000.00,'/images/ocean_breeze.png','/images/ocean_breeze.png',18,1,'DIENA-V0BQEE','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(9,'Diena Parfume | Misty Emerald','Misty Emerald','misty-emerald','A masterfully crafted signature scent by Diena Parfume, blending top notes of Patchouli with base notes of Jasmine for a truly unique and unforgettable experience.','Premium Misty Emerald by Diena Parfume',3700000.00,5106000.00,'/images/forest_essence.png','/images/forest_essence.png',15,3,'DIENA-XEQ9TT','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(10,'Diena Parfume | Teardrop Horizon','Teardrop Horizon','teardrop-horizon','A masterfully crafted signature scent by Diena Parfume, blending top notes of Neroli with base notes of Vanilla for a truly unique and unforgettable experience.','Premium Teardrop Horizon by Diena Parfume',4600000.00,6854000.00,'/images/amber_sun.png','/images/amber_sun.png',16,2,'DIENA-YGGZLA','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(11,'Diena Parfume | Violet Lavender','Violet Lavender','violet-lavender','A masterfully crafted signature scent by Diena Parfume, blending top notes of Ylang-Ylang with base notes of Neroli for a truly unique and unforgettable experience.','Premium Violet Lavender by Diena Parfume',4300000.00,4773000.00,'/images/midnight_lavender.png','/images/midnight_lavender.png',19,1,'DIENA-FLX1DO','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(12,'Diena Parfume | Imperial Elixir','Imperial Elixir','imperial-elixir','A masterfully crafted signature scent by Diena Parfume, blending top notes of Tonka Bean with base notes of Neroli for a truly unique and unforgettable experience.','Premium Imperial Elixir by Diena Parfume',5400000.00,6696000.00,'/images/elysian_scent.png','/images/elysian_scent.png',9,3,'DIENA-GYRSQP','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(13,'Diena Parfume | Celestial Aura','Celestial Aura','celestial-aura','A masterfully crafted signature scent by Diena Parfume, blending top notes of Musk with base notes of Musk for a truly unique and unforgettable experience.','Premium Celestial Aura by Diena Parfume',4600000.00,6302000.00,'/images/oud_imperial.png','/images/oud_imperial.png',22,2,'DIENA-GTV5GH','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(14,'Diena Parfume | Velvet Soul','Velvet Soul','velvet-soul','A masterfully crafted signature scent by Diena Parfume, blending top notes of Rose with base notes of Ylang-Ylang for a truly unique and unforgettable experience.','Premium Velvet Soul by Diena Parfume',4100000.00,6150000.00,'/images/midnight_rose.png','/images/midnight_rose.png',12,1,'DIENA-1KC1JK','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(15,'Diena Parfume | Divine Dreams','Divine Dreams','divine-dreams','A masterfully crafted signature scent by Diena Parfume, blending top notes of Vetiver with base notes of Patchouli for a truly unique and unforgettable experience.','Premium Divine Dreams by Diena Parfume',4700000.00,6909000.00,'/images/santal_majuscule.png','/images/santal_majuscule.png',23,3,'DIENA-PXCO7Y','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(16,'Diena Parfume | Radiant Spirit','Radiant Spirit','radiant-spirit','A masterfully crafted signature scent by Diena Parfume, blending top notes of Cardamom with base notes of Cardamom for a truly unique and unforgettable experience.','Premium Radiant Spirit by Diena Parfume',2400000.00,3576000.00,'/images/noir_crystal.png','/images/noir_crystal.png',9,2,'DIENA-IRPN2D','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(17,'Diena Parfume | Sacred Grace','Sacred Grace','sacred-grace','A masterfully crafted signature scent by Diena Parfume, blending top notes of Tonka Bean with base notes of Neroli for a truly unique and unforgettable experience.','Premium Sacred Grace by Diena Parfume',5900000.00,8496000.00,'/images/royal_gold.png','/images/royal_gold.png',25,1,'DIENA-LMOQXU','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(18,'Diena Parfume | Infinite Light','Infinite Light','infinite-light','A masterfully crafted signature scent by Diena Parfume, blending top notes of Ylang-Ylang with base notes of Patchouli for a truly unique and unforgettable experience.','Premium Infinite Light by Diena Parfume',3300000.00,4290000.00,'/images/rose_velvet.png','/images/rose_velvet.png',18,3,'DIENA-EQB8TP','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(19,'Diena Parfume | Royal Scent','Royal Scent','royal-scent','A masterfully crafted signature scent by Diena Parfume, blending top notes of Tonka Bean with base notes of Oud for a truly unique and unforgettable experience.','Premium Royal Scent by Diena Parfume',4200000.00,4830000.00,'/images/ocean_breeze.png','/images/ocean_breeze.png',12,2,'DIENA-PSY1EW','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(20,'Diena Parfume | Pure Mist','Pure Mist','pure-mist','A masterfully crafted signature scent by Diena Parfume, blending top notes of Sandalwood with base notes of Rose for a truly unique and unforgettable experience.','Premium Pure Mist by Diena Parfume',2500000.00,2900000.00,'/images/forest_essence.png','/images/forest_essence.png',18,1,'DIENA-IAZBJ0','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(21,'Diena Parfume | Midnight Glow','Midnight Glow','midnight-glow','A masterfully crafted signature scent by Diena Parfume, blending top notes of Tonka Bean with base notes of Bergamot for a truly unique and unforgettable experience.','Premium Midnight Glow by Diena Parfume',1900000.00,2508000.00,'/images/amber_sun.png','/images/amber_sun.png',5,3,'DIENA-VJGSKG','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(22,'Diena Parfume | Golden Heart','Golden Heart','golden-heart','A masterfully crafted signature scent by Diena Parfume, blending top notes of Leather with base notes of Ylang-Ylang for a truly unique and unforgettable experience.','Premium Golden Heart by Diena Parfume',6000000.00,8340000.00,'/images/midnight_lavender.png','/images/midnight_lavender.png',5,2,'DIENA-BZ3VCU','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(23,'Diena Parfume | Mystic Essence','Mystic Essence','mystic-essence','A masterfully crafted signature scent by Diena Parfume, blending top notes of Patchouli with base notes of Leather for a truly unique and unforgettable experience.','Premium Mystic Essence by Diena Parfume',2700000.00,2970000.00,'/images/elysian_scent.png','/images/elysian_scent.png',20,1,'DIENA-76OIS5','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(24,'Diena Parfume | Bergamot Noir','Bergamot Noir','bergamot-noir','A masterfully crafted signature scent by Diena Parfume, blending top notes of Tonka Bean with base notes of Jasmine for a truly unique and unforgettable experience.','Premium Bergamot Noir by Diena Parfume',4100000.00,5494000.00,'/images/oud_imperial.png','/images/oud_imperial.png',5,3,'DIENA-PM9CWB','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(25,'Diena Parfume | Neroli Bloom','Neroli Bloom','neroli-bloom','A masterfully crafted signature scent by Diena Parfume, blending top notes of Musk with base notes of Oud for a truly unique and unforgettable experience.','Premium Neroli Bloom by Diena Parfume',2600000.00,3562000.00,'/images/midnight_rose.png','/images/midnight_rose.png',6,2,'DIENA-ODSBRD','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(26,'Diena Parfume | Vetiver Smoke','Vetiver Smoke','vetiver-smoke','A masterfully crafted signature scent by Diena Parfume, blending top notes of Jasmine with base notes of Patchouli for a truly unique and unforgettable experience.','Premium Vetiver Smoke by Diena Parfume',6000000.00,8880000.00,'/images/santal_majuscule.png','/images/santal_majuscule.png',23,1,'DIENA-B0W7JG','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(27,'Diena Parfume | Cardamom Spice','Cardamom Spice','cardamom-spice','A masterfully crafted signature scent by Diena Parfume, blending top notes of Ylang-Ylang with base notes of Rose for a truly unique and unforgettable experience.','Premium Cardamom Spice by Diena Parfume',1900000.00,2793000.00,'/images/noir_crystal.png','/images/noir_crystal.png',12,3,'DIENA-TTYO2W','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(28,'Diena Parfume | Tonka Vanilla','Tonka Vanilla','tonka-vanilla','A masterfully crafted signature scent by Diena Parfume, blending top notes of Bergamot with base notes of Rose for a truly unique and unforgettable experience.','Premium Tonka Vanilla by Diena Parfume',2900000.00,3596000.00,'/images/royal_gold.png','/images/royal_gold.png',20,2,'DIENA-FAVIJG','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(29,'Diena Parfume | Leather Oud','Leather Oud','leather-oud','A masterfully crafted signature scent by Diena Parfume, blending top notes of Rose with base notes of Leather for a truly unique and unforgettable experience.','Premium Leather Oud by Diena Parfume',3700000.00,4736000.00,'/images/rose_velvet.png','/images/rose_velvet.png',12,1,'DIENA-TM1AGY','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50'),(30,'Diena Parfume | Rose Absolute','Rose Absolute','rose-absolute','A masterfully crafted signature scent by Diena Parfume, blending top notes of Bergamot with base notes of Sandalwood for a truly unique and unforgettable experience.','Premium Rose Absolute by Diena Parfume',2800000.00,3640000.00,'/images/ocean_breeze.png','/images/ocean_breeze.png',19,3,'DIENA-F3W859','active',NULL,'2026-06-28 06:00:50','2026-06-28 06:00:50');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('a0e2IfHKPPfM2LMXuL2rrVzTMClSk5m9NjY1fMp0',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','eyJfdG9rZW4iOiJjTDBoVkdld25ZWUdRMlR3WGFtQ1p2d3BaUlVISjVGSkRMZ1FTVFNKIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9hZG1pbiIsInJvdXRlIjoiZmlsYW1lbnQuYWRtaW4ucGFnZXMuZGFzaGJvYXJkIn0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfSwidXJsIjpbXSwibG9naW5fYWRtaW5fNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6MSwicGFzc3dvcmRfaGFzaF9hZG1pbiI6IjJmNDQzYjUxMmUyMmI5MjU3NTk3MGZiMDkxN2JhZTczOWFmZGJmZjI4Njc2MGE5N2Y1ZGEwOTBmMzU4ZWEyNjUiLCJ0YWJsZXMiOnsiMmFmYWQ0NGNmM2M5NWJmNDBmZTVjZjI0NjE0M2ZiZGZfY29sdW1ucyI6W3sidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJvcmRlcl9udW1iZXIiLCJsYWJlbCI6Ik5vLiBQZXNhbmFuIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImZpcnN0X25hbWUiLCJsYWJlbCI6IlBlbmVyaW1hIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InBob25lIiwibGFiZWwiOiJXaGF0c0FwcCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJ0b3RhbF9hbW91bnQiLCJsYWJlbCI6IlRvdGFsIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InBheW1lbnRfc3RhdHVzIiwibGFiZWwiOiJQZW1iYXlhcmFuIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InN0YXR1cyIsImxhYmVsIjoiU3RhdHVzIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6Ildha3R1IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH1dLCI4ZmFjNmViMWNlYzI2ODAzYjNmN2ZiNDQwYTI3MTExYl9jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImltYWdlIiwibGFiZWwiOiJGb3RvIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Im5hbWUiLCJsYWJlbCI6Ik5hbWEgQXJvbWEiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoicHJpY2UiLCJsYWJlbCI6IkhhcmdhIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InN0b2NrIiwibGFiZWwiOiJTdG9rIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNhdGVnb3J5LnRpdGxlIiwibGFiZWwiOiJLYXRlZ29yaSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJUZXJkYWZ0YXIgUGFkYSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjpmYWxzZSwiaXNUb2dnbGVhYmxlIjp0cnVlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOnRydWV9XSwiZGRjMWQwOGViZWZhNjUyMjkwM2FiMWYzN2MzY2I4YWNfY29sdW1ucyI6W3sidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJ0aXRsZSIsImxhYmVsIjoiTmFtYSBLYXRlZ29yaSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJzbHVnIiwibGFiZWwiOiJTbHVnIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InBob3RvIiwibGFiZWwiOiJGb3RvIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImlzX3BhcmVudCIsImxhYmVsIjoiS2F0ZWdvcmkgVXRhbWEiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoicGFyZW50LnRpdGxlIiwibGFiZWwiOiJLYXRlZ29yaSBJbmR1ayIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJzdGF0dXMiLCJsYWJlbCI6IlN0YXR1cyIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJDcmVhdGVkIGF0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOmZhbHNlLCJpc1RvZ2dsZWFibGUiOnRydWUsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6dHJ1ZX0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InVwZGF0ZWRfYXQiLCJsYWJlbCI6IlVwZGF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6ZmFsc2UsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0Ijp0cnVlfV0sImU3OTNhMjc5ZDU2ZTQ1MDYwOTc1NDAyMGQ2MjdiZWVjX2NvbHVtbnMiOlt7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoib3JkZXJfbnVtYmVyIiwibGFiZWwiOiJOby4gUGVzYW5hbiIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJ1c2VyLm5hbWUiLCJsYWJlbCI6Ik5hbWEgQWt1biIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJmaXJzdF9uYW1lIiwibGFiZWwiOiJOYW1hIFBlbmVyaW1hIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InBob25lIiwibGFiZWwiOiJOby4gV2hhdHNBcHAiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidG90YWxfYW1vdW50IiwibGFiZWwiOiJUb3RhbCBCYXlhciIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJwYXltZW50X3N0YXR1cyIsImxhYmVsIjoiUGVtYmF5YXJhbiIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJzdGF0dXMiLCJsYWJlbCI6IlN0YXR1cyBQZXNhbmFuIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6Ildha3R1IFBlc2FuYW4iLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfV0sImU2NDQ4MzNmNGU0ZTA4NzEyMzE1ZGE3MWIzM2ZhY2QyX2NvbHVtbnMiOlt7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoibmFtZSIsImxhYmVsIjoiTmFtYSBMZW5na2FwIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImVtYWlsIiwibGFiZWwiOiJFbWFpbCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJwaG9uZSIsImxhYmVsIjoiTm9tb3IgVGVsZXBvbiIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJwb3N0X2NvZGUiLCJsYWJlbCI6IktvZGUgUG9zIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOmZhbHNlLCJpc1RvZ2dsZWFibGUiOnRydWUsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6dHJ1ZX0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6IlRlcmRhZnRhciBQYWRhIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH1dfX0=',1782653177);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `post_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test User','test@example.com',NULL,NULL,NULL,'2026-06-28 06:00:48','$2y$12$78b6V6wr/LEAQ0AKGvVCOeBXtfkGlLnv35Jo71EUI86ND4wXaEeOm','UCSxnJNh2s','2026-06-28 06:00:49','2026-06-28 06:00:49');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-28 20:26:20
