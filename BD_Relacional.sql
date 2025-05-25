-- ----------------------------------------------------------
-- Criação do banco de dados relacional
-- ----------------------------------------------------------
CREATE DATABASE dbnetf
  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */
  /*!80016 DEFAULT ENCRYPTION='N' */;

USE dbnetf;

-- ----------------------------------------------------------
-- Tabela Pais: armazena os países dos usuários
-- ----------------------------------------------------------
CREATE TABLE Pais (
  idPais INT NOT NULL,
  nmPais VARCHAR(80) DEFAULT NULL,
  PRIMARY KEY (idPais)
);

-- ----------------------------------------------------------
-- Tabela Plano: define os planos de assinatura disponíveis
-- ----------------------------------------------------------
CREATE TABLE Plano (
  idPlano INT NOT NULL,
  nmPlano VARCHAR(50) DEFAULT NULL,
  precoMensal DECIMAL(10,2) DEFAULT NULL,
  numTelas INT DEFAULT NULL,  -- Quantidade de telas permitidas
  PRIMARY KEY (idPlano)
);

-- ----------------------------------------------------------
-- Tabela SituacaoAssinatura: status da assinatura (ativa, cancelada, etc.)
-- ----------------------------------------------------------
CREATE TABLE SituacaoAssinatura (
  idSituacao SMALLINT NOT NULL,
  descricao VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (idSituacao)
);

-- ----------------------------------------------------------
-- Tabela Usuario: dados cadastrais dos usuários da plataforma
-- ----------------------------------------------------------
CREATE TABLE Usuario (
  idUsuario BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) DEFAULT NULL,
  email VARCHAR(100) DEFAULT NULL,
  dtNascimento DATE DEFAULT NULL,
  sexo CHAR(1) DEFAULT NULL,  -- M = Masculino, F = Feminino, etc.
  pais_idPais INT NOT NULL,  -- Chave estrangeira para a tabela Pais
  PRIMARY KEY (idUsuario),
  UNIQUE KEY email_UNIQUE (email),  -- Garante que não existam dois emails iguais
  KEY fk_usuario_pais_idx (pais_idPais),
  CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_idPais) REFERENCES Pais (idPais)
);

-- ----------------------------------------------------------
-- Tabela Assinatura: controla as assinaturas dos usuários
-- ----------------------------------------------------------
CREATE TABLE Assinatura (
  idAssinatura BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  dtInicio DATE DEFAULT NULL,  -- Data de início da assinatura
  dtFim DATE DEFAULT NULL,     -- Data de término da assinatura (caso cancelada)
  Usuario_idUsuario BIGINT UNSIGNED NOT NULL,  -- FK para o usuário
  Plano_idPlano INT NOT NULL,                  -- FK para o plano contratado
  SituacaoAssinatura_idSituacao SMALLINT NOT NULL,  -- FK para o status da assinatura
  PRIMARY KEY (idAssinatura),
  KEY fk_Assinatura_Usuario_idx (Usuario_idUsuario),
  KEY fk_Assinatura_Plano_idx (Plano_idPlano),
  KEY fk_Assinatura_Situacao_idx (SituacaoAssinatura_idSituacao),
  CONSTRAINT fk_Assinatura_Usuario FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario (idUsuario),
  CONSTRAINT fk_Assinatura_Plano FOREIGN KEY (Plano_idPlano) REFERENCES Plano (idPlano),
  CONSTRAINT fk_Assinatura_Situacao FOREIGN KEY (SituacaoAssinatura_idSituacao) REFERENCES SituacaoAssinatura (idSituacao)
);

-- ----------------------------------------------------------
-- Tabela Pagamento: registros de pagamentos realizados
-- ----------------------------------------------------------
CREATE TABLE Pagamento (
  idPagamento INT NOT NULL,
  dtPagamento VARCHAR(45) DEFAULT NULL,   -- Armazenado como texto (poderia ser DATE)
  vlrRecebido VARCHAR(45) DEFAULT NULL,   -- Armazenado como texto (poderia ser DECIMAL)
  Assinatura_idAssinatura BIGINT UNSIGNED NOT NULL,  -- FK para a assinatura relacionada
  PRIMARY KEY (idPagamento),
  KEY fk_Pagamento_Assinatura_idx (Assinatura_idAssinatura),
  CONSTRAINT fk_Pagamento_Assinatura FOREIGN KEY (Assinatura_idAssinatura) REFERENCES Assinatura (idAssinatura)
);
