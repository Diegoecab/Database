#!/sbin/sh
################################################################################
# AUTHOR : JUAN MANUEL VIVAS                                                   #
# CREATED: 23/12/2008                                                          #
# PROGRAM: rman_weekly.sh                                                      #
# PURPOSE: Performs a LEVEL 0 + ARCHIVELOG backup.                             #
#          Database should be online.                                          #
# USAGE  : rman_backup SID [WEEKLY|DAILY|EMERGENCY] [ARCH|NOARCH]                        #
#
# Ileana Cesare -     Se sacó el shutdown fuera del script de rman para evitar
#                     el error librarycachenotemptyonclose
# Hernan Azpilcueta - Se agregó la notificación por mail a dbas
################################################################################

#------------------------------------------------------------------------------#
# fn_backup_E_arch(): ARCHIVELOG BACKUP                     #
#------------------------------------------------------------------------------#
fn_backup_E_arch() {

  rman target=dbas/dbas_garba_1485@GARDBOP log=${LOGFILE} append << EOF
    RUN {
                # Diego Cabrera - 12-05-2010 > DELETE FORCE OBSOLETE BEFORE CROSSCHECK - BACKUP - Error specification does not match...
                DELETE FORCE NOPROMPT OBSOLETE;
                CROSSCHECK ARCHIVELOG ALL;
                change archivelog all validate;
                BACKUP ARCHIVELOG ALL
                FILESPERSET 10
                TAG = 'ARC_E_$mes$dia'
                FORMAT '${BKPDIR}/archivelog/arc_%d_%T_s%sp%p.%t'
                DELETE ALL INPUT;
                SQL 'ALTER SYSTEM SWITCH LOGFILE';
                sql 'alter system archive log current';

                #*** Maintenance steps
                CROSSCHECK ARCHIVELOG ALL;
                CROSSCHECK BACKUP;
                change archivelog all validate;
                DELETE NOPROMPT OBSOLETE;
                DELETE NOPROMPT EXPIRED COPY;
                DELETE NOPROMPT EXPIRED BACKUP;
                DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
                DELETE NOPROMPT BACKUP OF ARCHIVELOG ALL COMPLETED BEFORE 'SYSDATE-7';
        }
   EXIT;
EOF

return $?

}

#------------------------------------------------------------------------------#
# fn_backup_l0_arch(): Perform LEVEL 0 + ARCHIVELOG BACKUP                     #
#------------------------------------------------------------------------------#
fn_backup_l0_arch() {

  rman target=dbas/dbas_garba_1485@GARDBOP log=${LOGFILE} append << EOF
    RUN {

           CROSSCHECK ARCHIVELOG ALL;
           #*** Weekly full database plus archivelog backup
           BACKUP CHECK LOGICAL
           AS COMPRESSED BACKUPSET
           INCREMENTAL LEVEL = 0
           TAG = 'DBF_W_$mes$dia'
           FORMAT '${BKPDIR}/backupset/dbf_%d_%T_s%sp%p.%t'
           DATABASE;

           #*** Weekly full archivelog backup
           change archivelog all validate;
           sql 'ALTER SYSTEM ARCHIVE LOG CURRENT';

           BACKUP CHECK LOGICAL
           AS COMPRESSED BACKUPSET
           INCREMENTAL LEVEL = 0
           TAG = 'ARC_W_$mes$dia'
           FORMAT '${BKPDIR}/archivelog/arc_%d_%T_s%sp%p.%t'
           ARCHIVELOG FROM TIME 'SYSDATE-7';

           DELETE NOPROMPT BACKUP COMPLETED BEFORE 'SYSDATE-6' DEVICE TYPE DISK;
           DELETE NOPROMPT ARCHIVELOG UNTIL TIME 'SYSDATE-7';

           #*** Maintenance steps
           CROSSCHECK BACKUP;
           CROSSCHECK ARCHIVELOG ALL;
           DELETE NOPROMPT OBSOLETE;
           DELETE NOPROMPT EXPIRED COPY;
           DELETE NOPROMPT EXPIRED BACKUP;
           DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;

        }
   EXIT;
EOF

return $?

}
#------------------------------------------------------------------------------#
# fn_backup_l0_noarch(): Perform LEVEL 0 + NOARCHIVELOG MODE                   #
#------------------------------------------------------------------------------#
fn_backup_l0_noarch() {

  sqlplus dbas/dbas_garba_1485@GARDBOP @/home/oracle/sql/rman.sql

  rman target=dbas/dbas_garba_1485@GARDBOP log=${LOGFILE} append << EOF
    RUN {
           #*** shutdown database
         # SHUTDOWN IMMEDIATE;
         #  STARTUP MOUNT;

           #*** Weekly full database
           BACKUP CHECK LOGICAL
           AS COMPRESSED BACKUPSET
           INCREMENTAL LEVEL = 0
           TAG = 'DBF_W_$mes$dia'
           FORMAT '${BKPDIR}/backupset/dbf_%d_%T_s%sp%p.%t'
           DATABASE;

           #*** Maintenance steps
           DELETE NOPROMPT BACKUP COMPLETED BEFORE 'SYSDATE-6' DEVICE TYPE DISK;
           CROSSCHECK BACKUP;
           DELETE NOPROMPT OBSOLETE;
           DELETE NOPROMPT EXPIRED COPY;
           DELETE NOPROMPT EXPIRED BACKUP;

           #*** Open database
           ALTER DATABASE OPEN;

        }
   EXIT;
EOF

return $?

}

