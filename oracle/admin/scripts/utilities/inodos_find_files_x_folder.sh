# ------------------------------------------------------------------------------
# File       : inodos_find_files_x_folder.sh
# Purpose    : Oracle administration helper: inodos find files x folder.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./inodos_find_files_x_folder.sh
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
find . -xdev -printf '%h\n' | sort | uniq -c | sort -k 1 -n;