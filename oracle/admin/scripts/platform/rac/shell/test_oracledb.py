# ------------------------------------------------------------------------------
# File       : test_oracledb.py
# Purpose    : Oracle RAC or cluster administration helper: test oracledb.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : python3 test_oracledb.py
# Parameters : Review script arguments and environment variables before running.
# Requires   : Python runtime and required Oracle/client libraries.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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
