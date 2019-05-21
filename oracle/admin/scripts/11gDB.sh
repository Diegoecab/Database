#!/bin/bash

# Get Oracle Env 
. ~/scripts/11genv.sh


case "$1" in
   start)
      	exitcode='0'
	echo '11gR2, Starting Oracle Listener:'
	lsnrctl start
	echo '11gR2, Starting Oracle Database:'
	dbstart $ORACLE_HOME
	;;
stop)
	echo '11gR2, Stoping Oracle Listener:'
	lsnrctl stop
	echo '11gR2, Stoping Oracle Database:'
	dbshut $ORACLE_HOME
	;;
status)
	lsnrctl status
restart)
      "$0" stop && "$0" start
   	;;

*)
      echo "Usage: `basename "$0"` {start|stop|status|restart}"
      exit 1
esac
exit 0

