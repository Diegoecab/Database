# ------------------------------------------------------------------------------
# File       : list_backup.sh
# Purpose    : OCI Oracle administration helper: list backup.
# Category   : cloud/oci
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./list_backup.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
/var/opt/oracle/bkup_api/bkup_api list jobs --dbname crgbitdp  | grep -i create  | tail -10