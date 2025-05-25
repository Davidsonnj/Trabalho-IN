from dotenv import load_dotenv
from datetime import datetime
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

# Consulta no banco relacional
cursor_relacional.execute('''
SELECT 
    p.vlrRecebido,
    pl.nmPlano,
    pl.precoMensal,
    p.dtPagamento,
    COUNT(a.idAssinatura) AS qtd_assinatura
FROM Pagamento p
JOIN Assinatura a ON p.Assinatura_idAssinatura = a.idAssinatura
JOIN Plano pl ON a.Plano_idPlano = pl.idPlano
GROUP BY p.vlrRecebido, pl.nmPlano, pl.precoMensal, p.dtPagamento;

''')

resultados = cursor_relacional.fetchall()

for (vlRecebido, nmPlano, precoMensal, dtPagamento, qtd_assinatura) in resultados:

     # --- Dim_Pagamento ---
    cursor_dimensional.execute("SELECT idPagamento FROM Dim_Pagamento WHERE vlrRecebido = %s", (vlRecebido,))
    row = cursor_dimensional.fetchone()
    if row:
        idPagamento = row[0]
    else:
        cursor_dimensional.execute("INSERT INTO Dim_Pagamento (vlrRecebido) VALUES (%s)", (vlRecebido,))
        conn_dimensional.commit()
        idPagamento = cursor_dimensional.lastrowid

    # --- Dim_Plano ---
    cursor_dimensional.execute("SELECT idPlano FROM Dim_Plano WHERE nmPlano = %s AND precoMensal = %s", (nmPlano, precoMensal))
    row = cursor_dimensional.fetchone()
    if row:
        idPlano = row[0]
    else:
        cursor_dimensional.execute("INSERT INTO Dim_Plano (nmPlano, precoMensal) VALUES (%s, %s)", (nmPlano, precoMensal))
        conn_dimensional.commit()
        idPlano = cursor_dimensional.lastrowid
    
     # --- Dim_Data (Data de Pagamento) ---
    data_pagamento = datetime.strptime(dtPagamento, '%Y-%m-%d')
    mes = data_pagamento.month
    ano = data_pagamento.year

    cursor_dimensional.execute("SELECT idDim_Data FROM Dim_Data WHERE mes = %s AND ano = %s", (mes, ano))
    row = cursor_dimensional.fetchone()
    if row:
        idData = row[0]
    else:
        cursor_dimensional.execute("INSERT INTO Dim_Data (mes, ano) VALUES (%s, %s)", (mes, ano))
        conn_dimensional.commit()
        idData = cursor_dimensional.lastrowid

    # --- UPSERT na Fato_Receita ---
    cursor_dimensional.execute("""
        INSERT INTO Fato_Receita (
            qtd_assinaturas,
            fk_fato_receita_dim_plano,
            fk_fato_receita_dim_pagamento,
            fk_fato_receita_dim_data
        ) VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            qtd_assinaturas = qtd_assinaturas + VALUES(qtd_assinaturas)
    """, (qtd_assinatura, idPlano, idPagamento, idData))

    conn_dimensional.commit()
