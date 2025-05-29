CREATE DATABASE  IF NOT EXISTS `accountingvouchersystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `accountingvouchersystem`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: accountingvouchersystem
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `Code` varchar(20) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `IsActive` tinyint(1) DEFAULT '1',
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('1001','Cash - Main Account',1,'2025-05-29 00:10:52'),('1002','Cash - Petty',1,'2025-05-29 00:10:52'),('1101','Accounts Receivable',1,'2025-05-29 00:10:52'),('1201','Inventory',1,'2025-05-29 00:10:52'),('2001','Accounts Payable',1,'2025-05-29 00:10:52'),('2101','Sales Tax Payable',1,'2025-05-29 00:10:52'),('3001','Owner\'s Capital',1,'2025-05-29 00:10:52'),('3002','Retained Earnings',1,'2025-05-29 00:10:52'),('4001','Product Sales',1,'2025-05-29 00:10:52'),('4002','Service Revenue',1,'2025-05-29 00:10:52'),('5001','Office Supplies',1,'2025-05-29 00:10:52'),('5002','Rent Expense',1,'2025-05-29 00:10:52'),('5003','Utilities',1,'2025-05-29 00:10:52'),('5004','Salaries',1,'2025-05-29 00:10:52'),('5005','Advertising',1,'2025-05-29 00:10:52');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactiontypes`
--

