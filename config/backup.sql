-- MySQL dump 10.13  Distrib 9.1.0, for Linux (x86_64)
--
-- Host: localhost    Database: shopmall
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,1,3),(22,2,1,2);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `is_thumbnail` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,1,'/uploads/products/1/u7-pro.png',NULL,1),(2,1,'/uploads/products/1/u7-pro-2.png',NULL,0),(3,1,'/uploads/products/1/u7-pro-3.png',NULL,0),(4,1,'/uploads/products/1/u7-pro-4.png',NULL,0),(5,1,'/uploads/products/1/u7-pro-5.png',NULL,0),(6,1,'/uploads/products/1/u7-pro-6.png',NULL,0),(7,2,'/uploads/products/2/u7-pro-wall-1.png',NULL,1),(8,2,'/uploads/products/2/u7-pro-wall-2.png',NULL,0),(9,2,'/uploads/products/2/u7-pro-wall-3.png',NULL,0),(10,2,'/uploads/products/2/u7-pro-wall-4.png',NULL,0),(11,2,'/uploads/products/2/u7-pro-wall-5.png',NULL,0),(12,2,'/uploads/products/2/u7-pro-wall-6.png',NULL,0),(13,2,'/uploads/products/2/u7-pro-wall-7.png',NULL,0),(14,2,'/uploads/products/2/u7-pro-wall-8.png',NULL,0);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'U7 Pro',46000,'wifi','<div class=\"product-description mt-5\">\r\n    <h3 class=\"text-primary mb-4\">湲곌퀎???ъ뼇</h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">?ш린</th>\r\n                <td>횠206 x 46 mm (횠8.1 x 1.8\")</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">臾닿쾶</th>\r\n                <td>680 g (1.5 lb)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?ъ쭏</th>\r\n                <td>?대━移대낫?ㅼ씠?? 湲덉냽</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?ㅼ튂 ?ъ쭏</th>\r\n                <td>?ㅽ뀒?몃━???ㅽ떥 (SUS304), ?꾩뿰?꾧툑媛?(SGCC)</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n    <h3 class=\"text-primary mb-4\">?섎뱶?⑥뼱</h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">?ㅽ듃?뚰궧 ?명꽣?섏씠??/th>\r\n                <td>(1) 1/2.5 GbE RJ45 ?ы듃</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">愿由??명꽣?섏씠??/th>\r\n                <td>?대뜑??/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?꾩썝 諛⑹떇</th>\r\n                <td>PoE+</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?꾩썝 怨듦툒</th>\r\n                <td>UniFi PoE ?ㅼ쐞移?/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">吏???꾩븬 踰붿쐞</th>\r\n                <td>44??7V DC</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">理쒕? ?꾨젰 ?뚮퉬??/th>\r\n                <td>21W</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">理쒕? ?꾩넚 異쒕젰</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 23 dBm</li>\r\n                        <li>5 GHz: 26 dBm</li>\r\n                        <li>6 GHz: 23 dBm</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">MIMO</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 2 x 2 (DL/UL MU-MIMO)</li>\r\n                        <li>5 GHz: 2 x 2 (DL/UL MU-MIMO)</li>\r\n                        <li>6 GHz: 2 x 2 (DL/UL MU-MIMO)</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">理쒕? ?곗씠???띾룄</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 688 Mbps (BW40)</li>\r\n                        <li>5 GHz: 4.3 Gbps (BW240)</li>\r\n                        <li>6 GHz: 5.7 Gbps (BW320)</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?덊뀒???대뱷</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 4 dBi</li>\r\n                        <li>5 GHz: 6 dBi</li>\r\n                        <li>6 GHz: 5.8 dBi</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">LED</th>\r\n                <td>?곗깋/?뚮???/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">踰꾪듉</th>\r\n                <td>怨듭옣 珥덇린??/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?ㅼ튂 諛⑹떇</th>\r\n                <td>踰?泥쒖옣 (?ы븿??</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?묐룞 ?⑤룄</th>\r\n                <td>-30 ~ 60째 C (-22 ~ 140째 F)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?묐룞 ?듬룄</th>\r\n                <td>5 ~ 95% 鍮꾩쓳異?/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?몄쬆</th>\r\n                <td>CE, FCC, IC</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n    <h3 class=\"text-primary mb-4\">?뚰봽?몄썾??/h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">WiFi ?쒖?</th>\r\n                <td>802.11a/b/g/n/ac/ax/be (WiFi 6/6E, WiFi 7)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">臾댁꽑 蹂댁븞</th>\r\n                <td>WPA-PSK, WPA-Enterprise (WPA/WPA2/WPA3/PPSK)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">BSSID</th>\r\n                <td>?쇰뵒?ㅻ떦 8媛?/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">VLAN</th>\r\n                <td>802.1Q</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">怨좉툒 QoS</th>\r\n                <td>?ъ슜?먮퀎 ?띾룄 ?쒗븳</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">寃뚯뒪???몃옒??遺꾨━</th>\r\n                <td>吏?먮맖</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?숈떆 ?곌껐 ?대씪?댁뼵??/th>\r\n                <td>300+</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">吏???곗씠???띾룄</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>802.11a: 6, 9, 12, 18, 24, 36, 48, 54 Mbps</li>\r\n                        <li>802.11b: 1, 2, 5.5, 11 Mbps</li>\r\n                        <li>802.11g: 6, 9, 12, 18, 24, 36, 48, 54 Mbps</li>\r\n                        <li>802.11n: 6.5 Mbps ~ 300 Mbps (MCS0 - MCS15, HT 20/40)</li>\r\n                        <li>802.11ac: 6.5 Mbps ~ 1.7 Gbps (MCS0 - MCS9 NSS1/2, VHT 20/40/80/160)</li>\r\n                        <li>802.11ax (WiFi 6/6E): 7.3 Mbps ~ 2.4 Gbps (MCS0 - MCS11 NSS1/2, HE 20/40/80/160)</li>\r\n                        <li>802.11be (WiFi 7): 7.3 Mbps ~ 5.7 Gbps (MCS0 - MCS13 NSS1/2, EHT 20/40/80/160/240/320)</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n    <h3 class=\"text-primary mb-4\">?좏뵆由ъ??댁뀡 ?붽뎄?ы빆</h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">UniFi Network</th>\r\n                <td>踰꾩쟾 8.0.26 ?댁긽</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">UniFi OS</th>\r\n                <td>踰꾩쟾 3.2 ?댁긽</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n</div>'),(2,'U7 Pro Wall',200000,'wifi','<div class=\"product-description mt-5\">\r\n    <h3 class=\"text-primary mb-4\">湲곌퀎???ъ뼇</h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">?ш린</th>\r\n                <td>150 x 103 x 36 mm (5.9 x 4.1 x 1.4\")</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">臾닿쾶</th>\r\n                <td>580 g (1.3 lb)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?ъ쭏</th>\r\n                <td>?대━移대낫?ㅼ씠?? ?뚮（誘몃뒆</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?ㅼ튂 ?ъ쭏</th>\r\n                <td>?뚮（誘몃뒆</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n    <h3 class=\"text-primary mb-4\">?섎뱶?⑥뼱</h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">?ㅽ듃?뚰궧 ?명꽣?섏씠??/th>\r\n                <td>(1) 1/2.5 GbE RJ45 ?ы듃</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">愿由??명꽣?섏씠??/th>\r\n                <td>?대뜑??/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?꾩썝 諛⑹떇</th>\r\n                <td>PoE+</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?꾩썝 怨듦툒</th>\r\n                <td>UniFi PoE ?ㅼ쐞移?/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">吏???꾩븬 踰붿쐞</th>\r\n                <td>44??7V DC</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">理쒕? ?꾨젰 ?뚮퉬??/th>\r\n                <td>22W</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">理쒕? ?꾩넚 異쒕젰</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 22 dBm</li>\r\n                        <li>5 GHz: 26 dBm</li>\r\n                        <li>6 GHz: 23 dBm</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">MIMO</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 2 x 2 (DL/UL MU-MIMO)</li>\r\n                        <li>5 GHz: 2 x 2 (DL/UL MU-MIMO)</li>\r\n                        <li>6 GHz: 2 x 2 (DL/UL MU-MIMO)</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">理쒕? ?곗씠???띾룄</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 688 Mbps (BW40)</li>\r\n                        <li>5 GHz: 4.3 Gbps (BW240)</li>\r\n                        <li>6 GHz: 5.7 Gbps (BW320)</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?덊뀒???대뱷</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>2.4 GHz: 4 dBi</li>\r\n                        <li>5 GHz: 5 dBi</li>\r\n                        <li>6 GHz: 6 dBi</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">LED</th>\r\n                <td>?곗깋/?뚮???/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">踰꾪듉</th>\r\n                <td>怨듭옣 珥덇린??/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?ㅼ튂 諛⑹떇</th>\r\n                <td>踰??ㅼ튂 (?ы븿??<br>?뚯씠釉??ㅽ깲?? 留ㅻ┰ ?ㅼ튂 (?좏깮 ?ы빆)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?묐룞 ?⑤룄</th>\r\n                <td>-30 ~ 60째 C (-22 ~ 140째 F)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?묐룞 ?듬룄</th>\r\n                <td>5 ~ 95% 鍮꾩쓳異?/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?몄쬆</th>\r\n                <td>CE, FCC, IC</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n    <h3 class=\"text-primary mb-4\">?뚰봽?몄썾??/h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">WiFi ?쒖?</th>\r\n                <td>802.11a/b/g/n/ac/ax/be (WiFi 6/6E, WiFi 7)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">臾댁꽑 蹂댁븞</th>\r\n                <td>WPA-PSK, WPA-Enterprise (WPA/WPA2/WPA3/PPSK)</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">BSSID</th>\r\n                <td>?쇰뵒?ㅻ떦 8媛?/td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">VLAN</th>\r\n                <td>802.1Q</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">怨좉툒 QoS</th>\r\n                <td>?ъ슜?먮퀎 ?띾룄 ?쒗븳</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">寃뚯뒪???몃옒??遺꾨━</th>\r\n                <td>吏?먮맖</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">?숈떆 ?곌껐 ?대씪?댁뼵??/th>\r\n                <td>300+</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">吏???곗씠???띾룄</th>\r\n                <td>\r\n                    <ul class=\"list-unstyled mb-0\">\r\n                        <li>802.11a: 6, 9, 12, 18, 24, 36, 48, 54 Mbps</li>\r\n                        <li>802.11b: 1, 2, 5.5, 11 Mbps</li>\r\n                        <li>802.11g: 6, 9, 12, 18, 24, 36, 48, 54 Mbps</li>\r\n                        <li>802.11n: 6.5 Mbps ~ 300 Mbps (MCS0 - MCS15, HT 20/40)</li>\r\n                        <li>802.11ac: 6.5 Mbps ~ 1.7 Gbps (MCS0 - MCS9 NSS1/2, VHT 20/40/80/160)</li>\r\n                        <li>802.11ax (WiFi 6/6E): 7.3 Mbps ~ 2.4 Gbps (MCS0 - MCS11 NSS1/2, HE 20/40/80/160)</li>\r\n                        <li>802.11be (WiFi 7): 7.3 Mbps ~ 5.7 Gbps (MCS0 - MCS13 NSS1/2, EHT 20/40/80/160/240/320)</li>\r\n                    </ul>\r\n                </td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n    <h3 class=\"text-primary mb-4\">?좏뵆由ъ??댁뀡 ?붽뎄?ы빆</h3>\r\n    <table class=\"table table-bordered table-striped\">\r\n        <tbody>\r\n            <tr>\r\n                <th scope=\"row\">UniFi Network</th>\r\n                <td>踰꾩쟾 8.1 ?댁긽</td>\r\n            </tr>\r\n            <tr>\r\n                <th scope=\"row\">UniFi OS</th>\r\n                <td>踰꾩쟾 3.2 ?댁긽</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n</div>');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `id` varchar(30) NOT NULL,
  `pw` varchar(255) NOT NULL,
  `name` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'cg1119','1d61e32d11b65acaa19640760e2590a62ecfeaf74f9120421b120a05129f4074','?대룞誘?,'nexen13@naver.com','01080114776',1),(2,'nexen13','1d61e32d11b65acaa19640760e2590a62ecfeaf74f9120421b120a05129f4074','?대룞誘?,'nexen13@gmail.com','01080114777',0);
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

-- Dump completed on 2024-11-28 19:06:43
