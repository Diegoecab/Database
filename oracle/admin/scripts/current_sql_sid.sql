REM 	
col sid for 999
col sql_text for a120
col osuser for a15
col username for a15
col program for a20
set verify off
set feedback off
set pagesize 1000
set linesize 200
set long 1000000

accept SID prompt 'Ingrese SID: '
prompt
prompt
select hash_value from v$sql WHERE address =
            (SELECT DECODE (RAWTOHEX (sql_address),
                            '00', prev_sql_addr,
                            sql_address
                           )
               FROM v$session
              WHERE SID = '&SID' )
/
prompt
select sql_id from v$sql WHERE address =
            (SELECT DECODE (RAWTOHEX (sql_address),
                            '00', prev_sql_addr,
                            sql_address
                           )
               FROM v$session
              WHERE SID = '&SID' )
/
prompt
set heading off
select sql_fulltext from v$sql WHERE address =
            (SELECT DECODE (RAWTOHEX (sql_address),
                            '00', prev_sql_addr,
                            sql_address
                           )
               FROM v$session
              WHERE SID = '&SID' )
/

set heading on
prompt
set feedback on