DROP TABLE IF EXISTS `transactiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactiontypes` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactiontypes`
--

LOCK TABLES `transactiontypes` WRITE;
/*!40000 ALTER TABLE `transactiontypes` DISABLE KEYS */;
INSERT INTO `transactiontypes` VALUES (1,'Debit','Increases asset/expense accounts','2025-05-29 00:10:52'),(2,'Credit','Increases liability/income accounts','2025-05-29 00:10:52');
/*!40000 ALTER TABLE `transactiontypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucherdetails`
--

DROP TABLE IF EXISTS `voucherdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucherdetails` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `VoucherId` int NOT NULL,
  `AccountCode` varchar(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Amount` decimal(18,2) NOT NULL,
  `TransactionTypeId` int NOT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `VoucherId` (`VoucherId`),
  KEY `AccountCode` (`AccountCode`),
  KEY `TransactionTypeId` (`TransactionTypeId`),
  CONSTRAINT `voucherdetails_ibfk_1` FOREIGN KEY (`VoucherId`) REFERENCES `vouchers` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `voucherdetails_ibfk_2` FOREIGN KEY (`AccountCode`) REFERENCES `accounts` (`Code`),
  CONSTRAINT `voucherdetails_ibfk_3` FOREIGN KEY (`TransactionTypeId`) REFERENCES `transactiontypes` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucherdetails`
--

LOCK TABLES `voucherdetails` WRITE;
/*!40000 ALTER TABLE `voucherdetails` DISABLE KEYS */;
INSERT INTO `voucherdetails` VALUES (3,2,'1001','Payment received',2750.50,2,'2025-05-29 00:10:52'),(4,2,'1101','Invoice 1002 settlement',2750.50,1,'2025-05-29 00:10:52'),(5,4,'1001','Rent payment',1200.00,1,'2025-05-29 00:10:52'),(6,4,'5002','January office rent',1200.00,2,'2025-05-29 00:10:52'),(7,5,'1001','Office supplies purchase',345.75,1,'2025-05-29 00:10:52'),(8,5,'5001','Office supplies',345.75,2,'2025-05-29 00:10:52'),(9,7,'1201','Inventory adjustment',125.00,1,'2025-05-29 00:10:52'),(10,7,'5001','Inventory adjustment',125.00,2,'2025-05-29 00:10:52'),(11,3,'1001','Advance received',5000.00,2,'2025-05-29 00:10:52'),(12,3,'2101','Customer advance',5000.00,1,'2025-05-29 00:10:52'),(13,6,'1001','Utility payment',420.30,1,'2025-05-29 00:10:52'),(14,6,'5003','Electricity bill',420.30,2,'2025-05-29 00:10:52'),(15,8,'5004','Depreciation expense',350.00,2,'2025-05-29 00:10:52'),(16,8,'1201','Equipment depreciation',350.00,1,'2025-05-29 00:10:52'),(17,9,'1001','Payment received',3200.00,2,'2025-05-29 00:10:52'),(18,9,'1101','Invoice 1003 settlement',3200.00,1,'2025-05-29 00:10:52'),(19,10,'1001','Salary payment',4500.00,1,'2025-05-29 00:10:52'),(20,10,'5004','Employee salaries',4500.00,2,'2025-05-29 00:10:52'),(21,11,'1001','Service payment',1800.00,2,'2025-05-29 00:10:52'),(22,11,'4002','Consulting service',1800.00,1,'2025-05-29 00:10:52'),(23,12,'1001','Marketing payment',750.00,1,'2025-05-29 00:10:52'),(24,12,'5005','Facebook ads',750.00,2,'2025-05-29 00:10:52'),(25,13,'1001','Bank charges',15.00,1,'2025-05-29 00:10:52'),(26,13,'5003','Bank fees',15.00,2,'2025-05-29 00:10:52'),(27,14,'1001','Payment received',4200.00,2,'2025-05-29 00:10:52'),(28,14,'1101','Invoice 1004 settlement',4200.00,1,'2025-05-29 00:10:52'),(29,15,'1001','Equipment purchase',2500.00,1,'2025-05-29 00:10:52'),(30,15,'1201','Office computer',2500.00,2,'2025-05-29 00:10:52'),(31,16,'1001','Transfer out',200.00,1,'2025-05-29 00:10:52'),(32,16,'1002','Petty cash replenishment',200.00,2,'2025-05-29 00:10:52'),(33,17,'1001','Payment received',3800.00,2,'2025-05-29 00:10:52'),(34,17,'1101','Invoice 1005 settlement',3800.00,1,'2025-05-29 00:10:52'),(35,18,'1001','Internet payment',85.00,1,'2025-05-29 00:10:52'),(36,18,'5003','Internet service',85.00,2,'2025-05-29 00:10:52'),(37,19,'5003','Accrued utilities',120.00,2,'2025-05-29 00:10:52'),(38,19,'2101','Utilities payable',120.00,1,'2025-05-29 00:10:52'),(39,20,'1001','Payment received',2900.00,2,'2025-05-29 00:10:52'),(40,20,'1101','Invoice 1006 settlement',2900.00,1,'2025-05-29 00:10:52'),(41,28,'1001','string',0.01,2,'2025-05-29 02:27:35');
/*!40000 ALTER TABLE `voucherdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchers` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `VoucherNumber` varchar(20) NOT NULL,
  `VoucherDate` datetime NOT NULL,
  `VoucherTypeId` int NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `TotalAmount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `VoucherNumber` (`VoucherNumber`),
  KEY `VoucherTypeId` (`VoucherTypeId`),
  CONSTRAINT `vouchers_ibfk_1` FOREIGN KEY (`VoucherTypeId`) REFERENCES `vouchertypes` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchers`
--

LOCK TABLES `vouchers` WRITE;
/*!40000 ALTER TABLE `vouchers` DISABLE KEYS */;
INSERT INTO `vouchers` VALUES (2,'REC-2023-002','2023-01-10 00:00:00',1,'Customer payment - Invoice 1002',5501.00,'2025-05-29 00:10:52'),(3,'REC-2023-003','2023-01-15 00:00:00',1,'Advance from customer',10000.00,'2025-05-29 00:10:52'),(4,'PAY-2023-001','2023-01-06 00:00:00',2,'Office rent January',2400.00,'2025-05-29 00:10:52'),(5,'PAY-2023-002','2023-01-12 00:00:00',2,'Office supplies',691.50,'2025-05-29 00:10:52'),(6,'PAY-2023-003','2023-01-18 00:00:00',2,'Utility bill payment',840.60,'2025-05-29 00:10:52'),(7,'JRN-2023-001','2023-01-20 00:00:00',3,'Inventory adjustment',0.00,'2025-05-29 00:10:52'),(8,'JRN-2023-002','2023-01-25 00:00:00',3,'Depreciation entry',0.00,'2025-05-29 00:10:52'),(9,'REC-2023-004','2023-01-28 00:00:00',1,'Customer payment - Invoice 1003',6400.00,'2025-05-29 00:10:52'),(10,'PAY-2023-004','2023-01-30 00:00:00',2,'Employee salaries',9000.00,'2025-05-29 00:10:52'),(11,'REC-2023-005','2023-02-01 00:00:00',1,'Service revenue',3600.00,'2025-05-29 00:10:52'),(12,'PAY-2023-005','2023-02-05 00:00:00',2,'Marketing expenses',1500.00,'2025-05-29 00:10:52'),(13,'JRN-2023-003','2023-02-10 00:00:00',3,'Bank charges adjustment',0.00,'2025-05-29 00:10:52'),(14,'REC-2023-006','2023-02-15 00:00:00',1,'Customer payment - Invoice 1004',8400.00,'2025-05-29 00:10:52'),(15,'PAY-2023-006','2023-02-20 00:00:00',2,'Office equipment',5000.00,'2025-05-29 00:10:52'),(16,'TRN-2023-001','2023-02-25 00:00:00',4,'Transfer to petty cash',400.00,'2025-05-29 00:10:52'),(17,'REC-2023-007','2023-03-01 00:00:00',1,'Customer payment - Invoice 1005',7600.00,'2025-05-29 00:10:52'),(18,'PAY-2023-007','2023-03-05 00:00:00',2,'Internet bill',170.00,'2025-05-29 00:10:52'),(19,'JRN-2023-004','2023-03-10 00:00:00',3,'Accrued expenses',0.00,'2025-05-29 00:10:52'),(20,'REC-2023-008','2023-03-15 00:00:00',1,'Customer payment - Invoice 1006',5800.00,'2025-05-29 00:10:52'),(21,'REC-2023-567','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 01:45:40'),(22,'REC-2023-657','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 01:50:19'),(23,'REC-2023-566','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 01:54:39'),(24,'REC-2023-568','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 01:58:59'),(25,'REC-2023-589','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 02:23:39'),(26,'REC-2023-569','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 02:26:45'),(27,'REC-2023-599','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 02:27:06'),(28,'REC-2023-598','2025-05-28 18:16:48',1,'string',0.00,'2025-05-29 02:27:35');
/*!40000 ALTER TABLE `vouchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchertypes`
--

DROP TABLE IF EXISTS `vouchertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchertypes` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchertypes`
--

