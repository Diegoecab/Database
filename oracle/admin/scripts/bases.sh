#------------------------------------------------------------------------------#
# fn_mail(): mail
#------------------------------------------------------------------------------#
fn_mail() {

MAIL_MSG=$1
TIPO=$2
MAIL_DBAS="dbas@garbarino.com.ar"
#MAIL_DBAS="dcabrera@proveedores.garbarino.com.ar"
MAIL_OPERADORES=operadores@garbarino.com.ar
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

echo "$MAIL_MSG" |mailx -s "$AMBIENTE - `hostname` - GRAL - $TIPO" $MAIL_TO

}

################################################################################
#                                     MAIN
################################################################################

SCRIPT=$1

. /home/oracle/.oracle 

ORATAB=/etc/oratab
TMPFILE=/home/oracle/tmp/control.tmp
DATFILE=/home/oracle/tmp/control.dat


#
# Loop for every entry in oratab file and and try to start
# that ORACLE
#

rm /home/oracle/tmp/control.tmp

cat $ORATAB | while read LINE
do
    case $LINE in
        \#*)                ;;        #comment-line in oratab
        *)
#       Proceed only if last field is 'Y'.
#       Entries whose last field is not Y or N are not DB entry, ignore them.
        LASTFIELD=`echo $LINE | awk -F: '{print $NF}' -`
        if [ "$LASTFIELD" = "Y" -o "$LASTFIELD" = "N" ] ; then
            ORACLE_SID=`echo $LINE | awk -F: '{print $1}' -`
            ORACLE_HOME=`echo $LINE | awk -F: '{print $2}' -`
            export ORACLE_HOME
            if [ "$ORACLE_SID" != '*' ] ; then
                export ORACLE_SID
                SQLDBA="sqlplus -S / as sysdba @$SCRIPT $ORACLE_SID XXX  " > /dev/null 
                pmon=`ps -ef | egrep pmon_$ORACLE_SID  | grep -v grep`
                if [ "$pmon" = "" ];
                then
                    echo "#Database \"${ORACLE_SID}\" not started."
                else
                    $SQLDBA 
                fi
            fi
        fi
        ;;
    esac
done

egrep "CONTROL" $TMPFILE  |sed 's/  *$//g' > $DATFILE

CRITICAL=`grep CRITICAL $DATFILE|wc -l`
WARNING=`grep WARNING $DATFILE|wc -l` 
NOTIFICATION=`grep NOTIFICATION $DATFILE|wc -l`

         if [ $CRITICAL -ne 0 ] ; then
            fn_mail "`cat $DATFILE|awk '{$1=""; $3=""; $4=""; print}'`" CRITICAL
         else
            if [ $WARNING -ne 0 ] ; then
              fn_mail "`cat $DATFILE|awk '{$1=""; $3=""; $4=""; print}'`" WARNING
            fi
	    if [ $NOTIFICATION -ne 0 ] ; then
              fn_mail "`cat $DATFILE|awk '{$1=""; $3=""; $4=""; print}'`" NOTIFICATION
            fi
         fi

exit
