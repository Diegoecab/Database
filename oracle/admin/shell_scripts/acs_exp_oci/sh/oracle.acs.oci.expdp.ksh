#!/bin/ksh                                                               
#
# Script to execute a database export with Oracle DataPump and upload the dumpfiles to an OCI Bucket Storage
#
# created on OCT 2020                                                       
# Author: Diego Cabrera <diego.cabrera@oracle.com>
#
# v 1.0 2020-OCT-14
#              
#      	USAGE
#				oracle.acs.oci.expdp.ksh <pfile_or_dpump_params>
#                              pfile_or_dpump_params:      DataPump parameters
#
#       e.g.
#		oracle.acs.oci.expdp.ksh parfile=/opt/par/db/db1/exp_full.par
#		oracle.acs.oci.expdp.ksh "\"/ as sysdba\" parfile=/u01/app/oracle/oci_expdp/par/exp_full_metadata.par"
#		oracle.acs.oci.expdp.ksh "\"/ as sysdba\" schemas=system content=metadata_only directory=DPUMP dumpfile=exp_schema_metadata.%U.dmp nologfile=yes"
#		oracle.acs.oci.expdp.ksh "usuario/password@pdb1 schemas=schema1,schema2 parallel=2 directory=exp_dir dumpfile=exp_schemas.%u.dmp logfile=exp_schemas.log"
#
#############################################################################
###   Binaries																#
#############################################################################
[[ -x "/usr/bin/mailx" ]]       	&& CMD_MAIL=/usr/bin/mailx          		|| CMD_MAIL=/bin/mailx
[[ -x "/usr/sbin/sendmail" ]]       && CMD_SENDMAIL=/usr/sbin/sendmail          || CMD_SENDMAIL=/usr/lib/sendmail
[[ -x "/bin/printf" ]]              && CMD_PRINTF=/bin/printf                   || CMD_PRINTF=/usr/bin/printf
[[ -x "/bin/echo" ]]                && CMD_ECHO=/bin/echo                       || CMD_ECHO=/usr/bin/echo
[[ -x "/bin/awk" ]]                 && CMD_AWK=/bin/awk                         || CMD_AWK=/usr/bin/awk
[[ -x "/bin/cat" ]]                 && CMD_CAT=/bin/cat                         || CMD_CAT=/usr/bin/cat
[[ -x "/bin/cut" ]]                 && CMD_CUT=/bin/cut                         || CMD_CUT=/usr/bin/cut
[[ -x "/bin/rm" ]]                  && CMD_RM=/bin/rm                           || CMD_RM=/usr/bin/rm
[[ -x "/bin/date" ]]                && CMD_DATE=/bin/date                       || CMD_DATE=/usr/bin/date
[[ -x "/bin/find" ]]                && CMD_FIND=/bin/find                       || CMD_FIND=/usr/bin/find
[[ -x "/bin/ls" ]]                  && CMD_LS=/bin/ls                           || CMD_LS=/usr/bin/ls
[[ -x "/bin/wc" ]]                  && CMD_WC=/bin/wc                           || CMD_WC=/usr/bin/wc
[[ -x "/bin/sed" ]]                 && CMD_SED=/bin/sed                         || CMD_SED=/usr/bin/sed

#############################################################################   
### Setting local variables                                             
#############################################################################   
if [ -z "$1" ] 
then
$CMD_PRINTF "no enough parameters\n"
$CMD_PRINTF "USAGE: \n ${APPL_DIR_SH}/oracle.acs.oci.expdp.ksh <pfile_or_dpump_params>\n		pfile_or_dpump_params:      DataPump parameters\n"
exit
fi
export DP_PARAMS="$1"

DD=`date "+%d"`
MM=`date "+%m"`
YY=`date "+%C%y"`
HH=`date "+%H_%M"`
MDY=$(date '+%m%d%y')
DMY=$(date '+%d%m%y')
MY=$(date '+%m%y')
HM=`date "+%H%M"`
DD_TMP=$(date '+%y%m%d.%OH%OM%OS')
EXEC_ID=$(date '+%y%m%d%H%M%S')


###########################################################
# Returns unified timestamp
###########################################################
function getdate {
  ${CMD_ECHO} $(${CMD_DATE} +"%Y-%m-%d %H:%M:%S")
}

#############################################################################
###   Mailing function 													##
#############################################################################
fn_mail() {
typeset SEV_MAIL="${1}";
typeset BODY="${2}";
typeset notif_message="";

fn_log "fn_mail" "2" "Sending email to ${XV_EMAILSUPPORT}"

if [ ! -z "$BODY" ]
then
	printf "$BODY" | $CMD_MAIL  -a "${APPL_FILE_TMP_LOG}" -s "$SEV_MAIL: Oracle DataPump export errors on `hostname`" "${XV_EMAILSUPPORT}"
fi

fn_log "fn_mail" "2" "Email sent"

}

