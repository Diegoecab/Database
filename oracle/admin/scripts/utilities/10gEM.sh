#!/bin/bash
# ------------------------------------------------------------------------------
# File       : 10gEM.sh
# Purpose    : Oracle administration helper: 10gEM.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./10gEM.sh
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

. ~/scripts/10genv.sh

export ORACLE_SID=$2

echo "Using ORACLE_SID="$ORACLE_SID 

case "$1" in
   start)
      	exitcode='0'
	echo '10gR2, Starting Oracle EM DB Control:'
	emctl start dbconsole
	;;
stop)
	echo '10gR2, Stoping Oracle EM DB Control:'
	emctl stop dbconsole
	;;
status)
        emctl status dbconsole
        ;;

restart)
      "$0" stop && "$0" start
   	;;

*)
      echo "Usage: `basename "$0"` {start|stop|status|restart} ORACLE_SID"
      exit 1
esac
exit 0

