# ------------------------------------------------------------------------------
# File       : rman_recover_from_service.sh
# Purpose    : Oracle RMAN backup, restore or recovery helper: rman recover from service.
# Category   : backup_recovery/rman
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rman_recover_from_service.sh
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
recover database from service CDB196 noredo using compressed backupset;
srvctl stop database -d PDCP
srvctl start database -d PDCP -o nomount

rman target /
restore standby controlfile from service CDB196;
sql 'alter database mount';
Catalog start with '+PDCP_DATA';
Catalog start with '+PDCP_FRA';
-- Fixes the location
SWITCH DATABASE TO COPY;