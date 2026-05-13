# ------------------------------------------------------------------------------
# File       : grep_recover_until_change_alert.sh
# Purpose    : Oracle administration helper: grep recover until change alert.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./grep_recover_until_change_alert.sh
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
grep -E "Completed:.* until change" /u01/app/oracle/diag/rdbms/ibscn/ibscn2/trace/alert_ibscn2.log -A1 | grep -v Completed | awk '{print $2" " $3" " $4}'

grep -P '^(?=.*RFS)(?=.*18023)' alert_ibscn2.log