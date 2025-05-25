-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: trabalho-kelly-banco-de-dados-2024-1.l.aivencloud.com    Database: dbnetf
-- ------------------------------------------------------
-- Server version	8.0.35

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'd178803b-30cc-11f0-b3a5-862ccfb065fd:1-88,
ff3df538-303a-11f0-9374-0aa2322425ff:1-45';

--
-- Table structure for table `Assinatura`
--

DROP TABLE IF EXISTS `Assinatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assinatura` (
  `idAssinatura` bigint unsigned NOT NULL AUTO_INCREMENT,
  `dtInicio` date DEFAULT NULL,
  `dtFim` date DEFAULT NULL,
  `Usuario_idUsuario` bigint unsigned NOT NULL,
  `Plano_idPlano` int NOT NULL,
  `SituacaoAssinatura_idSituacao` smallint NOT NULL,
  PRIMARY KEY (`idAssinatura`),
  UNIQUE KEY `idAssinatura` (`idAssinatura`),
  KEY `fk_Assinatura_Usuario1_idx` (`Usuario_idUsuario`),
  KEY `fk_Assinatura_Plano1_idx` (`Plano_idPlano`),
  KEY `fk_Assinatura_SituacaoAssinatura1_idx` (`SituacaoAssinatura_idSituacao`),
  CONSTRAINT `fk_Assinatura_Plano1` FOREIGN KEY (`Plano_idPlano`) REFERENCES `Plano` (`idPlano`),
  CONSTRAINT `fk_Assinatura_SituacaoAssinatura1` FOREIGN KEY (`SituacaoAssinatura_idSituacao`) REFERENCES `SituacaoAssinatura` (`idSituacao`),
  CONSTRAINT `fk_Assinatura_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assinatura`
--

LOCK TABLES `Assinatura` WRITE;
/*!40000 ALTER TABLE `Assinatura` DISABLE KEYS */;
INSERT INTO `Assinatura` VALUES (1,'2014-01-01','2014-06-30',1,1,2),(2,'2015-03-01','2015-12-31',2,2,2),(3,'2016-05-15','2017-04-15',3,3,2),(4,'2017-01-10','2017-11-10',4,4,2),(5,'2018-02-01','2018-07-31',5,5,2);
/*!40000 ALTER TABLE `Assinatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pagamento`
--

DROP TABLE IF EXISTS `Pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pagamento` (
  `idPagamento` int NOT NULL,
  `dtPagamento` varchar(45) DEFAULT NULL,
  `vlrRecebido` varchar(45) DEFAULT NULL,
  `Assinatura_idAssinatura` bigint unsigned NOT NULL,
  PRIMARY KEY (`idPagamento`),
  KEY `fk_Pagamento_Assinatura1_idx` (`Assinatura_idAssinatura`),
  CONSTRAINT `fk_Pagamento_Assinatura1` FOREIGN KEY (`Assinatura_idAssinatura`) REFERENCES `Assinatura` (`idAssinatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pagamento`
--

LOCK TABLES `Pagamento` WRITE;
/*!40000 ALTER TABLE `Pagamento` DISABLE KEYS */;
INSERT INTO `Pagamento` VALUES (1,'2014-01-05','19.90',1),(2,'2014-02-05','19.90',1),(3,'2014-03-05','19.90',1),(4,'2014-04-05','19.90',1),(5,'2014-05-05','19.90',1),(6,'2014-06-05','19.90',1),(7,'2015-03-05','29.90',2),(8,'2015-04-05','29.90',2),(9,'2015-05-05','29.90',2),(10,'2015-06-05','29.90',2),(11,'2015-07-05','29.90',2),(12,'2015-08-05','29.90',2),(13,'2015-09-05','29.90',2),(14,'2015-10-05','29.90',2),(15,'2015-11-05','29.90',2),(16,'2015-12-05','29.90',2),(17,'2016-05-20','39.90',3),(18,'2016-06-20','39.90',3),(19,'2016-07-20','39.90',3),(20,'2016-08-20','39.90',3),(21,'2016-09-20','39.90',3),(22,'2016-10-20','39.90',3),(23,'2016-11-20','39.90',3),(24,'2016-12-20','39.90',3),(25,'2017-01-20','39.90',3),(26,'2017-02-20','39.90',3),(27,'2017-03-20','39.90',3),(28,'2017-04-20','39.90',3),(29,'2017-01-15','49.90',4),(30,'2017-02-15','49.90',4),(31,'2017-03-15','49.90',4),(32,'2017-04-15','49.90',4),(33,'2017-05-15','49.90',4),(34,'2017-06-15','49.90',4),(35,'2017-07-15','49.90',4),(36,'2017-08-15','49.90',4),(37,'2017-09-15','49.90',4),(38,'2017-10-15','49.90',4),(39,'2017-11-15','49.90',4),(40,'2018-02-10','14.90',5),(41,'2018-03-10','14.90',5),(42,'2018-04-10','14.90',5),(43,'2018-05-10','14.90',5),(44,'2018-06-10','14.90',5),(45,'2018-07-10','14.90',5);
/*!40000 ALTER TABLE `Pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pais`
--

DROP TABLE IF EXISTS `Pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pais` (
  `idPais` int NOT NULL,
  `nmPais` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`idPais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pais`
--

LOCK TABLES `Pais` WRITE;
/*!40000 ALTER TABLE `Pais` DISABLE KEYS */;
INSERT INTO `Pais` VALUES (1,'Brasil'),(2,'Estados Unidos'),(3,'Canadá'),(4,'Japão'),(5,'Alemanha');
/*!40000 ALTER TABLE `Pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Plano`
--

DROP TABLE IF EXISTS `Plano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Plano` (
  `idPlano` int NOT NULL,
  `nmPlano` varchar(50) DEFAULT NULL,
  `precoMensal` decimal(10,2) DEFAULT NULL,
  `numTelas` int DEFAULT NULL,
  PRIMARY KEY (`idPlano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Plano`
--

LOCK TABLES `Plano` WRITE;
/*!40000 ALTER TABLE `Plano` DISABLE KEYS */;
INSERT INTO `Plano` VALUES (1,'Básico',19.90,1),(2,'Padrão',29.90,2),(3,'Premium',39.90,4),(4,'Familiar',49.90,5),(5,'Estudante',14.90,1);
/*!40000 ALTER TABLE `Plano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SituacaoAssinatura`
--

DROP TABLE IF EXISTS `SituacaoAssinatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SituacaoAssinatura` (
  `idSituacao` smallint NOT NULL,
  `descricao` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`idSituacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SituacaoAssinatura`
--

LOCK TABLES `SituacaoAssinatura` WRITE;
/*!40000 ALTER TABLE `SituacaoAssinatura` DISABLE KEYS */;
INSERT INTO `SituacaoAssinatura` VALUES (1,'Ativa'),(2,'Cancelada'),(3,'Pendente'),(4,'Suspensa'),(5,'Expirada');
/*!40000 ALTER TABLE `SituacaoAssinatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `idUsuario` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dtNascimento` date DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL,
  `pais_idPais` int NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `idUsuario` (`idUsuario`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_usuario_pais_idx` (`pais_idPais`),
  CONSTRAINT `fk_usuario_pais` FOREIGN KEY (`pais_idPais`) REFERENCES `Pais` (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'João Silva','joao@gmail.com','1985-05-15','M',1),(2,'Maria Souza','maria@gmail.com','1990-08-20','F',2),(3,'Lucas Pereira','lucas@gmail.com','1988-11-11','M',3),(4,'Ana Tanaka','ana@gmail.com','1995-02-03','F',4),(5,'Karl Schmidt','karl@gmail.com','1982-12-30','M',5);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dbnetf'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-25 18:57:45
