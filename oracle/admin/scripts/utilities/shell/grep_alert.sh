# ------------------------------------------------------------------------------
# File       : grep_alert.sh
# Purpose    : Oracle administration helper: grep alert.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./grep_alert.sh
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
grep -Ri "Archived Log entry " -B1 --no-file|grep 2023-10-24 |sed 's/2023-10-24T//g' | uniq -w2 -c
grep "Media Recovery Log" * -B1 --no-file | grep 2023-10-24|sed 's/2023-10-24T//g' | uniq -w5 -c
