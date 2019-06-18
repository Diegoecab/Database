#!/bin/bash
#################################################################################
# AUTHOR : DIEGO E CABRERA                                                      #
# CREATED: 14/06/2019                                                           #
# PROGRAM: oracle.db.deploy.sh			                                #
# PURPOSE: Deploy database scripts reliably                                     #
# USAGE  : . oracle.db.deploy.sh <package_name>.tar.gz                          #
# 									        #
# Date        	Updated by           Description                                #
# ----------- 	-------------------- -------------------------------------------#
# 										#							
# ---------------------------------------------------------------------------- 	#
#################################################################################

#------------------------------------------------------------------------------#
# fn_backup(): Execute a metadata backup with Oracle datapump export	       #						
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
fn_log "fn_backup" "0" "Starting backup for version ID $VERSION_ID_NAME. Please wait..."

#exit_string=`$ORACLE_HOME/bin/expdp  ${ORAUSER} dumpfile=exp_$VERSION_ID_NAME.dmp compression=all logfile=$EXPDP_DIR:exp_$DT_$VERSION_ID_NAME.log directory=$EXPDP_DIR content=METADATA_ONLY schemas=$SCHEMAS`
fn_log "fn_backup" "0" "$BACKUP_COMMAND"
$BACKUP_COMMAND >> $LOGFILE 2>&1 

ex_code=$?
if [ $ex_code -gt 0 ] ; then
 fn_log "fn_backup" "1" "Error in backup. Exit code is $ex_code";
 return 1 ;
fi

#if [ $(echo "${exit_string}" | grep -c 'ORA-') -gt 0 ] || [ $(echo "${exit_string}" | echo ${exit_string} | grep -Ec 'SP2-[0-9]+[0-9]+[0-9]+[0-9]+') -gt 0 ]; then
# fn_log "fn_backup" "1" "Error in backup";
# return 1 ;
#fi

fn_log "fn_backup" "0" "Done";
return 0 ;
}


fn_email()
{
content="$(cat - )"; 
  {
    echo "Subject: $1"
    echo "From: $FROM_NAME <$FROM_EMAIL>";
    echo "To: $TO_EMAIL";
    echo "$content"
  } | $(which sendmail) -F "$FROM_EMAIL" "$TO_EMAIL"
}

#------------------------------------------------------------------------------#
# fn_deploy(): Deploy sql scripts into the database               #
#------------------------------------------------------------------------------#

