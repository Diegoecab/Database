# ------------------------------------------------------------------------------
# File       : sar_p_awk.sh
# Purpose    : Oracle administration helper: sar p awk.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./sar_p_awk.sh
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
sar -p -d 15 4320
tail -f sar_p_d_18H.txt | awk '{ if ($11 > 80.00) { print } }'