#!/sbin/sh
################################################################################
# AUTHOR : Diego Cabrera						       						   #
# CREATED: 01/10/2010                                                          #
# PROGRAM: broker_check.sh                                                     #
# USAGE  : rman_backup SID [WEEKLY|DAILY|EMERGENCY] [ARCH|NOARCH]              #
################################################################################

export ORACLE_HOME=/u01/oracle/product/db10gr2
export ORACLE_SID=GARDBOP
result=`echo "show configuration;" | \
  $ORACLE_HOME/bin/dgmgrl dbas/dbas | \
  grep -v "Current status for"`
if [ "$result" = "SUCCESS" ] ; then
    exit 0
else
    echo "Error"
fi