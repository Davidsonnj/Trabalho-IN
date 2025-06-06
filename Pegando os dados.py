from dotenv import load_dotenv
import pymysql
import os

load_dotenv()

# Conexão com o banco relacional
conn_relacional = pymysql.connect(
    host = os.getenv('HOST_RELACIONAL'),
    port = int(os.getenv('PORT_RELACIONAL')),
    user = os.getenv('USER_RELACIONAL'),
    password = os.getenv('PASSWORD_RELACIONAL'),
    database = os.getenv('DATABASE_RELACIONAL'),
)

# Conexão com o banco dimensional
conn_dimensional = pymysql.connect(
    host = os.getenv('HOST_DIMENSIONAL'),
    port = int(os.getenv('PORT_DIMENSIONAL')),
    user = os.getenv('USER_DIMENSIONAL'),
    password = os.getenv('PASSWORD_DIMENSIONAL'),
    database = os.getenv('DATABASE_DIMENSIONAL'),
)

cursor_relacional = conn_relacional.cursor()
cursor_dimensional = conn_dimensional.cursor()

cursor_relacional.execute("SELECT idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura FROM Pagamento;")
tabela_pagamento = cursor_relacional.fetchall()

for (idPagamento, dtPagamento, vlrRecebido, Assinatura_idAssinatura) in tabela_pagamento:
    print(f"idPagamento: {idPagamento} | dtPagamento: {dtPagamento} | vlrRecebido: {vlrRecebido} | Assinatura_idAssinatura: {Assinatura_idAssinatura}")

cursor_relacional.execute("SELECT idAssinatura, dtInicio, dtFim, Usuario_idUsuario, Plano_idPlano, SituacaoAssinatura_idSituacao FROM Assinatura")
tabela_assinatura = cursor_relacional.fetchall()

for (idAssinatura, dtInicio, dtFim, Usuario_idUsuario, Plano_idPlano, SituacaoAssinatura_idSituacao) in tabela_assinatura:
    print(f"idAssinatura: {idAssinatura} | dtInicio: {dtInicio} | dtFim: {dtFim} | Usuario_idUsuario: {Usuario_idUsuario} | Plano_idPlano: {Plano_idPlano} | SituacaoAssinatura_idSituacao: {SituacaoAssinatura_idSituacao}")

cursor_relacional.execute("SELECT nome, email, dtnascimento, sexo, pais_idpais FROM Usuario")
tabela_usuario = cursor_relacional.fetchall()

for (nome, email, dtnascimento, sexo, pais_idpais) in tabela_usuario:
    print(f"nome: {nome} | email: {email} | dtnascimento: {dtnascimento} | sexo: {sexo} | pais_idpais: {pais_idpais}")

cursor_relacional.execute("SELECT nmPais FROM Pais")
tabela_pais = cursor_relacional.fetchall()

for (nmPais) in tabela_pais:
    print(f"nmPais: {nmPais[0]}")
          
cursor_relacional.execute("SELECT nmPlano, precoMensal, numTelas FROM Plano")
tabela_plano = cursor_relacional.fetchall()

for (nmPlano, precoMensal, numTelas) in tabela_plano:
    print(f"nmPlano: {nmPlano} | precoMensal: {precoMensal} | numTelas: {numTelas}")

cursor_relacional.execute("SELECT descricao FROM SituacaoAssinatura")
tabela_SituacaoAssinatura = cursor_relacional.fetchall()

for (descricao) in tabela_SituacaoAssinatura:
    print(f"descricao: {descricao[0]}")


    

print(cursor_relacional.fetchall())

# Fechando a conexão
cursor_relacional.close()
cursor_dimensional.close()

conn_dimensional.close()
conn_relacional.close()