#############################################################################
###  Registering logs function 										 	   ##
#############################################################################
fn_log()
{
# PARAMETERS: $1: Function name 
#             $2: Error code
#             $3: Log message 
  
if [ ${#} -lt 3  ]; then
     $CMD_ECHO -e "fn_log: Not enough parameters"
    return 1;
fi;



typeset FUN_NAME="${1}";
typeset ERR_NUM="${2}";
typeset ERR_NAME="UNKNOWN";
typeset LOG_STR="${3}";

case $ERR_NUM in
	 "3") #ERROR
	  ERR_NAME="ERROR";
			;;
	  "2") #INFO
	  ERR_NAME="INFO";
			;;
	   "1") #DEB
	  ERR_NAME="DEBUG";
			;;
		"*")
	  ERR_NAME="UNKNOWN";
	   ;;
esac

typeset MSG_LOG="$(getdate) (${FUN_NAME}) [${ERR_NAME}]: ${LOG_STR}"

#DEBLEVEL = 0=ERROR only, 1=ERROR + INFO, 2=ERROR + INFO + DEBUG

$CMD_ECHO -e "${MSG_LOG}" | tee -a $APPL_FILE_MAIN_LOG $APPL_FILE_TMP_LOG


#3: Log and error files
if [ ${ERR_NUM} -eq 3  ]; then #ERROR message
     $CMD_ECHO -e "${MSG_LOG}" >> $APPL_FILE_MAIN_LOG
fi

return 0;
}


#############################################################################
###   Check files                    									   ##
#############################################################################
function fn_chkfiles {

if [ ! -d "${APPL_DIR_LOG}" ]
then
	ERRDESCRIPTION=$ERRDESCRIPTION"1.0 -> (ERROR) Directory ${APPL_DIR_LOG} does not exists.\n";
	XV_RET=-1
fi

if [ ! -d "${APPL_DIR_LOG}/dpexp" ]
then
	ERRDESCRIPTION=$ERRDESCRIPTION"1.0 -> (ERROR) Directory ${APPL_DIR_LOG}/dpexp does not exists.\n";
	XV_RET=-1
fi

if [ ! -d "${APPL_DIR_TMP}" ]
then
	ERRDESCRIPTION=$ERRDESCRIPTION"1.0 -> (ERROR) Directory ${APPL_DIR_TMP} does not exists.\n";
	XV_RET=-1
fi

if  [ ! -f "${APPL_FILE_MAIN_CFG}" ]
then
	ERRDESCRIPTION=$ERRDESCRIPTION"1.2 -> (ERROR) File ${APPL_FILE_MAIN_CFG} does not exists.\n";
	XV_RET=-1
fi

if  [ ! -f "${EXPDP_BIN}" ]
then
	ERRDESCRIPTION=$ERRDESCRIPTION"1.2 -> (ERROR) File ${EXPDP_BIN} does not exists.\n";
	XV_RET=-1
fi

if [ ! -z "$ERRDESCRIPTION" ]
then
	printf "$ERRDESCRIPTION";
fi

}


#############################################################################
###   Purge			##
#############################################################################
fn_purge ()
{
#Log files
fld=$(find ${APPL_DIR_LOG} -type f -mtime +${APPL_PURGE_OLD_LOGS} | wc -l)
#find ${APPL_DIR_LOG} -mtime +${APPL_PURGE_OLD_LOGS} -exec rm -rf {} \;
fn_log "fn_purge" "2" "${fld} files deleted on ${APPL_DIR_LOG} (retention of ${APPL_PURGE_OLD_LOGS} days)"
#temp files
fld=$(find ${APPL_DIR_TMP} -type f -mtime +${APPL_PURGE_OLD_LOGS} | wc -l)
#find ${APPL_DIR_TMP} -mtime +${APPL_PURGE_OLD_LOGS} -exec rm -rf {} \;
fn_log "fn_purge" "2" "${fld} files deleted on ${APPL_DIR_TMP} (retention of ${APPL_PURGE_OLD_LOGS} days)"
#dumpfiles
dld=$(find ${APPL_DIR_HIST} -type d -mtime +${APPL_PURGE_OLD_DMP_HIST} | wc -l)
#find ${APPL_DIR_HIST} -mtime +${APPL_PURGE_OLD_DMP_HIST} -exec rm -rf {} \;
fn_log "fn_purge" "2" "${dld} directories deleted on ${APPL_DIR_HIST} (retention of ${APPL_PURGE_OLD_DMP_HIST} days)"
}

