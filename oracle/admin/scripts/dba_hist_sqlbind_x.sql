--dba_hist_sqlbind_x
set lines 400
set pages 1000
col value_string for a50
col value_anydata for a50
col name for a10



break on snap_id skip 1


select 
snap_id,name,position,datatype_string, last_captured,value_string
 from DBA_HIST_SQLBIND where SQL_ID='&SQLID'
and last_captured > sysdate -1
order by SNAP_ID,POSITION
/