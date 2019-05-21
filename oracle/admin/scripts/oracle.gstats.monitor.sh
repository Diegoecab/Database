#!/sbin/sh
#################################################################################
# AUTHOR : DIEGO E CABRERA                                                      #
# CREATED: 23/05/2012                                                           #
# PROGRAM: oracle.gstats.monitor.sh                                             #
# PURPOSE: Global Daily Stats Monitor                                           #
# USAGE  : oracle.gstats.monitor.sh SID                                         #
#                                                                               #
# Date        Updated by           Description                                  #
# ----------- -------------------- ------------------------------------------- 	#
#                                                                              	#
# ---------------------------------------------------------------------------- 	#
#################################################################################

#------------------------------------------------------------------------------#
# fn_rpt(): Report
#------------------------------------------------------------------------------#
fn_rpt()
{

  typeset db_sid=${1}
  ORAUSER='/'
  
  #typeset sql="set feed off
   #            set head off
   #            set linesize 100
    #           set serveroutput on
    #           alter session set current_schema=dbadmin;
	#		   select rpad('OWNER',15,'#')||'#'||rpad('CNT',8,'#') from dual;
    #           select rpad(owner,15,'#')||'#'||rpad(count(*),8,'#') from dba_tables where owner like '%SYS%' group by owner;
     #          "	
	 
  typeset sql="set feed off
               set head on
			   set pages 10000
			   alter session set current_schema=dbadmin;
			   alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
			   set markup html on spool on preformat off entmap on
			   spool ${LOG}/gstats.log
			   
			   select   id_job,
         to_char (min (fh_start), 'DY')||' '||min (fh_start) fh_start,
         to_char (max (fh_end), 'DY')||' '||max (fh_end) fh_end,
         round((max (fh_end)-min (fh_start)) *24,1) runtime_hs,
         (select   rows_processed from stat_running_logs where step_detail = 'Calculation finished.' and id_job = a.id_job) cnt_to_exec,
         count ( * ) cnt_executed,  
         round(count ( * ) * 100/(select decode(rows_processed,0,1,rows_processed) from   stat_running_logs where   step_detail = 'Calculation finished.' and id_job = a.id_job)) pct_exec,
         (select count(*) from stat_running_logs x where owner_name is not null and step_status='ERR' and id_job=a.id_job) cnt_err,
         round((select decode(count(*),0,1,count(*)) from stat_running_logs x where owner_name is not null and step_status='ERR' and id_job=a.id_job)*100/(select decode(rows_processed,0,1,rows_processed) from   stat_running_logs where   step_detail = 'Calculation finished.' and id_job = a.id_job)) pct_err
         from   stat_running_logs a
         where   owner_name is not null
         group by   id_job
         having min(fh_start) > trunc(sysdate-3)
         order by   id_job desc;
		 
		break on id_job skip 1
		compute sum of diff_hours on id_job
		compute sum of cnt on id_job
		compute sum of cnt_err on id_job
		
		
		select id_job,min(fh_start) fh_start,max(fh_end) fh_end,owner_name,round(sum((FH_END-FH_START) *24*60)) diff_mins,round(sum((fh_end-fh_start) *24)) diff_hours,
		count(*) cnt, (select count(*) from  dbadmin.stat_running_logs where id_job=a.id_job and owner_name=a.owner_name and step_status = 'ERR') cnt_err 
		 from dbadmin.stat_running_logs a
		where   owner_name is not null
		group by id_job,owner_name
		having min(fh_start) > trunc(sysdate-3)
		order by id_job desc,diff_mins desc;
			   spool off
			   "
  typeset sql_out=$(fn_run_sql "${sql}")

  if [ -n "${sql_out}" ]; then 
     typeset ttitle="${db_sid}: Global Stats Report"
     typeset ttbody="$(echo "${sql_out}"  | sed 's/#/ /g')"

	 (
 echo "to:${addr}"
 echo "Subject: ${ttitle}"
 echo "MIME-Version: 1.0"
 echo "Content-Type: text/html"
 echo "Content-Disposition: inline"
 cat ${LOG}/gstats.log
) | /usr/sbin/sendmail -f "control" "${addr}"
  fi

}

#------------------------------------------------------------------------------#
# fn_chk_parm(): Check for input parameters
#------------------------------------------------------------------------------#
fn_chk_parm() {
if [ ${NARG} -ne 1 ]; then
    echo "[ ERROR ] Not enough parameters. Database Sid or Service name required"
    fn_log "main" "3" "Not enough parameters. Database Sid or Service name required"
    exit 2;
fi
}


