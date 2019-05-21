***************************************************************************************************************************
*****************************LogMiner**************************************************************************************
***************************************************************************************************************************

Paso 1:

Especificar los logs a analizar:

Ejemplo Manual:

EXECUTE SYS.DBMS_LOGMNR.ADD_LOGFILE( -
   LOGFILENAME => '/oracle/logs/log1.f', -
   OPTIONS => SYS.DBMS_LOGMNR.NEW);


EXECUTE SYS.DBMS_LOGMNR.ADD_LOGFILE( -
       LOGFILENAME => '/oracle/logs/log2.f',
       OPTIONS => DBMS_LOGMNR.ADDFILE);



	Automatico:

	ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
	EXECUTE DBMS_LOGMNR.START_LOGMNR( -
	   STARTTIME => '01-Jan-2003 08:30:00', -
	   ENDTIME => '01-Jan-2003 08:45:00', -
	   OPTIONS => DBMS_LOGMNR.DICT_FROM_ONLINE_CATALOG + -
	   DBMS_LOGMNR.CONTINUOUS_MINE);



***************************************************************************************************************************

Paso 2:

Start LogMiner:



EXEC SYS.DBMS_LOGMNR.START_LOGMNR;



Start LogMiner especificando diccionario:

EXECUTE SYS.DBMS_LOGMNR.START_LOGMNR(
       OPTIONS => SYS.DBMS_LOGMNR.DICT_FROM_ONLINE_CATALOG);




***************************************************************************************************************************

Paso 3:

Query:


SELECT username AS USR, (XIDUSN || '.' || XIDSLT || '.' ||  XIDSQN) AS XID,SQL_REDO, SQL_UNDO FROM V$LOGMNR_CONTENTS
WHERE USERNAME IS NOT NULL


SELECT TIMESTAMP,USERNAME,SEG_OWNER,SEG_NAME,TABLE_NAME,OPERATION,SQL_REDO,SQL_UNDO 
FROM V$LOGMNR_CONTENTS WHERE SEG_OWNER IS NOT NULL AND SEG_OWNER !='UNKNOWN'


SELECT TIMESTAMP, USERNAME, SEG_OWNER, SEG_NAME, TABLE_NAME, OPERATION,
       SQL_REDO, SQL_UNDO
  FROM V$LOGMNR_CONTENTS
 WHERE SQL_REDO LIKE 'AQ%'
 
 select scn,timestamp, log_id, seg_owner, seg_name, session#, username, session_info, operation, operation_code, sql_redo, audit_sessionid
from dba_dc22057.LOGMNR_CONTENTS where timestamp > sysdate -2 and seg_owner='CRCO_DW' and seg_name= 'WF_EXECUTE_TR' order by timestamp desc


***************************************************************************************************************************

Paso 4:

Finalizar sesion en LogMiner:

EXECUTE SYS.DBMS_LOGMNR.END_LOGMNR();


O

Quitar el Log y agregar otro


exec SYS.DBMS_LOGMNR.REMOVE_LOGFILE ( LogFileName=>'/export/home/oracle/Backups/archive_logs/parche/arch_684_1_641633790.arc');


***************************************************************************************************************************


