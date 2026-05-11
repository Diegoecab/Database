# ------------------------------------------------------------------------------
# File       : curl_mos.sh
# Purpose    : Oracle administration helper: curl mos.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./curl_mos.sh
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

for i in `ls`; do echo "uploading file $i"; curl -T $i -u user@oracle.com:testssPassw# https://transport.oracle.com/upload/issue/3-23925640933/ ; done;

for i in `ls dblxoperdesa07*.zip`; do echo "uploading file $i"; curl -T $i -u usuario:password# https://transport.oracle.com/upload/issue/3-25852358301/ ; done;
