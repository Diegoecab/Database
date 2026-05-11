# ------------------------------------------------------------------------------
# File       : audit_cp_files.sh
# Purpose    : Oracle security, audit, user, role or grants helper: audit cp files(1).
# Category   : security
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./audit_cp_files(1).sh
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
ls -lart >>  /tmp/lstxt
for p in $(cat /tmp/lstxt | grep "Feb  5 " | awk '{print $9}' | grep .aud); do cp $p ./feb5/.; done;
grep "ACTION:\[3\] \"102\"" -B3 * | grep APP_BACO_BIPLUS_ADMIN -B3 | grep "Feb  5"
