# ------------------------------------------------------------------------------
# File       : python_connect.sh
# Purpose    : Oracle administration helper: python connect.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./python_connect.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
#/usr/bin pyhton3
import cx_Oracle

connection = cx_Oracle.connect(user="${ORACLE_USER}", password="${ORACLE_PASSWORD}",
                               dsn="${ORACLE_DSN}",
                               encoding="UTF-8")

connection2 = cx_Oracle.connect(user="${ORACLE_USER}", password="${ORACLE_PASSWORD}",
                               dsn="${ORACLE_DSN}",
                               encoding="UTF-8")

connection3 = cx_Oracle.connect(user="${ORACLE_USER}", password="${ORACLE_PASSWORD}",
                               dsn="${ORACLE_DSN}",
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
