# ------------------------------------------------------------------------------
# File       : find_unique_date.sh
# Purpose    : Oracle administration helper: find unique date.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./find_unique_date.sh
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
find . -type f -printf '%TY-%Tm-%Td\n' | sort | uniq -c

find . -type f -printf '%TY-%Tm-%Td %TH\n'  | sort | uniq -c

find . -type f -mtime -1 -exec grep "CDM_PE" {} \; -printf '%TY-%Tm-%Td %TH\n'  | sort | uniq -c