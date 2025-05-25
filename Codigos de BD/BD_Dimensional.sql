-- ----------------------------------------------------------
-- Criação do banco de dados dimensional
-- ----------------------------------------------------------
CREATE DATABASE IF NOT EXISTS `dbnetf`
  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */
  /*!80016 DEFAULT ENCRYPTION='N' */;

USE `dbnetf`;

-- ----------------------------------------------------------
-- Tabela Dim_Data: armazena as dimensões de tempo (dia, mês, ano)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Data` (
  `idDim_Data` INT NOT NULL AUTO_INCREMENT,
  `mes` INT DEFAULT NULL,
  `ano` INT DEFAULT NULL,
  `dia` INT DEFAULT NULL,
  PRIMARY KEY (`idDim_Data`)
);

-- ----------------------------------------------------------
-- Tabela Dim_Localizacao: armazena dados geográficos
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Localizacao` (
  `idLocalizacao` INT NOT NULL AUTO_INCREMENT,
  `pais` VARCHAR(80) DEFAULT NULL,
  `continente` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`idLocalizacao`)
);

-- ----------------------------------------------------------
-- Tabela Dim_Pagamento: armazena valores recebidos
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `vlrRecebido` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`idPagamento`)
);

-- ----------------------------------------------------------
-- Tabela Dim_Plano: armazena os dados dos planos oferecidos
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Plano` (
  `idPlano` INT NOT NULL AUTO_INCREMENT,
  `nmPlano` VARCHAR(50) DEFAULT NULL,
  `precoMensal` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`idPlano`)
);

-- ----------------------------------------------------------
-- Tabela Dim_Usuario: armazena dados básicos dos usuários
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Usuario` (
  `idUsuario` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtNascimento` DATE DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
);

-- ----------------------------------------------------------
-- Tabela Fato_Assinatura: armazena fatos relacionados às assinaturas
-- Cada fato está relacionado a uma data, um usuário e uma localização
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fato_Assinatura` (
  `idAssinatura` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `qtd_novos_assinantes` INT DEFAULT NULL,
  `fk_assinatura_localizacao` INT NOT NULL,
  `fk_assinatura_data` INT NOT NULL,
  `fk_assinatura_usuario` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idAssinatura`),
  KEY `idx_Localizacao` (`fk_assinatura_localizacao`),
  KEY `idx_DataAssinatura` (`fk_assinatura_data`),
  KEY `idx_Usuario` (`fk_assinatura_usuario`),
  CONSTRAINT `fk_Fato_Assinatura_Data` FOREIGN KEY (`fk_assinatura_data`) REFERENCES `Dim_Data` (`idDim_Data`),
  CONSTRAINT `fk_Fato_Assinatura_Localizacao` FOREIGN KEY (`fk_assinatura_localizacao`) REFERENCES `Dim_Localizacao` (`idLocalizacao`),
  CONSTRAINT `fk_Fato_Assinatura_Usuario` FOREIGN KEY (`fk_assinatura_usuario`) REFERENCES `Dim_Usuario` (`idUsuario`)
);

-- ----------------------------------------------------------
-- Tabela Fato_Receita: armazena fatos relacionados à receita
-- Cada fato está vinculado a um plano, um pagamento e uma data
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fato_Receita` (
  `idFato_Receita` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_receita_plano` INT NOT NULL,
  `fk_receita_pagamento` INT NOT NULL,
  `fk_receita_data` INT NOT NULL,
  PRIMARY KEY (`idFato_Receita`),
  KEY `idx_Plano` (`fk_receita_plano`),
  KEY `idx_Pagamento` (`fk_receita_pagamento`),
  KEY `idx_DataPagamento` (`fk_receita_data`),
  CONSTRAINT `fk_Fato_Receita_DataPagamento` FOREIGN KEY (`fk_receita_data`) REFERENCES `Dim_Data` (`idDim_Data`),
  CONSTRAINT `fk_Fato_Receita_Pagamento` FOREIGN KEY (`fk_receita_pagamento`) REFERENCES `Dim_Pagamento` (`idPagamento`),
  CONSTRAINT `fk_Fato_Receita_Plano` FOREIGN KEY (`fk_receita_plano`) REFERENCES `Dim_Plano` (`idPlano`)
);