LOCK TABLES `vouchertypes` WRITE;
/*!40000 ALTER TABLE `vouchertypes` DISABLE KEYS */;
INSERT INTO `vouchertypes` VALUES (1,'Receipt','Money received from customers','2025-05-29 00:10:52'),(2,'Payment','Money paid to vendors','2025-05-29 00:10:52'),(3,'Journal','Accounting adjustment entry','2025-05-29 00:10:52'),(4,'Transfer','Funds transfer between accounts','2025-05-29 00:10:52');
/*!40000 ALTER TABLE `vouchertypes` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Dumping routines for database 'accountingvouchersystem'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_Account_Validate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Account_Validate`(IN p_AccountCode VARCHAR(20), OUT p_IsValid BOOLEAN)
BEGIN
    SELECT IsActive INTO p_IsValid FROM Accounts WHERE Code = p_AccountCode;
    SET p_IsValid = IFNULL(p_IsValid, FALSE);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetTransactionTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetTransactionTypes`()
BEGIN
    SELECT Id, Name, Description FROM TransactionTypes ORDER BY Name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetVoucherTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetVoucherTypes`()
BEGIN
    SELECT Id, Name, Description FROM VoucherTypes ORDER BY Name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VoucherDetail_Create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_VoucherDetail_Create`(
    IN p_VoucherId INT,
    IN p_AccountCode VARCHAR(20),
    IN p_Description VARCHAR(255),
    IN p_Amount DECIMAL(18,2),
    IN p_TransactionTypeId INT
)
BEGIN
    DECLARE v_voucher_exists BOOLEAN;
    DECLARE v_account_active BOOLEAN;
    DECLARE v_transaction_type_exists BOOLEAN;
    
    -- Validate voucher exists
    SELECT COUNT(*) > 0 INTO v_voucher_exists FROM Vouchers WHERE Id = p_VoucherId;
    IF NOT v_voucher_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher not found';
    END IF;
    
    -- Validate account exists and is active
    SELECT IsActive INTO v_account_active FROM Accounts WHERE Code = p_AccountCode;
    IF v_account_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account not found';
    ELSEIF NOT v_account_active THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account is inactive';
    END IF;
    
    -- Validate transaction type exists
    SELECT COUNT(*) > 0 INTO v_transaction_type_exists FROM TransactionTypes WHERE Id = p_TransactionTypeId;
    IF NOT v_transaction_type_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction type not found';
    END IF;
    
    -- Validate amount is positive
    IF p_Amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Amount must be positive';
    END IF;
    
    -- Insert voucher detail
    INSERT INTO VoucherDetails (VoucherId, AccountCode, Description, Amount, TransactionTypeId)
    VALUES (p_VoucherId, p_AccountCode, p_Description, p_Amount, p_TransactionTypeId);
    
    -- Update voucher total amount (handled by trigger)
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VoucherDetail_Delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_VoucherDetail_Delete`(IN p_VoucherDetailId INT)
BEGIN
    DECLARE v_detail_exists BOOLEAN;
    
    -- Validate detail exists
    SELECT COUNT(*) > 0 INTO v_detail_exists FROM VoucherDetails WHERE Id = p_VoucherDetailId;
    IF NOT v_detail_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher detail not found';
    END IF;
    
    DELETE FROM VoucherDetails WHERE Id = p_VoucherDetailId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VoucherDetail_GetByVoucherId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_VoucherDetail_GetByVoucherId`(IN p_VoucherId INT)
BEGIN
    SELECT 
        vd.Id,
        vd.VoucherId,
        v.VoucherNumber,
        vd.AccountCode,
        a.Name AS AccountName,
        vd.Description,
        vd.Amount,
        vd.TransactionTypeId,
        tt.Name AS TransactionTypeName,
        vd.CreatedAt
    FROM VoucherDetails vd
    JOIN Vouchers v ON vd.VoucherId = v.Id
    JOIN Accounts a ON vd.AccountCode = a.Code
    JOIN TransactionTypes tt ON vd.TransactionTypeId = tt.Id
    WHERE vd.VoucherId = p_VoucherId
    ORDER BY vd.Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VoucherDetail_Update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_VoucherDetail_Update`(
    IN p_VoucherDetailId INT,
    IN p_AccountCode VARCHAR(20),
    IN p_Description VARCHAR(255),
    IN p_Amount DECIMAL(18,2),
    IN p_TransactionTypeId INT
)
BEGIN
    DECLARE v_detail_exists BOOLEAN;
    DECLARE v_account_active BOOLEAN;
    DECLARE v_transaction_type_exists BOOLEAN;
    
    -- Validate detail exists
    SELECT COUNT(*) > 0 INTO v_detail_exists FROM VoucherDetails WHERE Id = p_VoucherDetailId;
    IF NOT v_detail_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher detail not found';
    END IF;
    
    -- Validate account exists and is active
    SELECT IsActive INTO v_account_active FROM Accounts WHERE Code = p_AccountCode;
    IF v_account_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account not found';
    ELSEIF NOT v_account_active THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account is inactive';
    END IF;
    
    -- Validate transaction type exists
    SELECT COUNT(*) > 0 INTO v_transaction_type_exists FROM TransactionTypes WHERE Id = p_TransactionTypeId;
    IF NOT v_transaction_type_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction type not found';
    END IF;
    
    -- Validate amount is positive
    IF p_Amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Amount must be positive';
    END IF;
    
    -- Update voucher detail
    UPDATE VoucherDetails
    SET AccountCode = p_AccountCode,
        Description = p_Description,
        Amount = p_Amount,
        TransactionTypeId = p_TransactionTypeId
    WHERE Id = p_VoucherDetailId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Voucher_Create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Voucher_Create`(
    IN p_VoucherNumber VARCHAR(20),
    IN p_VoucherDate DATETIME,
    IN p_VoucherTypeId INT,
    IN p_Description VARCHAR(255)
)
BEGIN
    DECLARE v_type_exists BOOLEAN;

    -- Validate voucher type
    SELECT COUNT(*) > 0 INTO v_type_exists FROM VoucherTypes WHERE Id = p_VoucherTypeId;
    IF NOT v_type_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid voucher type';
    END IF;
    
    -- Validate voucher number uniqueness
    IF EXISTS (SELECT 1 FROM Vouchers WHERE VoucherNumber = p_VoucherNumber) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher number already exists';
    END IF;
    
    -- Insert voucher
    INSERT INTO Vouchers (VoucherNumber, VoucherDate, VoucherTypeId, Description)
    VALUES (p_VoucherNumber, p_VoucherDate, p_VoucherTypeId, p_Description);
    
    SELECT max(id) AS voucherId from Vouchers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Voucher_Delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Voucher_Delete`(IN p_VoucherId INT)
BEGIN
    DECLARE v_voucher_exists BOOLEAN;
    
    -- Validate voucher exists
    SELECT COUNT(*) > 0 INTO v_voucher_exists FROM Vouchers WHERE Id = p_VoucherId;
    IF NOT v_voucher_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher not found';
    END IF;
    
    -- Delete will cascade to details
    DELETE FROM Vouchers WHERE Id = p_VoucherId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Voucher_GetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Voucher_GetAll`(
    IN p_VoucherNumber VARCHAR(20),
    IN p_VoucherTypeId INT,
    IN p_StartDate DATETIME,
    IN p_EndDate DATETIME,
    IN p_PageNumber INT,
    IN p_PageSize INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_PageNumber - 1) * p_PageSize;
    
    SELECT 
        v.Id,
        v.VoucherNumber,
        v.VoucherDate,
        v.VoucherTypeId,
        vt.Name AS VoucherTypeName,
        v.Description,
        v.TotalAmount,
        v.CreatedAt,
        COUNT(*) OVER() AS TotalCount
    FROM Vouchers v
    JOIN VoucherTypes vt ON v.VoucherTypeId = vt.Id
    WHERE (p_VoucherNumber IS NULL OR v.VoucherNumber LIKE CONCAT('%', p_VoucherNumber, '%'))
    AND (p_VoucherTypeId IS NULL OR v.VoucherTypeId = p_VoucherTypeId)
    AND (p_StartDate IS NULL OR v.VoucherDate >= p_StartDate)
    AND (p_EndDate IS NULL OR v.VoucherDate <= p_EndDate)
    ORDER BY v.VoucherDate DESC, v.VoucherNumber
    LIMIT v_offset, p_PageSize;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Voucher_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Voucher_GetById`(IN p_VoucherId INT)
BEGIN
    SELECT 
        v.Id,
        v.VoucherNumber,
        v.VoucherDate,
        v.VoucherTypeId,
        vt.Name AS VoucherTypeName,
        v.Description,
        v.TotalAmount,
        v.CreatedAt
    FROM Vouchers v
    JOIN VoucherTypes vt ON v.VoucherTypeId = vt.Id
    WHERE v.Id = p_VoucherId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Voucher_Update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Voucher_Update`(
    IN p_VoucherId INT,
    IN p_VoucherNumber VARCHAR(20),
    IN p_VoucherDate DATETIME,
    IN p_VoucherTypeId INT,
    IN p_Description VARCHAR(255)
)
BEGIN
    DECLARE v_type_exists BOOLEAN;
    DECLARE v_voucher_exists BOOLEAN;
    
    -- Validate voucher exists
    SELECT COUNT(*) > 0 INTO v_voucher_exists FROM Vouchers WHERE Id = p_VoucherId;
    IF NOT v_voucher_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher not found';
    END IF;
    
    -- Validate voucher type
    SELECT COUNT(*) > 0 INTO v_type_exists FROM VoucherTypes WHERE Id = p_VoucherTypeId;
    IF NOT v_type_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid voucher type';
    END IF;
    
    -- Validate voucher number uniqueness (excluding current voucher)
    IF EXISTS (SELECT 1 FROM Vouchers WHERE VoucherNumber = p_VoucherNumber AND Id != p_VoucherId) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher number already exists';
    END IF;
    
    -- Update voucher
    UPDATE Vouchers 
    SET VoucherNumber = p_VoucherNumber,
        VoucherDate = p_VoucherDate,
        VoucherTypeId = p_VoucherTypeId,
        Description = p_Description
    WHERE Id = p_VoucherId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-29 16:43:07
