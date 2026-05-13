# ------------------------------------------------------------------------------
# File       : impdp_sqlfile.sh
# Purpose    : Oracle administration helper: impdp sqlfile.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./impdp_sqlfile.sh
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
$ORACLE_HOME/bin/impdp \'/ as sysdba\' \
DIRECTORY=ibsclr \
dumpfile=EXPREC_BD_CHILE_210120_%U.dmp \
CONTENT=METADATA_ONLY \
INCLUDE="INDEX" \
sqlfile=create_indexes.sql
