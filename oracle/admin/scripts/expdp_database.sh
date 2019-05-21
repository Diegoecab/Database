#!/usr/bin/ksh
################################################################################
#
#
###############################################################################
#Ejecutar:
#expdp_database.sh      SID     [ESQUEMADB|FULL] 1-N DIRECTORIO_DB $ORACLE_HOME 1|0
#Parametros
#1 ORACLE_SID
#2 Esquema de base de datos a exportar o "FULL" en caso de realizar export FULL
#3 Cantidad de dmas de resguardo de dmp y logs
#4 Directorio de base de datos
#5 ORACLE_HOME
#6 1 Comprime, 0 no comprime
#------------------------------------------------------------------------------#
# fn_mail(): mail
#------------------------------------------------------------------------------#
fn_mail() {

MAIL_MSG=$1
TIPO=$2
MAIL_DBAS=dba@gsahp.garba.com.ar
MAIL_OPERADORES=operadores@gsahp.garba.com.ar
MAIL_TO=$MAIL_DBAS

# Evalzo el ambiente
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
     #MAIL_TO="${MAIL_TO}, ${MAIL_OPERADORES}"
   fi
fi

MAIL_TO="${MAIL_TO}, ${MAIL_OPERADORES}"
#MAIL_TO=dcabrera@garbarino.com.ar

# Envmo el mail
echo "$MAIL_MSG" |mailx -s "$AMBIENTE - $ORACLE_SID - EXP - $TIPO" $MAIL_TO
}

################################################################################
#                                     MAIN
################################################################################

#. /home/oracle/.oracle --> El script se puede correr desde otro ORACLE_HOME

export ORACLE_SID=$1
export ORACLE_HOME=$5
export PATH=/opt/unzip/bin:/usr/contrib/bin:/usr/sbin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:/opt:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/dt/lib:/usr/lib
DIRDB=$4
#Saco el directorio de la base de datos
DIR=`sqlplus -s dbas/dbas@GARDBOP <<EOF
set heading off feedback off verify off
select directory_path from dba_directories where directory_name = '$4' ;
exit
EOF
`
#Si no existe directorio de base de datos
if [ $DIR = '' ] ; then
fn_mail "Export full en $ORACLE_SID. No existe directorio $4 en la base de datos." CRITICAL
exit
fi

OWNERR=$2
RETENTION=$3
FECHA=`date +%Y%m%d_%H%M%S`
PREF=exp_cron_${ORACLE_SID}_${FECHA}_${OWNERR}.dmp
FILE=${DIR}/${PREF}_${FECHA}
LOGFILE=${FILE}.log
DUMPFILE=${FILE}.dmp
ZIPF=${DUMPFILE}.Z

export NLS_LANG=.WE8ISO8859P1

#Evaluo tipo de export FULL o esquema
if [ $2 = 'FULL' ] ; then
#Export full
#Envio mail de notificacion
fn_mail "Se ejecuto export full en $ORACLE_SID" NOTIFICATION
expdp cierres/cierres_10_idx1a@GARDBOP dumpfile=${DIRDB}:${PREF} logfile=${DIRDB}:${PREF}.log full=yes
        if [ $? -eq 0 ] ; then
        #Si el export da Ok
                if [ $6 = '1' ] ; then
                #Comprimo
                /usr/contrib/bin/gzip ${DIR}/${PREF}
                        if [ $? -eq 0 ] ; then
                        #No hubo error al comprimir, depuro archivos
                        find ${DIR} -name "exp_cron*" -mtime +${RETENTION} -exec rm -f {} \;
                        fn_mail "Export full en $ORACLE_SID ejecutado correctamente " NOTIFICATION
                        else
                        #En caso de error mando mail solo a los DBAS
                        fn_mail "Error al comprimir export full en $ORACLE_SID" NOTIFICATION
                        fi
                else
                #No Comprimo
                #find ${DIR} -name "exp_cron*" -mtime +${RETENTION} -exec rm -f {} \;
#cd $DIR
#sqlplus cierres/cierres_10_idx1a@GARDBOP <<EOF > /home/cierres/log/comprime.log
#prompt comprimir...
#host /usr/contrib/bin/gzip $PREF
#EOF
                fn_mail "Export full en $ORACLE_SID ejecutado correctamente" NOTIFICATION
                fi
        else
        #El export no dio OK, envmo mail
        fn_mail "Error export full en $ORACLE_SID" WARNING
        fi
else
#Export de esquema
#Envio mail de notificacion
fn_mail "Se ejecuto export de esquema $2 en $ORACLE_SID" NOTIFICATION
expdp cierres/cierres_10_idx1a@GARDBOP dumpfile=${DIRDB}:${PREF} logfile=${DIRDB}:${PREF}.log schemas=$2
        if [ $? -eq 0 ] ; then
        #Si el export da Ok
                if [ $6 = '1' ] ; then
                #Comprimo
                /usr/contrib/bin/gzip ${DIR}/${PREF}
                        if [ $? -eq 0 ] ; then
                        #No hubo error al comprimir, depuro archivos
                        find ${DIR} -name "exp_cron_${ORACLE_SID}*.gz" -mtime +${RETENTION} -exec rm -f {} \;
                        find ${DIR} -name "exp_cron_${ORACLE_SID}*.log" -mtime +${RETENTION} -exec rm -f {} \;
                        fn_mail "Export de esquema $2 en $ORACLE_SID ejecutado correctamente" NOTIFICATION
                        else
                        #En caso de error mando mail, solo a los DBAS
                        fn_mail "Error al comprimir export de $2 en $ORACLE_SID. Comprimir y depurar dmp!" NOTIFICATION
                        fi
                else
                #No Comprimo
        #       find ${DIR} -name "exp_cron_${ORACLE_SID}*.dmp" -mtime +${RETENTION} -exec rm -f {} \;
        #       find ${DIR} -name "exp_cron_${ORACLE_SID}*.log" -mtime +${RETENTION} -exec rm -f {} \;
                fn_mail "Export de esquema $2 en $ORACLE_SID ejecutado correctamente" NOTIFICATION
                fi
        else
        #El export no dio OK, envmo mail
        fn_mail "Error export de esquema $2 en $ORACLE_SID" WARNING
        fi
fi

exit