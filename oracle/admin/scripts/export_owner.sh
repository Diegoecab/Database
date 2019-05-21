#!/usr/bin/ksh
################################################################################
#
#
###############################################################################

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

echo "$MAIL_MSG" |mailx -s "$AMBIENTE - $ORACLE_SID - EXP - $TIPO" $MAIL_TO

}

################################################################################
#                                     MAIN
################################################################################

. /home/oracle/.oracle

export ORACLE_SID=$1
OWNERR=$2
DIR=$3
RETENTION=$4
FECHA=`date +%Y%m%d_%H%M%S`
PREF=exp_cron_${ORACLE_SID}_${OWNERR}
FILE=${DIR}/${PREF}_${FECHA}
LOGFILE=${FILE}.log
DUMPFILE=${FILE}.dmp
ZIPF=${DUMPFILE}.Z

export NLS_LANG=.WE8ISO8859P1

rm ${DUMPFILE} 2>/dev/null
mknod ${DUMPFILE} p
chmod +rw ${DUMPFILE}
compress -c < ${DUMPFILE} > ${ZIPF} &

exp "'/ as sysdba'" file=${DUMPFILE} owner=${OWNERR} log=${LOGFILE} statistics=none

if [ $? -eq 0 ] ; then
  find $DIR -name "${PREF}*.Z" -mtime +${RETENTION} -exec rm -f {} \;
else
  #envío mail
  fn_mail "Error export $OWNERR en $ORACLE_SID" WARNING   
fi

rm ${DUMPFILE} 2>/dev/null

exit
