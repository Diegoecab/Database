#!/bin/sh 

#################################################################################
# AUTOR: 	Diego Cabrera                                                   #
# CREADO: 04/05/2010                                                          	#
# SCRIPT: awr_rep.sh                                                    	#
# DETALLES: 									#
# UTILIZAR  : awr_rep.sh SID DIAS MAIL											#
# PARAMETROS:                                                                  	#
#   	SID	: Nombre de la instancia de base de datos                       	#
#     	DIAS: Cantidad de dias             	#
#		MAIL: cuenta de E-Mail destinatario 									#
#																				#
#################################################################################

#Variables

ORACLE_SID=$1
DIAS=$2
MAIL=$3
FECHA=`date +%y%m%d`
HOST=`hostname`
NOMBRE_BASE=$ORACLE_SID
DEFVARIA=define_variables$FECHA.sql
LEJEC=llama_ejec$FECHA.sql
VAWR=variables_awr$FECHA.sql
database='$database'
LOGF=$FECHA"_reporte_awr"$ORACLE_SID".html"

export ORACLE_SID FECHA NOMBRE_BASE database DIAS MAIL

#define_variables$FECHA.sql

echo "set heading off" >>$DEFVARIA
echo "spool $VAWR">>$DEFVARIA
echo "select 'DEFINE begin_snap='|| MIN (SNAP_ID) FROM dba_hist_snapshot WHERE TRUNC (BEGIN_INTERVAL_TIME) = TRUNC (SYSDATE - $DIAS);">>$DEFVARIA
echo "select 'DEFINE end_snap='||MAX (SNAP_ID) FROM dba_hist_snapshot;">>$DEFVARIA
echo "select 'DEFINE dbid='||dbid from v$database;">>$DEFVARIA


#llama_ejec.sql

echo "@$DEFVARIA">>$LEJEC
echo "spool off">>$LEJEC
echo "exit">>$LEJEC

sqlplus / as sysdba @$LEJEC

#Ejecucion

sqlplus / as sysdba << EOF
@$VAWR

define  report_type  = 'html';
define  inst_num     = 1;
define  num_days     = $DIAS;
define report_name=$LOGF;

define  inst_name    = $ORACLE_SID;
define  db_name      = $ORACLE_SID;

@@?/rdbms/admin/awrrpti
EOF

#Mail

uuencode $LOGF $FECHA"_awr_"$HOST"_"$NOMBRE_BASE".html" | mailx -s "AWR Base $HOST - $NOMBRE_BASE " $MAIL

#Elimina Archivos

rm $DEFVARIA $LEJEC $VAWR $LOGF

#######################################################################