#------------------------------------------------------------------------------#
# fn_mail(): mail
#------------------------------------------------------------------------------#
fn_mail() {

MAIL_DBAS=
MAIL_PS=
MAIL_TO=

echo "$MAIL_MSG" |mailx -s "$AMBIENTE - $ORACLE_SID - RMAN - $TIPO" $MAIL_TO

}


#------------------------------------------------------------------------------#
# fn_log(): log
#------------------------------------------------------------------------------#
fn_log()
{
# PARAMETERS: $1: Function name 
#             $2: Error code
#             $3: Log message 
  
  if [ ${#} -lt 3  ]; then
     echo "Not enough parameters"
     return 1;
  fi;
  
 dia=`date "+%d"`
 mes=`date "+%m"`
 anio=`date "+%C%y"`
 hora=`date "+%H:%M"`

 typeset FUN_NAME="${1}";
 typeset ERR_NUM="${2}";
 typeset LOG_STR="${3}";
 typeset MSG_LOG="${anio}/${mes}/${dia} ${hora} (${FUN_NAME}) Error Code: (${ERR_NUM}): ${LOG_STR}"
 perl -e '

  use Time::Local;

  $str_line = $ARGV[1];
  $logfile = $ARGV[0];


  open(LOGFH, ">>$logfile") || die "Opening $logfile: $!";
  print LOGFH "$str_line\n";
  close(LOGFH);

  ' "${LOGFILE}" "${MSG_LOG}"

 return 0;
}



#################################################################################
#                                     Main                                      #
#################################################################################

(
PROGRAM=${0}
PARAMETERS=${*}
                                  
APPL_PATH=/fintech/dbatools                                         # Standard path for all custom DBA scripts, binaries and logs
BIN=${APPL_PATH}/bin                                                # Path for all custom DBA binaries
LIB=${APPL_PATH}/lib                                                # Path for all custom DBA libraries
SCRIPT=${APPL_PATH}/script                                          # Path for all custom DBA scripts
CONFIG=${APPL_PATH}/config                                          # Path for all custom DBA configuration files
LOG=${APPL_PATH}/log                                                # Standard path for output logs, error logs and temporary files
ARCHIVE=${APPL_PATH}/archive                                        # Standard path to keep log's history

SCRIPT_NAME=`basename ${PROGRAM} | sed s/".sh"/""/g`                # Define script name removing it's extension
DEFAULT_OUTPUT_LOG=${LOG}/${SCRIPT_NAME}.log                        # Define standart output log for this script
DEFAULT_ERROR_LOG=${LOG}/${SCRIPT_NAME}.err                         # Define standart error log for this script
SCRIPT_LOGS="${DEFAULT_OUTPUT_LOG} ${DEFAULT_ERROR_LOG}"            # List of logs used by this script

addr='dl.fincon.latam.tech.db.automsgs@imcnam.ssmb.com'				# Recipient Email

NARG=$#
day=`date "+%d"`
month=`date "+%m"`
year=`date "+%C%y"`
hour=`date "+%H%M"`

fn_chk_parm                                                         # Check Count Param
export ORACLE_SID=${1}                                              # Oracle Sid


LOGFILE=${LOG}/gstats_${ORACLE_SID}.$year$month$day.log


profile_script=${LIB}/shellscript.profile                           # Load common variables to all scripts
if [ -x ${profile_script} ]
then
        . ${profile_script}
else
	(
	echo "Global Profile Script was not found. Execution Aborted."
	) >> ${DEFAULT_ERROR_LOG} 2>&1
	exit 1;
fi


functions_script=${LIB}/shellscript.functions                       # Load common functions
if [ -x ${functions_script} ]; then
  . ${functions_script}
else
  fn_log "main" "3" "Global Functions Script was not found. Execution Aborted."
  exit 1;
fi;

################################################################################ 
#                            Check database status                             #
################################################################################
typeset -i instance_status=$(ps -fea | grep -v grep |grep pmon_${ORACLE_SID} | wc -l)
if [ ${instance_status} -eq 0 ]; then
    fn_log "main" "3" "Database ${ORACLE_SID} is down"
 	  exit 1;
fi;

################################################################################ 
#               Set environment variables for the selected database            #
################################################################################
. ${LIB}/shellscript.oracle.environment ${ORACLE_SID}

################################################################################ 
#                            Core Application	                               #
################################################################################

fn_log "main" "3" "Begin Script"

fn_rpt ${ORACLE_SID}

fn_log "main" "3" "End Script"

################################################################################
) 2>> ${DEFAULT_ERROR_LOG}