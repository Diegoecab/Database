#!/sbin/sh
################################################################################
# AUTHOR : Diego Cabrera						       						   #
# CREATED: 01/10/2010                                                          #
# PROGRAM: broker_check.sh                                                     #
# USAGE  : rman_backup SID [WEEKLY|DAILY|EMERGENCY] [ARCH|NOARCH]              #
################################################################################

###################### ORACLE ##############################
umask 022
export ORACLE_BASE=/u01/oracle
export AGENT_HOME=$ORACLE_BASE/product/agent10g
export OMS_HOME=$ORACLE_BASE/product/agent10g
export OWB1_HOME=$ORACLE_BASE/product/owb10gr1
export OWB2_HOME=$ORACLE_BASE/product/owb10gr2
export DB_HOME=$ORACLE_BASE/product/db10gr2
export ORACLE_HOME=$DB_HOME
export ORACLE_SID=GARDBOP
export TERM=vt100
export PATH=/opt/unzip/bin:/usr/sbin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:/opt:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/dt/lib:/usr/lib
export TMP=/tmp
export PS1=[`whoami`@`hostname`]' $PWD (${ORACLE_SID}) > '
############################################################

export ORACLE_SID=GARDBOP
export LOGFILE=/home/oracle/log/check_broker.html
FILELOCK=/home/oracle/log/controldataguard$ORACLE_SID.lock.pid

rm $LOGFILE

fn_mail() {

TIPO=$1
MAIL_DBAS="dbas@garbarino.com.ar, arapaport@garbarino.com.ar"
MAIL_OPERADORES=operadores@garbarino.com.ar
MAIL_TO=$MAIL_DBAS

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
     #MAIL_TO="${MAIL_TO}, ${MAIL_OPERADORES}"
   fi
fi

if [ -f $FILELOCK ]; then
echo "Proceso ejecutandose ..." >>$LOGFILE
else
# Envmo el mail
export SUBJECT="$AMBIENTE - $ORACLE_SID - DATAGUARD - $TIPO"
export attachment=filename.html
(
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: text/html"
 echo "Content-Disposition: inline"
 cat $LOGFILE
) | /usr/sbin/sendmail $MAIL_TO
if [ $TIPO != 'OK' ] ; then
echo "Error" > $FILELOCK
fi
fi

}

echo "<html> <h5>Error en GARDBOP - Data Guard</h5> <p> <table border='1' cellpadding='0' cellspacing='0' width='50%' style='color: #FF0000;'> <tr><td valign='top'>" >$LOGFILE
result=`$ORACLE_HOME/bin/dgmgrl -silent dbas/dbas "show configuration;" >>$LOGFILE`
resultn=`$ORACLE_HOME/bin/dgmgrl -silent dbas/dbas "show configuration;"`
result2=`echo $resultn | awk -F": " '{print $NF}'`
if [ "$result2" = "SUCCESS" ] ; then
	if [ -f $FILELOCK ]; then
	rm $FILELOCK
	echo "<h5>Data Guard sin errores</h5>" > $LOGFILE
	fn_mail OK
	fi
    exit 0
else
   echo "</td> </tr></table> <p> <h5>Errores Data Guard (Ultima hora)</h5>
	<table cellpadding='0' border='1' cellspacing='0' width='100%'>
	<tbody><tr>
            <th align='left'>TIMESTAMP</th>
            <th align='left'>MESSAGE</th></tr>" >>$LOGFILE
sqlplus -s dbas/dbas >>$LOGFILE <<EOF
set feedback off
set heading off
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select '<tr><td valign="top">'
        ||timestamp
        ||'</td>
                          <td valign="top">'
        ||message
        || ' </td> </tr>'
from dataguard_status
where to_Date(timestamp,'dd/mm/yyyy hh24:mi:ss')
between SYSDATE - (60/1440) and to_Date(sysdate,'dd/mm/yyyy hh24:mi:ss')
order by 1;
EOF
	echo "</table></html>" >>$LOGFILE
   fn_mail CRITICAL 
fi
