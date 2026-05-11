#!/bin/ksh
#
# File name:   remove_applied_archivelog.sh
# Purpose:     This script will remove the applied archivelogs into a standby databases.
#                          Optionally you can keep N days of those files into the FS or FRA area
# Author:      Diego Cabrera
# Usage:       remove_applied_archivelog.sh ORACLE_SID <LAST_N_DAYS>
#

ORACLE_SID=$1; export ORACLE_SID
LAST_DAYS=$2; export LAST_DAYS
NOTIF_ERROR=true; #true/false
export ORACLE_SID

tmpfile=/tmp/arch_id$ORACLE_SID.tmp

exec_delete_fnc() {
$ORACLE_HOME/bin/sqlplus -S /nolog <<EOF > $tmpfile
connect / as sysdba
set head off
set pages 0
select max(sequence#) from v\$archived_log where applied = 'YES' $LAST_DAYS_QUERY;
exit
EOF
SEQ=`head -n 1  $tmpfile | awk '{print $1}'`
echo "Deleting archivelog until sequence $SEQ"

echo DELETE NOPROMPT ARCHIVELOG UNTIL SEQUENCE = $SEQ ';' > $tmpfile

$ORACLE_HOME/bin/rman target / <<EOF
crosscheck archivelog all;
 @$tmpfile
exit
EOF
}

val_variables() {
if [ -z "$ORACLE_SID" ];
then
 echo "ORACLE_SID cant be empty";
 exit;
else
 ORACLE_HOME=`cat /etc/oratab|grep -v "^#"|grep $ORACLE_SID|cut -f2 -d: -s`
 export ORACLE_HOME
 if [ -z "$ORACLE_HOME" ];
 then
  echo "ORACLE_HOME not found in /etc/oratab";
 exit;
 fi
 LD_LIBRARY_PATH=$ORACLE_HOME/lib
fi

if [ ! -z "$LAST_DAYS" ];
then
 if [ "$LAST_DAYS" -ge 0 ] 2>/dev/null
 then
  LAST_DAYS_QUERY=" and first_time <= sysdate - $LAST_DAYS";
 else
  echo "Second parameter (number of days to keep) must be integer or null"
  exit
 fi
else
 LAST_DAYS_QUERY="";
fi
export LAST_DAYS_QUERY;
}

val_variables
exec_delete_fnc
