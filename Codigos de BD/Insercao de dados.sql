USE dbnetf;

-- Inserir países
INSERT INTO Pais (idPais, nmPais) VALUES
(1, 'Brasil'),
(2, 'Estados Unidos'),
(3, 'Canadá'),
(4, 'Japão'),
(5, 'Alemanha');

-- Inserir planos
INSERT INTO Plano (idPlano, nmPlano, precoMensal, numTelas) VALUES
(1, 'Básico', 19.90, 1),
(2, 'Padrão', 29.90, 2),
(3, 'Premium', 39.90, 4),
(4, 'Familiar', 49.90, 5),
(5, 'Estudante', 14.90, 1);

-- Inserir situações de assinatura
INSERT INTO SituacaoAssinatura (idSituacao, descricao) VALUES
(1, 'Ativa'),
(2, 'Cancelada'),
(3, 'Pendente'),
(4, 'Suspensa'),
(5, 'Expirada');

-- Inserir usuários com IDs explícitos
INSERT INTO Usuario (idUsuario, nome, email, dtNascimento, sexo, pais_idPais) VALUES
(1, 'João Silva', 'joao@gmail.com', '1985-05-15', 'M', 1),
(2, 'Maria Souza', 'maria@gmail.com', '1990-08-20', 'F', 2),
(3, 'Lucas Pereira', 'lucas@gmail.com', '1988-11-11', 'M', 3),
(4, 'Ana Tanaka', 'ana@gmail.com', '1995-02-03', 'F', 4),
(5, 'Karl Schmidt', 'karl@gmail.com', '1982-12-30', 'M', 5);

-- Inserir assinaturas
INSERT INTO Assinatura (idAssinatura, dtInicio, dtFim, Usuario_idUsuario, Plano_idPlano, SituacaoAssinatura_idSituacao) VALUES
(1, '2014-01-01', '2014-06-30', 1, 1, 2),
(2, '2015-03-01', '2015-12-31', 2, 2, 2),
(3, '2016-05-15', '2017-04-15', 3, 3, 2),
(4, '2017-01-10', '2017-11-10', 4, 4, 2),
(5, '2018-02-01', '2018-07-31', 5, 5, 2);

-- [Demais INSERTs de Pagamento estão corretos, pode deixar como estão]
-- Como você já inseriu todos os dados com IDs consistentes, os pagamentos também funcionarão corretamente.


INSERT INTO Pagamento (idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura) VALUES
(1, '2014-01-05', '19.90', 1),
(2, '2014-02-05', '19.90', 1),
(3, '2014-03-05', '19.90', 1),
(4, '2014-04-05', '19.90', 1),
(5, '2014-05-05', '19.90', 1),
(6, '2014-06-05', '19.90', 1);

-- Assinatura 2: Mar/2015 a Dez/2015 (10 meses)
INSERT INTO Pagamento (idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura) VALUES
(7, '2015-03-05', '29.90', 2),
(8, '2015-04-05', '29.90', 2),
(9, '2015-05-05', '29.90', 2),
(10, '2015-06-05', '29.90', 2),
(11, '2015-07-05', '29.90', 2),
(12, '2015-08-05', '29.90', 2),
(13, '2015-09-05', '29.90', 2),
(14, '2015-10-05', '29.90', 2),
(15, '2015-11-05', '29.90', 2),
(16, '2015-12-05', '29.90', 2);

-- Assinatura 3: Mai/2016 a Abr/2017 (12 meses)
INSERT INTO Pagamento (idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura) VALUES
(17, '2016-05-20', '39.90', 3),
(18, '2016-06-20', '39.90', 3),
(19, '2016-07-20', '39.90', 3),
(20, '2016-08-20', '39.90', 3),
(21, '2016-09-20', '39.90', 3),
(22, '2016-10-20', '39.90', 3),
(23, '2016-11-20', '39.90', 3),
(24, '2016-12-20', '39.90', 3),
(25, '2017-01-20', '39.90', 3),
(26, '2017-02-20', '39.90', 3),
(27, '2017-03-20', '39.90', 3),
(28, '2017-04-20', '39.90', 3);

-- Assinatura 4: Jan/2017 a Nov/2017 (11 meses)
INSERT INTO Pagamento (idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura) VALUES
(29, '2017-01-15', '49.90', 4),
(30, '2017-02-15', '49.90', 4),
(31, '2017-03-15', '49.90', 4),
(32, '2017-04-15', '49.90', 4),
(33, '2017-05-15', '49.90', 4),
(34, '2017-06-15', '49.90', 4),
(35, '2017-07-15', '49.90', 4),
(36, '2017-08-15', '49.90', 4),
(37, '2017-09-15', '49.90', 4),
(38, '2017-10-15', '49.90', 4),
(39, '2017-11-15', '49.90', 4);

-- Assinatura 5: Fev/2018 a Jul/2018 (6 meses)
INSERT INTO Pagamento (idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura) VALUES
(40, '2018-02-10', '14.90', 5),
(41, '2018-03-10', '14.90', 5),
(42, '2018-04-10', '14.90', 5),
(43, '2018-05-10', '14.90', 5),
(44, '2018-06-10', '14.90', 5),
(45, '2018-07-10', '14.90', 5);

