#!/usr/bin/bash
# ------------------------------------------------------------------------------
# File       : oratab_exec_script.sh
# Purpose    : Oracle administration helper: oratab exec script.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./oratab_exec_script.sh
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

 
ORATAB=/etc/oratab
echo "INSTANCE_NAME, FILE_NAME"
 
# Step through running instances
ps -ef | grep ora_smon_ | grep -v grep | cut -b60-70 | while read LINE
do
    # Assign the ORACLE_SID
    ORACLE_SID=$LINE
    export ORACLE_SID
 
    #Find ORACLE_HOME info for current instance
    ORATABLINE=`grep $LINE $ORATAB`
    ORACLE_HOME=`echo $ORATABLINE | cut -f2 -d:`
    export ORACLE_HOME
    LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
    export LD_LIBRARY_PATH
 
    # Put $ORACLE_HOME/bin into PATH and export.
    PATH=$ORACLE_HOME/bin:/bin:/usr/bin:/etc ; export PATH
 
	printf '\n'
	echo "*****************************"
	echo "Executing script in Instance:" $ORACLE_SID
    # Executing script
    sqlplus -s "/ as sysdba" <<EOF
    SET HEADING OFF
    SET FEEDBACK OFF
    SET LINESIZE 3800
    SET TRIMSPOOL ON
    SET TERMOUT OFF
    SET SPACE 0
    SET PAGESIZE 0
    show parameter Db_create_online_log_dest_
	select group#, thread#, sequence#, archived, ROUND (BYTES / 1024 / 1024) mb, status from v\$standby_log;
	col member for a100
set pages 50
set lines 300
select * from v$logfile
order by group#;
	archive log list
EOF
	echo "*****************************"
 
done