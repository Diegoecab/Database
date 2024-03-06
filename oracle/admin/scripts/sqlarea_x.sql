COL sql_text for a60
COL module for a20
SET pagesize 10000
accept SQL_ID prompt 'Ingrese SQL_ID:  '
SELECT   module, executions, rows_processed, round(elapsed_time/1000000,2) elapsed_time_segundos, sql_text
    FROM v$sqlarea
	where sql_id = '&SQL_ID'
ORDER BY module;