-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 11, 2025 at 04:26 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthcare`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `accountID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `loginID` int NOT NULL,
  PRIMARY KEY (`accountID`),
  KEY `logID` (`loginID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `adminID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
CREATE TABLE IF NOT EXISTS `alert` (
  `alertID` int NOT NULL AUTO_INCREMENT,
  `message` varchar(100) NOT NULL,
  `alertLevel` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` varchar(20) NOT NULL,
  `patientID` int NOT NULL,
  `doctorID` int NOT NULL,
  `serverID` int NOT NULL,
  PRIMARY KEY (`alertID`),
  KEY `doctorID` (`doctorID`),
  KEY `patientID` (`patientID`),
  KEY `serverID` (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `association_doctor_patient`
--

DROP TABLE IF EXISTS `association_doctor_patient`;
CREATE TABLE IF NOT EXISTS `association_doctor_patient` (
  `associationID` int NOT NULL AUTO_INCREMENT,
  `assignedDate` datetime NOT NULL,
  `doctorID` int NOT NULL,
  `patientID` int NOT NULL,
  PRIMARY KEY (`associationID`),
  KEY `doc_ID` (`doctorID`),
  KEY `pat_ID` (`patientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
CREATE TABLE IF NOT EXISTS `auditlog` (
  `logID` int NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `description` varchar(100) NOT NULL,
  `serverID` int NOT NULL,
  PRIMARY KEY (`logID`),
  KEY `se_ID` (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `authentification`
--

DROP TABLE IF EXISTS `authentification`;
CREATE TABLE IF NOT EXISTS `authentification` (
  `loginID` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(20) NOT NULL,
  `serverID` int NOT NULL,
  PRIMARY KEY (`loginID`),
  KEY `s_ID` (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cloudserver`
--

DROP TABLE IF EXISTS `cloudserver`;
CREATE TABLE IF NOT EXISTS `cloudserver` (
  `serverID` int NOT NULL AUTO_INCREMENT,
  `status` varchar(20) NOT NULL,
  `location` varchar(50) NOT NULL,
  PRIMARY KEY (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
CREATE TABLE IF NOT EXISTS `doctor` (
  `doctorID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`doctorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `healthdashboard`
--

DROP TABLE IF EXISTS `healthdashboard`;
CREATE TABLE IF NOT EXISTS `healthdashboard` (
  `dashboardID` int NOT NULL AUTO_INCREMENT,
  `viewType` varchar(20) NOT NULL,
  `lastUpdated` datetime NOT NULL,
  `accountID` int NOT NULL,
  `serverID` int NOT NULL,
  PRIMARY KEY (`dashboardID`),
  KEY `a_ID` (`accountID`),
  KEY `serv_ID` (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `healthrecord`
--

DROP TABLE IF EXISTS `healthrecord`;
CREATE TABLE IF NOT EXISTS `healthrecord` (
  `recordID` int NOT NULL AUTO_INCREMENT,
  `filePath` varchar(50) NOT NULL,
  `patientID` int NOT NULL,
  `vitalID` int NOT NULL,
  PRIMARY KEY (`recordID`),
  KEY `p_ID` (`patientID`),
  KEY `vitalID` (`vitalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `iotdevice`
--

DROP TABLE IF EXISTS `iotdevice`;
CREATE TABLE IF NOT EXISTS `iotdevice` (
  `deviceID` int NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `lastSynced` timestamp NOT NULL,
  `patientID` int NOT NULL,
  PRIMARY KEY (`deviceID`),
  KEY `pa_ID` (`patientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ocr`
--

DROP TABLE IF EXISTS `ocr`;
CREATE TABLE IF NOT EXISTS `ocr` (
  `ocrID` int NOT NULL AUTO_INCREMENT,
  `filePath` varchar(100) NOT NULL,
  `extractedText` text NOT NULL,
  `serverID` int NOT NULL,
  PRIMARY KEY (`ocrID`),
  KEY `ser_ID` (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `patientID` int NOT NULL AUTO_INCREMENT,
  `recordID` int NOT NULL,
  PRIMARY KEY (`patientID`),
  KEY `recordID` (`recordID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `riskevaluator`
--

DROP TABLE IF EXISTS `riskevaluator`;
CREATE TABLE IF NOT EXISTS `riskevaluator` (
  `evaluatorID` int NOT NULL AUTO_INCREMENT,
  `riskScore` int NOT NULL,
  `evaluationDate` datetime NOT NULL,
  `evaluationFormula` varchar(100) NOT NULL,
  `patientID` int NOT NULL,
  `serverID` int NOT NULL,
  PRIMARY KEY (`evaluatorID`),
  KEY `pati_ID` (`patientID`),
  KEY `serve_ID` (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vitalsign`
--

DROP TABLE IF EXISTS `vitalsign`;
CREATE TABLE IF NOT EXISTS `vitalsign` (
  `vitalID` int NOT NULL AUTO_INCREMENT,
  `bloodPressure` float NOT NULL,
  `heartRate` int NOT NULL,
  `temperature` float NOT NULL,
  `GLU` float NOT NULL,
  `WBC` float NOT NULL,
  `RBC` float NOT NULL,
  `deviceID` int NOT NULL,
  PRIMARY KEY (`vitalID`),
  KEY `deviceID` (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `logID` FOREIGN KEY (`loginID`) REFERENCES `authentification` (`loginID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `alert`
--
ALTER TABLE `alert`
  ADD CONSTRAINT `doctorID` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`doctorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patientID` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `serverID` FOREIGN KEY (`serverID`) REFERENCES `cloudserver` (`serverID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `association_doctor_patient`
--
ALTER TABLE `association_doctor_patient`
  ADD CONSTRAINT `doc_ID` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`doctorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pat_ID` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `auditlog`
--
ALTER TABLE `auditlog`
  ADD CONSTRAINT `se_ID` FOREIGN KEY (`serverID`) REFERENCES `cloudserver` (`serverID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `authentification`
--
ALTER TABLE `authentification`
  ADD CONSTRAINT `s_ID` FOREIGN KEY (`serverID`) REFERENCES `cloudserver` (`serverID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `healthdashboard`
--
ALTER TABLE `healthdashboard`
  ADD CONSTRAINT `a_ID` FOREIGN KEY (`accountID`) REFERENCES `account` (`accountID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `serv_ID` FOREIGN KEY (`serverID`) REFERENCES `cloudserver` (`serverID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `healthrecord`
--
ALTER TABLE `healthrecord`
  ADD CONSTRAINT `p_ID` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vitalID` FOREIGN KEY (`vitalID`) REFERENCES `vitalsign` (`vitalID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `iotdevice`
--
ALTER TABLE `iotdevice`
  ADD CONSTRAINT `pa_ID` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ocr`
--
ALTER TABLE `ocr`
  ADD CONSTRAINT `ser_ID` FOREIGN KEY (`serverID`) REFERENCES `cloudserver` (`serverID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `recordID` FOREIGN KEY (`recordID`) REFERENCES `healthrecord` (`recordID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `riskevaluator`
--
ALTER TABLE `riskevaluator`
  ADD CONSTRAINT `pati_ID` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `serve_ID` FOREIGN KEY (`serverID`) REFERENCES `cloudserver` (`serverID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vitalsign`
--
ALTER TABLE `vitalsign`
  ADD CONSTRAINT `deviceID` FOREIGN KEY (`deviceID`) REFERENCES `iotdevice` (`deviceID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
