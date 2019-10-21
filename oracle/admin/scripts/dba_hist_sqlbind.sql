--dba_hist_sqlbind.sql
col VALUE_ANYDATA for a10
col value_string for a20
set lines 900
select VALUE_STRING, a.* from DBA_HIST_SQLBIND a
WHERE
  sql_id = '&SQLID' --and snap_id = (select max(snap_id) from DBA_HIST_SQLBIND b WHERE b.sql_id = a.sql_id)
  order by snap_id, position;