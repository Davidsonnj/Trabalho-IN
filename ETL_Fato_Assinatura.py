from dotenv import load_dotenv
import localizacao
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
SELECT a.idAssinatura, u.dtnascimento, p.nmPais, a.dtInicio, u.email
FROM Assinatura a
JOIN Usuario u ON a.Usuario_idUsuario = u.idUsuario
JOIN Pais p ON u.pais_idpais = p.idPais
''')

resultados = cursor_relacional.fetchall()

for (idAssinatura, dtnascimento, nmPais, dtInicio, email) in resultados:

    # --- Dim_Localizacao ---
    cursor_dimensional.execute("SELECT idLocalizacao FROM Dim_Localizacao WHERE pais = %s", (nmPais,))
    row = cursor_dimensional.fetchone()
    if row:
        idLocalizacao = row[0]
    else:
        continente = localizacao.obter_continente(nmPais)
        cursor_dimensional.execute("INSERT INTO Dim_Localizacao (pais, continente) VALUES (%s, %s)", (nmPais, continente))
        conn_dimensional.commit()
        idLocalizacao = cursor_dimensional.lastrowid

    # --- Dim_Usuario ---
    cursor_dimensional.execute("SELECT idUsuario FROM Dim_Usuario WHERE dtNascimento = %s AND email = %s", (dtnascimento, email))
    row = cursor_dimensional.fetchone()
    if row:
        idUsuario = row[0]
    else:
        cursor_dimensional.execute("INSERT INTO Dim_Usuario (dtNascimento, email) VALUES (%s, %s)", (dtnascimento, email))
        conn_dimensional.commit()
        idUsuario = cursor_dimensional.lastrowid

    # --- Dim_Data (Data de Assinatura) ---
    mes = dtInicio.month
    ano = dtInicio.year

    cursor_dimensional.execute("SELECT idDim_Data FROM Dim_Data WHERE mes = %s AND ano = %s", (mes, ano))
    row = cursor_dimensional.fetchone()
    if row:
        idData = row[0]
    else:
        cursor_dimensional.execute("INSERT INTO Dim_Data (mes, ano) VALUES (%s, %s)", (mes, ano))
        conn_dimensional.commit()
        idData = cursor_dimensional.lastrowid


    # --- Fato_Assinatura (verifica se já existe antes de inserir) ---
    cursor_dimensional.execute("""
        SELECT qtd_novos_assinantes FROM Fato_Assinatura
        WHERE Dim_Localizacao_idLocalizacao = %s
          AND Dim_DataAssinatura_idDim_Data = %s
          AND Dim_Usuario_idUsuario = %s
    """, (idLocalizacao, idData, idUsuario))
    row = cursor_dimensional.fetchone()

    if row:
        # Ja existe um fato com esses dados
        cursor_dimensional.execute("""
            UPDATE Fato_Assinatura
            SET qtd_novos_assinantes = %s
            WHERE Dim_Localizacao_idLocalizacao = %s
              AND Dim_DataAssinatura_idDim_Data = %s
              AND Dim_Usuario_idUsuario = %s
        """, (1, idLocalizacao, idData, idUsuario))
    else:
        # Registro não existe, insere novo
        cursor_dimensional.execute("""
            INSERT INTO Fato_Assinatura (
                Dim_Localizacao_idLocalizacao,
                Dim_DataAssinatura_idDim_Data,
                Dim_Usuario_idUsuario,
                qtd_novos_assinantes    
            ) VALUES (%s, %s, %s, %s)
        """, (idLocalizacao, idData, idUsuario, 1))
    conn_dimensional.commit()