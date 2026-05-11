# ------------------------------------------------------------------------------
# File       : ejecutaBKPDatafile.sh
# Purpose    : Oracle RMAN backup, restore or recovery helper: ejecutaBKPDatafile.
# Category   : backup_recovery/rman
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./ejecutaBKPDatafile.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
set oracle_sid=dtest
del c:\oracle\disco2\rman_logs\rman_log.log
rman target / @C:\rman\backdatafile3.sql
sqlplus "/ as sysdba" @c:\rman\ejecuta_mail.sql