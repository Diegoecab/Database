# ------------------------------------------------------------------------------
# File       : full.sh
# Purpose    : Oracle administration helper: full (1).
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./full (1).sh
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
sqlplus / as sysdba << EOF
alter system flush buffer_cache;
exit;
EOF
sqlplus /nolog @full.sql &
sqlplus /nolog @full.sql &
sqlplus /nolog @full.sql &
sqlplus /nolog @full.sql &