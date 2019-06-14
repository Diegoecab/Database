#!/usr/bin/sh
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
 fn_log "fn_backup" "1" "Not enough parameters"
 return 1;
fi;

typeset VERSION_ID_NAME="${1}";
fn_log "fn_backup" "0" "Starting backup for version ID $VERSION_ID_NAME"

exit_string=`$ORACLE_HOME/bin/expdp  ${ORAUSER} dumpfile=exp_$VERSION_ID_NAME.dmp compression=all logfile=$EXPDP_DIR:exp_$DT_$VERSION_ID_NAME.log directory=$EXPDP_DIR content=METADATA_ONLY schemas=$SCHEMAS`

if [ $(echo "${exit_string}" | grep -c 'ORA-') -gt 0 ] || [ $(echo "${exit_string}" | echo ${exit_string} | grep -Ec 'SP2-[0-9]+[0-9]+[0-9]+[0-9]+') -gt 0 ]; then
     fn_log "fn_backup" "1" "Error in datapump export";
	 fn_log "fn_backup" "1" "Datapump logfile: $EXPDP_DIR:exp_$DT_$VERSION_ID_NAME.log"
fi
}


#------------------------------------------------------------------------------#
# fn_file_management(): This function will extract a gz file and find the folders with the pattern specified in the $VERSIONID_PATTERN variable#						
#------------------------------------------------------------------------------#


fn_file_management()
{
# PARAMETERS: $1: package name.gz
  
if [ ${#} -lt 1  ]; then
 echo "Not enough parameters"
 return 1;
fi;

typeset ZIPPED_FILE="${1}";
ZIPPED_FILE_NAME=`${ZIPPED_FILE} | sed s/".gz"/""/g`  

fn_log "fn_file_management" "0" "Decompressing file $ZIPPED_FILE"
gunzip $ZIPPED_FILE
ex_code=$?
if [ $ex_code -gt 0 ] ; then
	fn_log "fn_file_management" "1" "Error executing gunzip $ZIPPED_FILE. Exit code: $ex_code";
else
fn_log "fn_file_management" "0" "File $ZIPPED_FILE decompressed successfully"
all_files=`ls -larRt $ZIPPED_FILE_NAME`
fn_log "fn_file_management" "0" "Decompressed files; "
fn_log "fn_file_management" "0" "$all_files"
fi

VERSIONS_TB_IMPLEMENTED=$(find . -type d 2>/dev/null | grep -P $VERSIONID_PATTERN*)
export VERSIONS_TB_IMPLEMENTED

if [ -z "$VERSIONS_TB_IMPLEMENTED" ]; then
	fn_log "fn_file_management" "1" "There is no folder with version ID in the compressed file";
else
fn_log "fn_file_management" "0" "Versions to be implemented: $VERSIONS_TB_IMPLEMENTED"
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
APPL_CFG_DIR=$APPL_PATH/cfg
SCRIPT_NAME=`basename ${PROGRAM} | sed s/".sh"/""/g`               						# Define script name removing it's extension
DEFAULT_ERROR_LOG=${APPL_LOG}/${SCRIPT_NAME}.err                         				# Define standart error log for this script
DEFAULT_LOG=${APPL_LOG}/${SCRIPT_NAME}.log                         				# Define standart output log for this script

cfg_file=${APPL_CFG_DIR}/oracle.db.deploy.cfg                           	# Load config variables
if [ -x ${cfg_file} ]
then
        . ${cfg_file}
else
	(
	echo "The Configuration file was not found. Execution Aborted."
	) >> ${DEFAULT_ERROR_LOG} 2>&1
	exit 1;
fi

################################################################################ 
#                            Core Application	                               #
################################################################################

fn_log "main" "0" "Begin Script"
fn_file_management()

select VERSIONID_FOLDER in "${VERSIONS_TB_IMPLEMENTED[@]}"
do
    if ! [ "$VERSIONID_FOLDER" ]
    then
        echo "No folder was specified"
        continue
    else
    	echo "Starting backup before apply the version $VERSIONID"
   		LOG_DIR=$LOG_DIR/$VERSIONID
		LOGFILE=${LOG_DIR}/oracle.db.deploy.$DT.log
		fn_backup()
		fn_deploy()
		fn_notification()
	fi
    break
done


fn_log "main" "0" "End Script"

################################################################################
) 2>> ${DEFAULT_ERROR_LOG}


