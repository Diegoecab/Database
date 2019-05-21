#!/bin/bash

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

