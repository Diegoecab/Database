#------------------------------------------------------------------------------#
# fn_mail(): mail
#------------------------------------------------------------------------------#
fn_mail() {

MAIL_MSG=$1
TIPO=$2
MAIL_DBAS="dbas@garbarino.com.ar"
MAIL_OPERADORES=operadores@gsahp.garba.com.ar
MAIL_TO=$MAIL_DBAS


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

. /home/oracle/.oracle 

TMPFILE=/home/oracle/tmp/control_auditsoa.tmp
DATFILE=/home/oracle/tmp/control_auditsoa.dat


rm /home/oracle/tmp/control_auditsoa.tmp



export ORACLE_SID=SOAGPOP

sqlplus -S / as sysdba <<EOF  
set feedback off
set verify off
set termout off
set heading off
set serveroutput on

spool /home/oracle/tmp/control_auditsoa.tmp append

set linesize 280
set pagesize 50000


BEGIN
   FOR i IN
      (SELECT *
         FROM (SELECT NAME,
                        100
                      - ROUND ((MAX - (alloc - free)) / MAX * 100) pct_used
                 FROM (SELECT   NVL (b.tablespace_name,
                                     NVL (a.tablespace_name, 'UNKNOW')
                                    ) NAME,
                                alloc, NVL (free, 0) free,
                                NVL (MAX, 0) + NVL (maxn, 0) MAX
                           FROM (SELECT   ROUND (SUM (BYTES) / 1024 / 1024
                                                ) free,
                                          tablespace_name
                                     FROM SYS.dba_free_space
                                 GROUP BY tablespace_name) a,
                                (SELECT   SUM (BYTES) / 1024 / 1024 alloc,
                                          SUM (maxbytes) / 1024 / 1024 MAX,
                                          (SELECT   SUM (BYTES)
                                                  / 1024
                                                  / 1024
                                             FROM dba_data_files df3
                                            WHERE df3.tablespace_name =
                                                           df1.tablespace_name
                                              AND df3.autoextensible = 'NO')
                                                                         maxn,
                                          tablespace_name
                                     FROM SYS.dba_data_files df1
                                 GROUP BY tablespace_name) b
                          WHERE a.tablespace_name(+) = b.tablespace_name
                       ORDER BY 1))
        WHERE NAME = UPPER ('ORABPEL_AUDIT'))
   LOOP
      IF i.pct_used > 70
      THEN
         EXECUTE IMMEDIATE ('truncate table orabpel.audit_details');
         EXECUTE IMMEDIATE ('truncate table orabpel.audit_trail');
		 DBMS_OUTPUT.put_line ('CONTROL SOAGPOP XXX OBJ NOTIFICATION Se depuraron la tablas de auditoria de ORABPEL - SOAGPOP');
      END IF;
   END LOOP;
END;
/
EOF


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