#------------------------------------------------------------------------------#
# fn_backup_l1_arch(): Perform LEVEL 1 + ARCHIVELOG BACKUP                     #
#------------------------------------------------------------------------------#
fn_backup_l1_arch() {

  rman target=dbas/dbas_garba_1485@GARDBOP log=${LOGFILE} append << EOF
    RUN {
          #*** Daily full database backup

          BACKUP CHECK LOGICAL
          AS COMPRESSED BACKUPSET
          INCREMENTAL LEVEL = 1
          DATABASE
          FORMAT '${BKPDIR}/backupset/dbf_%d_%T_s%sp%p.%t'
          TAG='DBF_D_$mes$dia';

          #*** Daily full archivelog backup

          change archivelog all validate;
          sql 'ALTER SYSTEM ARCHIVE LOG CURRENT';
          BACKUP CHECK LOGICAL
          AS COMPRESSED BACKUPSET
          INCREMENTAL LEVEL = 1
          FORMAT '${BKPDIR}/archivelog/arc_%d_%T_s%sp%p.%t'
          TAG='ARC_D_$mes$dia'
          ARCHIVELOG FROM TIME 'SYSDATE-3';

          #*** Maintenance steps

          CROSSCHECK BACKUP;
          CROSSCHECK ARCHIVELOG ALL;
          DELETE NOPROMPT OBSOLETE;
          DELETE NOPROMPT EXPIRED BACKUP;
          DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
          DELETE NOPROMPT ARCHIVELOG UNTIL TIME 'SYSDATE-7';
        }
   EXIT;
EOF

return $?

}



#------------------------------------------------------------------------------#
# fn_backup_l1_noarch(): Perform LEVEL 1 + NOARCHIVELOG BACKUP                 #
#------------------------------------------------------------------------------#
fn_backup_l1_noarch() {

  sqlplus dbas/dbas_garba_1485@GARDBOP @/home/oracle/sql/rman.sql

  rman target=dbas/dbas_garba_1485@GARDBOP log=${LOGFILE} append << EOF
    RUN {
          #*** shutdown database

         # SHUTDOWN IMMEDIATE;
         # STARTUP MOUNT;

          #*** Daily full database backup

          BACKUP CHECK LOGICAL
          AS COMPRESSED BACKUPSET
          INCREMENTAL LEVEL = 1
          DATABASE
          FORMAT '${BKPDIR}/backupset/dbf_%d_%T_s%sp%p.%t'
          TAG='DBF_D_$mes$dia';

          #*** Maintenance steps

          CROSSCHECK BACKUP;
          DELETE NOPROMPT OBSOLETE;
          DELETE NOPROMPT EXPIRED BACKUP;

          #*** Open database

          ALTER DATABASE OPEN;
        }
   EXIT;
EOF

return $?

}
#------------------------------------------------------------------------------#
# fn_chk_parm(): Check for input parameters
#------------------------------------------------------------------------------#
fn_chk_parm() {
if [ ${NARG} -ne 4 ]; then
   echo "BACKUP: ${ORACLE_SID}, Not enough arguments passed"
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
# fn_start_blackout(): start blackout for backup
#------------------------------------------------------------------------------#
fn_start_blackout() {

  /u01/oracle/product/agent10g/bin/emctl start blackout ${ORACLE_SID}_BKP ${ORACLE_SID}.garba.com.ar

}

#------------------------------------------------------------------------------#
# fn_stop_blackout(): stop blackout status
#------------------------------------------------------------------------------#
fn_stop_blackout() {

  /u01/oracle/product/agent10g/bin/emctl stop blackout ${ORACLE_SID}_BKP

}



#------------------------------------------------------------------------------#
# fn_mail(): mail
#------------------------------------------------------------------------------#
fn_mail() {

MAIL_MSG=$1
TIPO=$2
MAIL_DBAS=dba@gsahp.garba.com.ar
MAIL_OPERADORES=operadores@gsahp.garba.com.ar
MAIL_TO=$MAIL_DBAS

# Evalúo el ambiente

# expr substr $ORACLE_SID 6 2 =  ${ORACLE_SID:6:2}

case `expr substr $ORACLE_SID 6 2` in
  'OP')
     AMBIENTE='PROD'
   ;;
  'DE')
     AMBIENTE='DESA'
   ;;
  'QA')
     AMBIENTE='TEST'
   ;;
  *)
     AMBIENTE="PROD"
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

