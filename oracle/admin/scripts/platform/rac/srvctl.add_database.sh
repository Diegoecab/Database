# ------------------------------------------------------------------------------
# File       : srvctl.add_database.sh
# Purpose    : Oracle RAC or cluster administration helper: srvctl add database.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./srvctl.add_database.sh
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
srvctl add database -d ibscs -o /u01/app/oracle/product/12.1.0.2/dbhome_1 -p "/u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initibscs.ora" –r physical_standby -s mount