#############################################################################
###   End script function              									   ##
#############################################################################
fn_endscript ()
{
#Delete tempfiles
$CMD_RM -f $TMPFILE 2>/dev/null
#Purge logs
fn_purgelogs
}


fn_run_sql () {
 if [ ${#} -lt 1  ]; then
     echo "Not enough parameters"
     return 1;
  fi;

typeset QUERY_HEAD="
set head off;
set verify off;
set feed off;
";
typeset QUERY_BODY="${1}";
typeset x=`$DB_CONNECTION <<EOF
${QUERY_HEAD}
${QUERY_BODY}
exit
EOF`

echo ${x};
}

fn_exp()
{
if [ ${#} -lt 1  ]; then
	 fn_log "fn_exp" "3" "fn_exp: Not enough parameters"
    return 1;
fi;
fn_log "fn_exp" "2" "Executing datapump export with parameters:"
fn_log "fn_exp" "2" "${1}"
fn_log "fn_exp" "2" "Logfile: $APPL_DP_EXP_LOG"
${EXPDP_BIN} ${1} </dev/null >> $APPL_DP_EXP_LOG 2>&1
XV_RET=$?
logth=$(head -30 $APPL_DP_EXP_LOG) 2>/dev/null
logtl=$(tail -30 $APPL_DP_EXP_LOG) 2>/dev/null
if [ $XV_RET -ne 0 ]
then
fn_log "fn_exp" "3" "DataPump export executed with errors"
fn_log "fn_exp" "3" "$logtl"
else
fn_log "fn_exp" "2" "DataPump export executed successfully"
fn_log "fn_exp" "2" "$logtl"
dmpfiles=$(sed -n '/^Dump/,/^Job/p;/^Job/q' $APPL_DP_EXP_LOG | sed '1d;$d' | sed 's/ //g')
fn_log "fn_exp" "2" "Dumpfiles: "
while IFS= read -r file
do
   fn_log "fn_exp" "2" "${file}"
done < <(printf '%s\n' "$dmpfiles")

fi
return 0;
}

fn_move_stg()
{

mk_out=$(mkdir -p ${APPL_DIR_STG}/${DMY}_${HH} 2>&1)
RET=$?
if [ $RET -ne 0 ]
then
	fn_log "fn_move_stg" "3" "Error at creating folder ${APPL_DIR_STG}/${DMY}_${HH}"
	fn_log "fn_move_stg" "3" "$mk_out"
	XV_RET=-1
fi

fn_log "fn_move_stg" "2" "Moving files to staging folder ${APPL_DIR_STG}"



while IFS= read -r file
do
   fn_log "fn_move_stg" "2" "Moving file ${file} to ${APPL_DIR_STG}/${DMY}"
   mv_out=$(mv ${file} ${APPL_DIR_STG}/${DMY}_${HH}/  2>&1)
   RET=$?
	if [ $RET -ne 0 ]
	then
		fn_log "fn_move_stg" "3" "Error at moving file to ${APPL_DIR_STG}/${DMY}_${HH}"
		fn_log "fn_move_stg" "3" "$mv_out"
		XV_RET=-1
	fi
done < <(printf '%s\n' "$1")

}


fn_move_hist()
{

mk_out=$(mkdir -p ${APPL_DIR_HIST}/${DMY}_${HH} 2>&1)
RET=$?
if [ $RET -ne 0 ]
then
	fn_log "fn_move_hist" "3" "Error at creating folder ${APPL_DIR_HIST}/${DMY}_${HH}"
	fn_log "fn_move_hist" "3" "$mk_out"
	XV_RET=-1
fi

fn_log "fn_move_hist" "2" "Moving files to history folder ${APPL_DIR_HIST}"

while IFS= read -r file
do
   fn_log "fn_move_hist" "2" "Moving file ${file} to ${APPL_DIR_HIST}/${DMY}_${HH}"
   mv_out=$(mv ${file} ${APPL_DIR_HIST}/${DMY}_${HH}/  2>&1)
   RET=$?
	if [ $RET -ne 0 ]
	then
		fn_log "fn_move_hist" "3" "Error at moving file to ${APPL_DIR_HIST}/${DMY}_${HH}"
		fn_log "fn_move_hist" "3" "$mv_out"
		XV_RET=-1
	fi
done < <(printf '%s\n' "$1")

}

fn_upload_bucket()
{
if [ $OCI_OBJECT_OVER_WRITE = "Y" ] #Overwrite file
then
	OCI_COMMAND="${OCI_CLI_PATH}/bin/oci os object put -ns ${OCI_OBJECT_STORAGE_NAMESPACE} -bn ${OCI_BUCKET_NAME} </dev/null"
else
	OCI_COMMAND="${OCI_CLI_PATH}/bin/oci os object put -ns ${OCI_OBJECT_STORAGE_NAMESPACE} -bn ${OCI_BUCKET_NAME} --force </dev/null"
fi
for file in $(ls ${APPL_DIR_STG}/${DMY}_${HH}/*); do
   fn_log "fn_upload_bucket" "2" "Uploading file ${file} to namespace ${OCI_OBJECT_STORAGE_NAMESPACE} bucket ${OCI_BUCKET_NAME}"
   oci_upload=$(${OCI_COMMAND} --file ${file} 2>&1)
   RET=$?
	if [ $RET -ne 0 ]
	then
		fn_log "fn_upload_bucket" "3" "Error at uploading file to OCI object storage"
		fn_log "fn_upload_bucket" "3" "$oci_upload"
		XV_RET=-1
	fi
done
}


fn_move_stg_to_hist()
{
for file in "${APPL_DIR_STG}/${DMY}_${HH}/*"; do
   fn_log "fn_move_stg_to_hist" "2" "moving file ${file} hist folder"
   fn_move_hist "$file"
done
}


#############################################################################
###   Main																   ##
#############################################################################
#Checking required directories and files
filename=$(basename -- "$0")
filename="${filename%.*}"
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; cd ..; pwd -P )"
APPL_DIR="${SCRIPTPATH}"
APPL_DIR_CFG="$(dirname $0)/../cfg"
APPL_FILE_MAIN_CFG=${APPL_DIR_CFG}/$filename.cfg
. ${APPL_FILE_MAIN_CFG}

export XV_RET=0;
export dmpfiles="";

fn_chkfiles

if [ $XV_RET -eq -1 ] #If Missing required directories or files
then
 $CMD_ECHO -e "${YY}/${MM}/${DD} ${HH}  GENERAL ERROR: Missing required directories or files\n" | tee -a $APPL_FILE_MAIN_ERR 2>/dev/null
else
  fn_log "main" "2" "################################################################################################################"
  fn_log "main" "2" "#"
  fn_log "main" "2" "# Oracle ACS Datapump script "
  fn_log "main" "2" "#"
  fn_log "main" "2" "# Executing script ${filename} with parameters: ${DP_PARAMS}"
  fn_log "main" "2" "# Executed on `hostname` by `whoami`"
  fn_log "main" "2" "# General logfile: $APPL_FILE_MAIN_LOG"
  fn_log "main" "2" "#"
  fn_log "main" "2" "################################################################################################################"
  fn_exp "${DP_PARAMS}"
  if [ $XV_RET -ne 0 ] #Expdp with errors
	then
		if [ $SEND_EMAIL_NOTIF_ENABLED = "Y" ]
		then
			fn_mail "ERROR" "there were errors in the datapump"
		fi
	else  #Expdp without errors
		if [ $UPLOAD_DMP_2OCI_ENABLED = "Y" ]
		then
			fn_move_stg "${dmpfiles}"
			if [ $XV_RET -ne 0 ] #fn_move_stg with errors
			then
				if [ $SEND_EMAIL_NOTIF_ENABLED = "Y" ]
					then
					fn_mail "ERROR" "There were errors in fn_move_stg"
				fi
			else #fn_move_stg without errors
				fn_upload_bucket
					if [ $XV_RET -ne 0 ] #fn_upload_bucket with errors
					then
						if [ $SEND_EMAIL_NOTIF_ENABLED = "Y" ]
						then
							fn_mail "ERROR" "there were errors in the upload to bucket"
						fi
					else
						fn_move_stg_to_hist #In this case the files will be in the stg folder
						if [ $XV_RET -ne 0 ] #fn_move_hist with errors
						then
							if [ $SEND_EMAIL_NOTIF_ENABLED = "Y" ]
								then
								fn_mail "ERROR" "There were errors in fn_move_hist"
							fi
						fi #fn_move_hist without errors
					fi
			fi
		else
			fn_log "main" "2" "Upload to bucket is disabled"
			fn_log "main" "2" "Moving files to hist folder"
			fn_move_hist "${dmpfiles}"
			if [ $XV_RET -ne 0 ] #fn_move_hist with errors
			then
				if [ $SEND_EMAIL_NOTIF_ENABLED = "Y" ]
					then
					fn_mail "ERROR" "There were errors in fn_move_hist"
				fi
			fi #fn_move_hist without errors
		fi
   if [ $APPL_PURGE_ENABLED = "Y" ]
   then
    fn_purge
   else
	fn_log "main" "2" "Purge folders and files is disabled"
   fi
  fi
  fn_log "main" "2" "################################################################################################################"
  fn_log "main" "2" "#End of script"
  fn_log "main" "2" "################################################################################################################"
fi  #End If Missing required directories or files