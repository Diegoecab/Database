# ------------------------------------------------------------------------------
# File       : ejecutaBKPFull.sh
# Purpose    : Oracle RMAN backup, restore or recovery helper: ejecutaBKPFull.
# Category   : backup_recovery/rman
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./ejecutaBKPFull.sh
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
export ORACLE_SID=GEMPROD;
rm /gemini/DbBackup/GEMPROD/rman/logs/rman_log.log
rman target / @/home/oragemprod/scripts_rman/full.sql
