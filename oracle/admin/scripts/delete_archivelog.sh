#!/bin/bash
#
# delete_archivelog.sh
#
# Author: Diego Cabrera
#
# Ejecuta delete archivelog en bases de desarrollo
#


BASEDIR=$(dirname $0)												# Script location
LOG=${BASEDIR}/../logs                                              # Standard path for output logs, error logs and temporary files
PROGRAM=${0}														# Script name
SCRIPT_NAME=`basename ${PROGRAM} | sed s/".sh"/""/g`                # Define script name removing it's extension
export dbs=$1
DEFAULT_OUTPUT_LOG=${LOG}/${SCRIPT_NAME}_${dbs}.log                        # Define standart output log for this script

function get_dbs
{
  if [ -z "${1}" ]; then
    export db_l=$(ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-")
  else
    export db_l=$(echo $1 | sed "s/,/ /g")
  fi
  echo $db_l
}

#export dbs=$(get_dbs)


echo -e "\n###############################################################################################################################" | tee $DEFAULT_OUTPUT_LOG
date | tee -a $DEFAULT_OUTPUT_LOG

for db in ${dbs}
do
PATH=/usr/lib/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/oracle/.local/bin:/home/oracle/bin:$PATH
export ORACLE_SID=$db
export ORAENV_ASK=NO
oratab_e=$(grep -w "$db:" /etc/oratab|grep -v "^#"|wc -l)
if [[ $oratab_e -eq 0 ]]; then
    echo "ERROR: $db not found in oratab" | tee -a $DEFAULT_OUTPUT_LOG
    continue;
fi

. /usr/local/bin/oraenv 1>/dev/null


echo "INFO: working with database $db" | tee -a $DEFAULT_OUTPUT_LOG

if [[ ! -f $ORACLE_HOME/bin/rman ]]; then
    echo "rman not found for database $db";
else
    $ORACLE_HOME/bin/rman target / <<! | tee -a $DEFAULT_OUTPUT_LOG
	sql 'alter system switch logfile';
	DELETE noprompt force archivelog until time = "sysdate-2/24";
exit;
!
fi
done

date | tee -a $DEFAULT_OUTPUT_LOG
echo -e "\n###############################################################################################################################" | tee -a $DEFAULT_OUTPUT_LOG


#BEGIN
#  DBMS_SCHEDULER.CREATE_JOB_CLASS (
#   job_class_name              =>  'fdb_maintenance',
#   comments                    =>  'FDB  - Tareas de mantenimiento en AP');
#END;
#/


#BEGIN
#  DBMS_SCHEDULER.CREATE_JOB (
#   job_name           =>  'purge_arch_ap',
# 	job_type        => 'executable',
#   job_action      => '/oracle/scripts/sh/delete_archivelog.sh',
#   start_date         =>  systimestamp,
#   repeat_interval    =>  'FREQ=HOURLY', /* by hour */
#   end_date           =>  systimestamp + interval '30' year,
#   auto_drop          =>   FALSE,
#   job_class          =>  'fdb_maintenance',
#	enabled         => TRUE,
#   comments           =>  'FDB - Elimina archivelogs > 2 horas de antiguedad. Evitamos llenado de FRA en AP.');
#END;
#/
