# ------------------------------------------------------------------------------
# File       : jar_jdbc_tester.sh
# Purpose    : Oracle administration helper: jar jdbc tester.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./jar_jdbc_tester.sh
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
[root@sarp1ae1zonl-zonda0-022 ~]# java -jar jdbc-tester-1.1.jar srvcengineerlake PASSWORD jdbc:oracle:thin:@DBEXAP01-scan.ar.bsch:7365/RIO35_APPS