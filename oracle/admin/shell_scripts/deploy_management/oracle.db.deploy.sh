#!/usr/bin/sh
#/sbin/sh
#################################################################################
# AUTHOR : DIEGO E CABRERA                                                      #
# CREATED: 14/06/2019                                                           #
# PROGRAM: oracle.db.deploy.sh			                                        #
# PURPOSE: Deploy database scripts reliably                                     #
# USAGE  : . oracle.db.deploy.sh <package_name>.gz                              #
# 										                                        #
# Date        	Updated by           Description                                #
# ----------- 	-------------------- -------------------------------------------#
# 																				#
# ---------------------------------------------------------------------------- 	#
#################################################################################

#------------------------------------------------------------------------------#
# fn_backup(): Execute a metadata backup with Oracle datapump export		   #						
#------------------------------------------------------------------------------#

fn_backup()
{
# PARAMETERS: $1: Version ID
  
if [ ${#} -lt 1  ]; then
 echo "Not enough parameters"
 return 1;
fi;

typeset VERSION_ID_NAME="${1}";

exit_string=`$ORACLE_HOME/bin/expdp  ${ORAUSER} dumpfile=exp_$VERSION_ID_NAME.dmp compression=all logfile=exp_$VERSION_ID_NAME.log directory=$EXPDP_DIR content=METADATA_ONLY schemas=$SCHEMAS`

if [ $(echo "${exit_string}" | grep -c 'ORA-') -gt 0 ] || [ $(echo "${exit_string}" | echo ${exit_string} | grep -Ec 'SP2-[0-9]+[0-9]+[0-9]+[0-9]+') -gt 0 ]; then
     fn_log "main" "1" "Error - fn_run";
	 fn_log "main" "1" "Error: ${exit_string}" ;
 fi
}


fn_file_management()
{
# PARAMETERS: $1: package name.zip
  
if [ ${#} -lt 1  ]; then
 echo "Not enough parameters"
 return 1;
fi;

typeset ZIPPED_FILE="${1}";
ZIPPED_FILE_NAME=`${ZIPPED_FILE} | sed s/".gz"/""/g`  

fn_log "main" "0" "Decompressing file $ZIPPED_FILE"
gunzip $ZIPPED_FILE
ex_code=$?
if [ $ex_code -gt 0 ] ; then
	fn_log "main" "1" "Error executing gunzip $ZIPPED_FILE. Exit code: $ex_code";
else
fn_log "main" "0" "File $ZIPPED_FILE decompressed successfully"
all_files=`ls -larRt $ZIPPED_FILE_NAME`
fn_log "main" "0" "Decompressed files; "
fn_log "main" "0" "$all_files"
fi

if [ $(echo "${exit_string}" | grep -c 'ORA-') -gt 0 ] || [ $(echo "${exit_string}" | echo ${exit_string} | grep -Ec 'SP2-[0-9]+[0-9]+[0-9]+[0-9]+') -gt 0 ]; then
     fn_log "main" "1" "Error - fn_run";
	 fn_log "main" "1" "Error: ${exit_string}" ;
 fi
}


#------------------------------------------------------------------------------#
# fn_log(): log writter
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
if [ ${#} -lt 1  ]; then
     echo "Not enough parameters."
	 echo "USAGE  : . oracle.db.deploy.sh <package_name>.gz"
     return 1;
fi;
APPL_PATH=/oracle/scripts/
APPL_LOG=$APPL_PATH/logs
SCRIPT_NAME=`basename ${PROGRAM} | sed s/".sh"/""/g`               						# Define script name removing it's extension
DEFAULT_ERROR_LOG=${APPL_LOG}/${SCRIPT_NAME}.err                         				# Define standart error log for this script
DEFAULT_LOG=${APPL_LOG}/${SCRIPT_NAME}.log                         				# Define standart output log for this script

################################################################################ 
#                            Core Application	                               #
################################################################################

fn_log "main" "0" "Begin Script"
fn_file_management()
fn_backup()
fn_deploy()
fn_notification()
fn_log "main" "0" "End Script"

################################################################################
) 2>> ${DEFAULT_ERROR_LOG}


