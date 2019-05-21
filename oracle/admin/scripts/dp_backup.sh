#!/sbin/sh
################################################################################
# AUTHOR : HERNAN AZPILCUETA                                                   #
# CREATED: 14/10/2009                                                          #
# PROGRAM:                                                                     #
# PURPOSE:                                                                     #
# USAGE  : backup.sh [BEGIN|END] SID [HOT|COLD]                                #
#                                                                              #
################################################################################



#------------------------------------------------------------------------------#
# fn_                     #
#------------------------------------------------------------------------------#
fn_tablespaces() {

T_ACTION="ALTER DATABASE $1 BACKUP" 

   sqlplus -s "/ as sysdba" << EOF
      $T_ACTION;
      exit;
EOF

   RC=$?

   if [ $RC -ne 0 ]; then
      fn_log "Fallo durante el proceso $T_ACTION de la base $ORACLE_SID"
      fn_mail "Fallo durante el proceso $T_ACTION de la base $ORACLE_SID" WARNING
      exit $RC
   fi

}
#------------------------------------------------------------------------------#
# fn_                     #
#------------------------------------------------------------------------------#
fn_switch_log() {

   sqlplus -s "/ as sysdba" << EOF
      alter system archive log current;
      exit;
EOF
 
   RC=$?

   if [ $RC -ne 0 ]; then
      msg="Fallo en el switch log posterior al backup de la base $ORACLE_SID"
      fn_log $msg 
      fn_mail $msg WARNING
      #exit $RC #NO SE CONSIDERA CRITICO PARA ESTE PASO DEL BACKUP
   fi

}
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
fn_shutdown_database() {
   sqlplus '/ as sysdba' << EOF
      shutdown $1;
      exit;
EOF
RC=$?

}
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
fn_startup_database() {
   sqlplus '/ as sysdba' << EOF
      startup;
      exit;
EOF
RC=$? 

}
#------------------------------------------------------------------------------#
# fn_chk_parm(): Check for input parameters
#------------------------------------------------------------------------------#
fn_chk_parm() {

if [ ${NARG} -ne 3 ]; then
   msg="dp_backup: incorrect number of arguments passed"
   echo $msg
   fn_log $msg
   fn_mail $msg WARNING
   exit 1
fi

}
#------------------------------------------------------------------------------#
# fn_log(): log messages
#------------------------------------------------------------------------------#
fn_log() {
 fecha=`date "+%d/%m/%Y"`" -  "`date "+%H:%M:%S"`
 echo ${fecha} : $1 | tee -a ${LOGFILE}

}
#------------------------------------------------------------------------------#
# fn_blackout(): start/stop blackout 
#------------------------------------------------------------------------------#
fn_blackout() {

  BO_ACTION=$1
  
  /u01/oracle/product/agent10g/bin/emctl $BO_ACTION blackout ${ORACLE_SID}_BKP
  
  if [ $? -ne 0 ]; then
     fn_log "Fallo en durante el proceso $BO_ACTION del blackout de $ORACLE_SID"
     fn_mail "Fallo en durante el proceso $BO_ACTION del blackout de $ORACLE_SID" WARNING
  fi

}
#------------------------------------------------------------------------------#
# fn_mail(): mail
#------------------------------------------------------------------------------#
fn_mail() {

MAIL_MSG="$1"
TIPO=$2
MAIL_DBAS=dba@gsahp.garba.com.ar
MAIL_OPERADORES=operadores@gsahp.garba.com.ar
MAIL_TO=$MAIL_DBAS

# Evalúo el ambiente

# expr substr $ORACLE_SID 6 2 =  ${ORACLE_SID:6:2}

HOST=`hostname`

case `expr substr $HOST 7 1` in
  'p')
     AMBIENTE='PROD'
   ;;
  'd')
     AMBIENTE='DESA'
   ;;
  *)
     AMBIENTE="????"
   ;;
esac

# Defino si se agrega el mail a los operadores con la leyenda de comunicarse con la guardia

if [ $TIPO = 'CRITICAL' ] ; then
   if [ $AMBIENTE = 'PROD' ] ; then
     MAIL_MSG="${MAIL_MSG}. Comunicarse con la Guardia de ORACLE. "
     MAIL_TO="${MAIL_TO}, ${MAIL_OPERADORES}" 
   fi
fi 

# Envío el mail

echo "$MAIL_MSG" |mailx -s "$AMBIENTE - $HOST:$ORACLE_SID $TIPO" $MAIL_TO 

}

#------------------------------------------------------------------------------#
# fn_end(): end
#------------------------------------------------------------------------------#
fn_end() {

      if [ $1 -ne 0 ]; then
         fn_mail "Fallo durante el proceso $ACTION del backup $TYPE de la base $ORACLE_SID" CRITICAL
         fn_log "Backup finished with errors."
         exit $1
      fi
     
      exit 0
}
################################################################################
#                                     MAIN
################################################################################

NARG=$#

ACTION=$1
ORACLE_SID=$2
TYPE=$3

LOGFILE="/home/oracle/log/dp_backup.log."`date +%Y%m%d%H`
TYPE_HOT='hot'
TYPE_COLD='cold'
USAGE="[begin|end] SID [hot|cold]"

export ORACLE_SID LOGFILE

. /home/oracle/.oracle

export RC=0

   case $1 in
      'begin')
              fn_log "Starting backup of ${ORACLE_SID}... "
              case $3 in
                 $TYPE_HOT)
                            fn_tablespaces BEGIN
                            ;;
                 $TYPE_COLD)
                            fn_blackout start
                            fn_shutdown_database immediate
                            ;;
                 *)
                            msg="$1 BACKUP: ${ORACLE_SID}, incorrect backup type especified, " $USAGE
                            echo    $msg
                            fn_log  $msg
                            fn_mail $msg WARNING
                            exit 1
                            ;;
              esac
              ;;
      'end')
              case $3 in
                $TYPE_HOT)
                            fn_tablespaces END
                            fn_switch_log
                            ;;
                $TYPE_COLD) 
                            fn_startup_database
                            fn_blackout stop
                            ;;
                *)
                            msg="$1 BACKUP: ${ORACLE_SID}, incorrect backup type especified, " $USAGE
                            echo    $msg
                            fn_log  $msg
                            fn_mail $msg WARNING
                            exit 1
                            ;;
              esac
              ;;
      'help')
              echo "args: " $USAGE 
              ;;
      *)
              msg="$1 BACKUP: ${ORACLE_SID}, incorrect backup command especified, $USAGE "
              echo    $msg
              fn_log  "$msg"
              fn_mail "$msg" WARNING
              exit 1
              ;;
    esac

exit 0

################################################################################