echo "$MAIL_MSG" |mailx -s "$AMBIENTE - $ORACLE_SID - RMAN - $TIPO" $MAIL_TO

}

#------------------------------------------------------------------------------#
# fn_end(): end
#------------------------------------------------------------------------------#
fn_end() {

      if [ $1 -ne 0 ]; then
         fn_mail "El comando RMAN retornó un código distinto de 0 (cero)" CRITICAL
         fn_log "Backup finished with errors."
      else
         ls -latr #hacer un cat de la ultima linea del backup de rman
         LOGFILE=`ls -ltr $WDIR|tail -1|awk '{print $9}'`
         LOGFILE=${WDIR}/${LOGFILE}

         WARNING=`cat $LOGFILE | grep -i warning | wc -l`
         ERROR=`cat $LOGFILE | grep -i error | wc -l`

         if [ $ERROR -ne 0 ] ; then
            fn_mail "El log de RMAN indica una finalización con error" CRITICAL
            fn_log "Backup finished with errors."
         else
            if [ $WARNING -ne 0 ] ; then
               fn_mail "El log de RMAN indica una finalización con warning" WARNING
               fn_log "Backup finished with warnings."
            else
              fn_log "Backup finished successfully."
            fi
         fi
      fi

}


################################################################################
#                                     MAIN
################################################################################

export ORACLE_BASE=/u01/oracle
export ORACLE_HOME=$4
export PATH=/opt/unzip/bin:/usr/sbin:$ORACLE_HOME/bin:/opt:$PATH;
export NLS_LANG=american;
export NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI:SS';

NARG=$#
dia=`date "+%d"`
mes=`date "+%m"`
anio=`date "+%C%y"`
hora=`date "+%H%M"`
export ORACLE_SID=$1
ORACLE_HOME=$4
WDIR=/oradata/BACKUP/${ORACLE_SID}/rman
export WDIR
BKPDIR=/${WDIR}
LOGFILE=${WDIR}/logs/rman_${ORACLE_SID}.$anio$mes$dia$hora.log

fn_log "Starting rman backup of ${ORACLE_SID}... "

    fn_chk_parm
    if [ $2 = "WEEKLY" ] && [ $3 = "NOARCH" ]; then
      echo "WEEKLY / NOARCH"
      fn_start_blackout
      fn_backup_l0_noarch
      rc=$?
      fn_stop_blackout
      fn_end $rc
      exit
    fi
    if [ $2 = "WEEKLY" ] && [ $3 = "ARCH" ]; then
      echo "WEEKLY / ARCH"
      #fn_start_blackout
      fn_backup_l0_arch
      rc=$?
      #fn_stop_blackout
      fn_end $rc
      exit
    fi
    if [ $2 = "DAILY" ] && [ $3 = "NOARCH" ]; then
      echo "DAILY / NOARCH"
      fn_start_blackout
      fn_backup_l1_noarch
      rc=$?
      fn_stop_blackout
      fn_end $rc
      exit
    fi
    if [ $2 = "DAILY" ] && [ $3 = "ARCH" ]; then
      echo "DAILY / ARCH"
      #fn_start_blackout
      fn_backup_l1_arch
      rc=$?
      #fn_stop_blackout
      fn_end $rc
      exit
    fi
    if [ $2 = "EMERGENCY" ] && [ $3 = "ARCH" ]; then
      echo "EMERGENCY / ARCH"
      fn_backup_E_arch
      rc=$?
      fn_end $rc
      exit
    fi

fn_log "An unknown type of backup was submited, please review the input parameters: "
fn_log "rman_backup SID [WEEKLY|DAILY|EMERGENCY] [ARCH|NOARCH]"
fn_log "BACKUP FAILED!. Please review log files"
fn_mail "An unknown type of backup was submited, please review the input parameters" WARNING


################################################################################



