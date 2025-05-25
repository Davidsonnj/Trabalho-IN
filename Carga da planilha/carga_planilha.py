from dotenv import load_dotenv
import pandas as pd
import pymysql
import os

load_dotenv()

conexao = pymysql.connect(
    host=os.getenv('HOST_DIMENSIONAL'),
    port=int(os.getenv('PORT_DIMENSIONAL')),
    user=os.getenv('USER_DIMENSIONAL'),
    password=os.getenv('PASSWORD_DIMENSIONAL'),
    database=os.getenv('DATABASE_DIMENSIONAL')
)

cursor = conexao.cursor()

arquivo_excel = 'Ch3-SampleDateDim.xls'

tabela_datas = pd.read_excel(arquivo_excel)

for _, linha in tabela_datas.iterrows():
    dia = linha['day num in month']
    mes = linha['month']
    ano = linha['year']

    cursor.execute(
        "INSERT INTO Dim_Data (mes, ano, dia) VALUES (%s, %s, %s)",
        (mes, ano, dia)
    )
conexao.commit()
