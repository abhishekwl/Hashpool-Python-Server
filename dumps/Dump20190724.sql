-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: store
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `global_product_catalog`
--

DROP TABLE IF EXISTS `global_product_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_product_catalog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `IMAGE` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `local_categories`
--

DROP TABLE IF EXISTS `local_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `local_categories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `IMAGE` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `local_product_catalog`
--

DROP TABLE IF EXISTS `local_product_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `local_product_catalog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GPC_ID` int(11) NOT NULL,
  `STORE_ID` varchar(16) NOT NULL,
  `CATEGORY_ID` int(11) NOT NULL,
  `COST` decimal(10,2) NOT NULL DEFAULT '-1.00',
  `DISCOUNT` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`ID`,`GPC_ID`,`STORE_ID`,`CATEGORY_ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_local_product_catalog_1_idx` (`GPC_ID`),
  KEY `fk_local_product_catalog_2_idx` (`STORE_ID`),
  KEY `fk_local_product_catalog_3_idx` (`CATEGORY_ID`),
  CONSTRAINT `fk_local_product_catalog_1` FOREIGN KEY (`GPC_ID`) REFERENCES `global_product_catalog` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_local_product_catalog_2` FOREIGN KEY (`STORE_ID`) REFERENCES `stores` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_local_product_catalog_3` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `local_categories` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_products_bridge`
--

DROP TABLE IF EXISTS `order_products_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_products_bridge` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDER_ID` int(11) NOT NULL,
  `LPC_ID` int(11) NOT NULL,
  `QUANTITY` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_order_entries_intermediary_1_idx` (`ORDER_ID`),
  KEY `fk_order_entries_intermediary_2_idx` (`LPC_ID`),
  CONSTRAINT `fk_order_entries_intermediary_1` FOREIGN KEY (`ORDER_ID`) REFERENCES `orders` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_entries_intermediary_2` FOREIGN KEY (`LPC_ID`) REFERENCES `local_product_catalog` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(16) NOT NULL,
  `STORE_ID` varchar(16) NOT NULL,
  `TYPE` enum('PICKUP','DELIVERY') NOT NULL,
  `TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_orders_1_idx` (`USER_ID`),
  KEY `fk_orders_2_idx` (`STORE_ID`),
  CONSTRAINT `fk_orders_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_2` FOREIGN KEY (`STORE_ID`) REFERENCES `stores` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stores` (
  `ID` varchar(16) NOT NULL,
  `NAME` varchar(128) NOT NULL,
  `EMAIL` varchar(128) NOT NULL,
  `PHONE` varchar(15) DEFAULT NULL,
  `LATITUDE` decimal(11,8) DEFAULT '-1.00000000',
  `LONGITUDE` decimal(11,8) DEFAULT '-1.00000000',
  `IMAGE` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `ID` varchar(16) NOT NULL,
  `NAME` varchar(128) NOT NULL,
  `EMAIL` varchar(128) NOT NULL,
  `PHONE` varchar(15) NOT NULL,
  `IMAGE` varchar(256) NOT NULL,
  `TIMESTAMP_BIRTHDAY` int(11) DEFAULT NULL,
  `TIMESTAMP_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TIMESTAMP_UPDATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'store'
--

--
-- Dumping routines for database 'store'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-24  9:53:21
