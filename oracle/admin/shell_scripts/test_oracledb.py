import getpass
import oracledb

oracledb.init_oracle_client(config_dir="wallet")

un = 'oraadmin'
cs = """(DESCRIPTION=(ADDRESS=(PROTOCOL=TCPS)(Host=diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com)(Port=2484))(CONNECT_DATA=(SERVICE_NAME=ORCL)))"""
pw = 'oraadmin'

with oracledb.connect(user=un, password=pw, dsn=cs) as connection:
    with connection.cursor() as cursor:
        sql = """select sysdate from dual"""
        for r in cursor.execute(sql):
            print(r)