fn_deploy()
{
# PARAMETERS: $1: Version ID

if [ ${#} -lt 1  ]; then
 echo "Not enough parameters"
 fn_log "fn_deploy" "1" "Not enough parameters"
 return 1;
fi;
typeset SQL_SCRIPT="$1"

fn_log "fn_deploy" "0" "Starting deploy of $SQL_SCRIPT"

exit_string=`sqlplus -silent $ORAUSER <<EOF
@@$SQL_SCRIPT
EOF
`
fn_log "fn_deploy" "0" "Deploy output:"
fn_log "fn_deploy" "0" "$exit_string"

if [ $(echo "${exit_string}" | grep -c 'ORA-') -gt 0 ] || [ $(echo "${exit_string}" | echo ${exit_string} | grep -Ec 'SP2-[0-9]+[0-9]+[0-9]+[0-9]+') -gt 0 ]; then
 fn_log "fn_deploy" "1" "Error during the deploy";
 return 1 ;
fi

return 0 ;
}


ask() {
    # https://gist.github.com/davejamesmiller/1965569
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        #echo -n "$1 [$prompt] "
	# Redirect the prompt from stderr to stdout:
        read -p "$1 [$prompt] " reply 2>&1 </dev/tty 

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        # read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}
#------------------------------------------------------------------------------#
# fn_file_management(): This function will extract a gz file and find the folders with the pattern specified in the $VERSIONID_PATTERN variable#						
#------------------------------------------------------------------------------#


fn_file_management()
{
# PARAMETERS: $1: package name.gz
  
if [ ${#} -lt 1  ]; then
 fn_log "fn_file_management" "1" "Not enough parameters";
 return 1 ;
fi;

typeset ZIPPED_FILE="${1}";
ZIPPED_FILE_NAME=`${ZIPPED_FILE} | sed s/".gz"/""/g`  

fn_log "fn_file_management" "0" "Decompressing file $ZIPPED_FILE"
tar -xzf $ZIPPED_FILE
ex_code=$?
if [ $ex_code -gt 0 ] ; then
 fn_log "fn_file_management" "1" "Error executing gunzip $ZIPPED_FILE. Exit code: $ex_code";
 return 1 ;
else
 fn_log "fn_file_management" "0" "File $ZIPPED_FILE decompressed successfully"
 all_files=`ls -larRt $ZIPPED_FILE_NAME`
 fn_log "fn_file_management" "0" "Decompressed files; "
 fn_log "fn_file_management" "0" "$all_files"
fi

VERSIONS_TB_IMPLEMENTED=(`find . -type d 2>/dev/null -print | sort | grep -P $VERSIONID_PATTERN*`)
## declare an array variable
#declare -a VERSIONS_TB_IMPLEMENTED=$VERSIONS_TB_IMPLEMENTED
export VERSIONS_TB_IMPLEMENTED

if [ -z "$VERSIONS_TB_IMPLEMENTED" ]; then
 fn_log "fn_file_management" "1" "There is no folder with version ID in the compressed file";
 return 1 ;
else
len=${#VERSIONS_TB_IMPLEMENTED[*]}
fn_log "fn_file_management" "0" "found : ${len} Versions to be implemented"
fi

return 0 ;
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
 typeset MSG_LOG="${anio}/${mes}/${dia} ${hora} (${FUN_NAME}) Msg Code: (${ERR_NUM}): ${LOG_STR}"

if ! [ -d ${LOG_DIR} ] ; then
 mkdir -p $LOG_DIR
 if [[ $? -ne 0 ]] ; then
  date
  echo "Unable to create the logfile directory $LOG_DIR. Execution Aborted." | tee /dev/fd/3
  exit 1;
 fi
fi


if ! [ -x ${LOGFILE} ] ; then
 touch ${LOGFILE} 
 if [[ $? -ne 0 ]] ; then
  date
  echo "Unable to create the logfile $LOGFILE. Execution Aborted." | tee /dev/fd/3
  exit 1;
 fi
fi

 perl -e '

  use Time::Local;

  $str_line = $ARGV[1];
  $logfile = $ARGV[0];


  open(LOGFH, ">>$logfile") || die "Error trying to Open $logfile: $!";
  print LOGFH "$str_line\n";
  close(LOGFH);

  ' "${LOGFILE}" "${MSG_LOG}"
echo "${MSG_LOG}" 
 return 0;
}

#################################################################################
#                                     Main                                      #
#################################################################################
PROGRAM=${0}
PARAMETERS=${*}
if [ ${#} -lt 1  ]; then
 echo "Not enough parameters."
 echo "USAGE  : . oracle.db.deploy.sh <package_name>.gz"
 exit 1;
fi;
APPL_PATH=/oracle/scripts/
APPL_LOG=$APPL_PATH/logs
APPL_CFG_DIR=$APPL_PATH
SCRIPT_NAME=`basename ${PROGRAM} | sed s/".sh"/""/g`                                                            # Define script name removing it's extension
DEFAULT_ERROR_LOG=${APPL_LOG}/${SCRIPT_NAME}.err                                                        # Define standart error log for this script
DEFAULT_LOG=${APPL_LOG}/${SCRIPT_NAME}.log                                                      # Define standart output log for this script
PACKAGE_NAME=${1}

cfg_file=${APPL_CFG_DIR}/${SCRIPT_NAME}.cfg                                   # Load config variables

#exec 3>&1 1>>${DEFAULT_ERROR_LOG} 2>&1
exec 2>>${DEFAULT_ERROR_LOG}

if [ -x ${cfg_file} ]
then
 . ${cfg_file}
else
 date 
 echo "The Configuration file ${cfg_file} was not found. Execution Aborted." | tee /dev/fd/3
 exit 1;
fi

#(
################################################################################ 
#                            Core Application	                               #
################################################################################

fn_log "main" "0" "Begin Script. Executed by $CURRENT_USER"
fn_log "main" "0" "General logfile is ${DEFAULT_ERROR_LOG}"

if fn_file_management $PACKAGE_NAME; then
for VERSIONID_FOLDER in "${VERSIONS_TB_IMPLEMENTED[@]}"; do
if ! [ "$VERSIONID_FOLDER" ]; then
 fn_log "main" "1" "No folder was specified"
else
 DPLY_STATUS=""; 
 if ask "You will deploy the scripts within the folder $VERSIONID_FOLDER. Are you sure to proceed?" N; then #Working with folder
 
 fn_log "main" "0" "Working with folder $VERSIONID_FOLDER"
 VERSIONID="$(basename $VERSIONID_FOLDER)"
 fn_log "main" "0" "Starting backup before apply the version $VERSIONID"
#LOG_DIR=$LOG_DIR/$VERSIONID_FOLDER
 LOGFILE=${LOG_DIR}/oracle.db.deploy.$DT.$VERSIONID.log
 fn_log "main" "0" "Logfile for this execution: $LOGFILE"
 if fn_backup $VERSIONID; then
  if fn_deploy "${VERSIONID_FOLDER}/${SQL_DPLY}"; then
   fn_log "main" "0" "$VERSIONID deployed successfully"
   DPLY_STATUS="SUCCESS"
  else #deploy error
   fn_log "main" "0" "There were errors in the deployment of $VERSIONID. Aditional information in the logfiles"
   DPLY_STATUS="FAILED"
  fi
 else #Backup error
  if ask "There were error in the schema backup. Do you want to proceed whith the deploy of $VERSIONID?" N; then
   fn_log "main" "0" "Proceding with the deployment of $VERSIONID"
   if fn_deploy "${VERSIONID_FOLDER}/${SQL_DPLY}"; then
    fn_log "main" "0" "$VERSIONID deployed successfully"
    DPLY_STATUS="SUCCESS"
   else #deploy error
    fn_log "main" "0" "There were errors in the deployment of $VERSIONID. Aditional information in the logfiles"
    DPLY_STATUS="FAILED"
   fi
  else
   fn_log "main" "0" "Implementation of $VERSIONID canceled"
   DPLY_STATUS="CANCELED"
  fi
 fi
if [[ "$SEND_EMAIL_NOTIF" == "Y" || "$SEND_EMAIL_NOTIF" == "y" ]]; then
 fn_log "main" "0" "Sending notification by email"
 cat $LOGFILE | fn_email "$VERSIONID deployment status: $DPLY_STATUS"
else
 fn_log "main" "0" "Notification by email is disabled. Change the config variable SEND_EMAIL_NOTIF to Y to enable it"
fi
fi # Working with folder
fi
done
else #Canceled in file management
fn_log "main" "0" "Canceled"
fi

fn_log "main" "0" "End Script"

################################################################################
