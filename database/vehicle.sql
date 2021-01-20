-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: vehicle
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `app_no` varchar(50) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `purpose` varchar(25) DEFAULT NULL,
  `destination` varchar(30) DEFAULT NULL,
  `passenger` int DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `alloted` int DEFAULT NULL,
  `emp_code` varchar(25) DEFAULT NULL,
  `approve` int DEFAULT NULL,
  `cancel` int DEFAULT NULL,
  `cancel_remark_user` varchar(200) DEFAULT NULL,
  `cancel_remark_admin` varchar(200) DEFAULT NULL,
  `outs` int DEFAULT '0',
  `number` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`app_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `driver_code` varchar(25) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `father_name` varchar(25) DEFAULT NULL,
  `license_no` varchar(25) DEFAULT NULL,
  `contact_no` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `doj` date DEFAULT NULL,
  `live` int DEFAULT NULL,
  `company_flag` varchar(25) DEFAULT NULL,
  `license_valid` date DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `available` int DEFAULT NULL,
  PRIMARY KEY (`driver_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_code` varchar(25) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `password` varchar(25) DEFAULT NULL,
  `emp_dept` varchar(25) DEFAULT NULL,
  `reg_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_application` int DEFAULT '0',
  `admin` int DEFAULT '0',
  PRIMARY KEY (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fuel_transaction`
--

DROP TABLE IF EXISTS `fuel_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fuel_transaction` (
  `bill_no` varchar(25) NOT NULL,
  `registeration_no` varchar(25) DEFAULT NULL,
  `filling_date` date DEFAULT NULL,
  `name_of_party` varchar(30) DEFAULT NULL,
  `present_km` double DEFAULT NULL,
  `liter` double DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `average` double DEFAULT NULL,
  `cost_per_km` double DEFAULT NULL,
  `remark` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`bill_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gate`
--

DROP TABLE IF EXISTS `gate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate` (
  `emp_code` varchar(25) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `password` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `journey`
--

DROP TABLE IF EXISTS `journey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journey` (
  `app_no` int NOT NULL,
  `emp_code` varchar(25) DEFAULT NULL,
  `driver_code` varchar(25) DEFAULT NULL,
  `registeration_no` varchar(25) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `final_km` double DEFAULT NULL,
  `completed` int DEFAULT '0',
  `present_km` double DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `payable` double DEFAULT NULL,
  `start` int DEFAULT '0',
  PRIMARY KEY (`app_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance` (
  `registeration_no` varchar(25) NOT NULL,
  `start` date NOT NULL,
  `upto` date NOT NULL,
  `cost` double DEFAULT NULL,
  PRIMARY KEY (`registeration_no`,`start`,`upto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p`
--

DROP TABLE IF EXISTS `p`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p` (
  `Personid` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`Personid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `private_expense`
--

DROP TABLE IF EXISTS `private_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_expense` (
  `registeration_no` varchar(25) NOT NULL,
  `start` date NOT NULL,
  `upto` date NOT NULL,
  `km_run` double DEFAULT NULL,
  `liter` double DEFAULT NULL,
  `average` double DEFAULT NULL,
  `cost_per_km` double DEFAULT NULL,
  `opening` double DEFAULT NULL,
  `closing` double DEFAULT NULL,
  `last_service_date` date DEFAULT NULL,
  `service_km` double DEFAULT NULL,
  PRIMARY KEY (`registeration_no`,`start`,`upto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate`
--

DROP TABLE IF EXISTS `rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate` (
  `registeration_no` varchar(25) NOT NULL,
  `valid_upto` date NOT NULL,
  `rate` double DEFAULT NULL,
  PRIMARY KEY (`registeration_no`,`valid_upto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_at` time DEFAULT NULL,
  `end_at` time DEFAULT NULL,
  `st` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `chassis_no` varchar(25) NOT NULL,
  `registeration_no` varchar(25) NOT NULL,
  `engine_no` varchar(25) DEFAULT NULL,
  `manufacturing_date` date DEFAULT NULL,
  `wheel_base` varchar(25) DEFAULT NULL,
  `cubic_capacity` int DEFAULT NULL,
  `engine_capacity` int DEFAULT NULL,
  `sitting_capacity` int DEFAULT NULL,
  `vehicle_class` varchar(25) DEFAULT NULL,
  `model_name` varchar(25) DEFAULT NULL,
  `vehicle_make` varchar(25) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `registeration_date` date DEFAULT NULL,
  `body_type` varchar(25) DEFAULT NULL,
  `fuel_type` varchar(25) DEFAULT NULL,
  `color` varchar(25) DEFAULT NULL,
  `live` int DEFAULT NULL,
  `available` int DEFAULT NULL,
  `company_flag` varchar(25) DEFAULT NULL,
  `cylinder` int DEFAULT NULL,
  `registeration_validity` date DEFAULT NULL,
  `remark` varchar(150) DEFAULT NULL,
  `present_km` double DEFAULT NULL,
  `user` varchar(25) DEFAULT NULL,
  `usable` int DEFAULT NULL,
  PRIMARY KEY (`registeration_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicle_transaction`
--

DROP TABLE IF EXISTS `vehicle_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_transaction` (
  `registeration_no` varchar(25) NOT NULL,
  `insurance_upto` date DEFAULT NULL,
  `servicing_upto` date DEFAULT NULL,
  `pollution_control_valid` date DEFAULT NULL,
  `certificate_of_fitness` date DEFAULT NULL,
  `servicing_date` date DEFAULT NULL,
  `servicing_km` double DEFAULT NULL,
  PRIMARY KEY (`registeration_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-20 21:59:57
