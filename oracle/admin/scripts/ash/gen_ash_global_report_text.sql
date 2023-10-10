REM   
REM ======================================================================
REM ash/gen_ash_global_report_text.sql        Version 1.1   May 2020
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM 
REM Dependencias:
REM
REM
REM Notas:
REM
REM
REM Precauciones:
REM
REM ======================================================================
REM


VAR dbid NUMBER
VAR inst_id NUMBER

COL bdate NEW_VALUE def_bdate
COL edate NEW_VALUE def_edate
alter session set nls_date_language ='ENGLISH';

SET TERMOUT OFF

SELECT
    TO_CHAR(SYSDATE-1/24, 'YYYY-MM-DD HH24:MI') bdate
  , TO_CHAR(SYSDATE     , 'YYYY-MM-DD HH24:MI') edate
FROM
    dual
/

SET TERMOUT ON

ACCEPT bdate DATE FORMAT 'YYYY-MM-DD HH24:MI' DEFAULT '&def_bdate' PROMPT "Enter begin time [&def_bdate]: " 
ACCEPT edate DATE FORMAT 'YYYY-MM-DD HH24:MI' DEFAULT '&def_edate' PROMPT "Enter   end time [&def_edate]: " 
ACCEPT sid DEFAULT null PROMPT "Enter   sid: " 
ACCEPT sqlid DEFAULT null PROMPT "Enter   sqlid: " 

BEGIN
SELECT dbid INTO :dbid FROM v$database;
END;
/


PROMPT Spooling into ash_global_report.txt
SPOOL ash_global_report.txt
SET TERMOUT OFF PAGESIZE 0 HEADING OFF LINESIZE 1000 TRIMSPOOL ON TRIMOUT ON TAB OFF

SELECT * FROM TABLE(DBMS_WORKLOAD_REPOSITORY.ASH_GLOBAL_REPORT_TEXT(:dbid, null, TO_DATE('&bdate', 'YYYY-MM-DD HH24:MI'), TO_DATE('&edate', 'YYYY-MM-DD HH24:MI'), null, null, &sid, &sqlid ));

SPOOL OFF
SET TERMOUT ON PAGESIZE 5000 HEADING ON
PROMPT Done.

HOST &_start ash_global_report.txt
