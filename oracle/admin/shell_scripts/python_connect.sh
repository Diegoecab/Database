#/usr/bin pyhton3
import cx_Oracle

connection = cx_Oracle.connect(user="oraadmin", password="oraadmin",
                               dsn="diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com/ORCL_A:pooled",
                               encoding="UTF-8")

connection2 = cx_Oracle.connect(user="oraadmin", password="oraadmin",
                               dsn="diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com/ORCL_A:pooled",
                               encoding="UTF-8")

connection3 = cx_Oracle.connect(user="oraadmin", password="oraadmin",
                               dsn="diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com/ORCL_A:pooled",
                               encoding="UTF-8")
							   
cursor=connection.cursor();
cursor2=connection2.cursor();
cursor3=connection3.cursor();

cursor.execute ("select sysdate from dual")
for fetchCursor in cursor:
	print(fetchCursor[0])


cursor2.execute ("select sysdate from dual")
for fetchCursor in cursor2:
	print(fetchCursor[0])


cursor3.execute ("select sysdate from dual")
for fetchCursor in cursor3:
	print(fetchCursor[0])

input("Enter your value: ")

