#!/bin/bash
# ------------------------------------------------------------------------------
# File       : 10gDB.sh
# Purpose    : Oracle administration helper: 10gDB.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./10gDB.sh
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

# Get Oracle Env 
. ~/scripts/10genv.sh


case "$1" in
   start)
      	exitcode='0'
	echo '10gR2, Starting Oracle Listener:'
	lsnrctl start
	echo '10gR2, Starting Oracle Database:'
	dbstart $ORACLE_HOME
	;;
stop)
	echo '10gR2, Stoping Oracle Listener:'
	lsnrctl stop
	echo '10gR2, Stoping Oracle Database:'
	dbshut $ORACLE_HOME
	;;
status)
	lsnrctl status
	;;
restart)
      "$0" stop && "$0" start
   	;;

*)
      echo "Usage: `basename "$0"` {start|stop|status|restart}"
      exit 1
esac
exit 0

