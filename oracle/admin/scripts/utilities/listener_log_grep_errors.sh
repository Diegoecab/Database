# ------------------------------------------------------------------------------
# File       : listener_log_grep_errors.sh
# Purpose    : Oracle administration helper: listener log grep errors.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./listener_log_grep_errors.sh
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
#If you have successful connection then end of the line it will show “0” which means successful completion. 
#If you see any other number (Oracle error number from the TNS range >12000) that means the connection was not successful and you have to investigate then.
#Using the following command you can see those line that does not end with “0”
grep AUG listener.log| awk  '{ if ( $NF != 0 ) print $0 }'