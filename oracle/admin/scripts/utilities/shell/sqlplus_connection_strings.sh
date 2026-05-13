# ------------------------------------------------------------------------------
# File       : sqlplus_connection_strings.sh
# Purpose    : Oracle administration helper: sqlplus connection strings.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./sqlplus_connection_strings.sh
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
sqlplus "oraadmin@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCPS)(HOST = diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com) (PORT = 2484))(CONNECT_DATA = (SID = ORCL)))"
sqlplus "oraadmin@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCPS)(Host=diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com)(Port=2484))(CONNECT_DATA=(SERVICE_NAME=ORCL))(security=(my_wallet_directory=C:\app\client\diegoec\product\19.0.0\client_1\network\admin\wallet)))"
