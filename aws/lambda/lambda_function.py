import sys
import logging
import psycopg2
import json
import os
from datetime import datetime

# rds settings
username = os.environ['USER_NAME']
password = os.environ['PASSWORD']
host = os.environ['HOST']
db_name = os.environ['DB_NAME']

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler():
    try:
      connection = psycopg2.connect(user=username, password=password, host=host, database=db_name)
      cursor = connection.cursor()
      sql = "INSERT INTO deliverables VALUES(1)"
      logger.info("SUCCESS: Connection to Aurora Cluster Serverless succeeded")
      print("SUCCESS: Connection to Aurora Cluster Serverless succeeded")

      cursor.execute(sql)
      logger.info(datetime.now())
      print(datetime.now())
      connection.commit()
      cursor.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


lambda_handler()

