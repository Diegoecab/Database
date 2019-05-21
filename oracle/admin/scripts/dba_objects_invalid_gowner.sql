--dba_objects_invalid_gowner
set pages 1000
set lines 200
set trims on
set verify off
col owner for a20
col object_name for a40
col sql for a80
break on owner on report
compute sum of tot on report

SELECT   owner, count(*) tot
   FROM   dba_objects
   WHERE   status <> 'VALID' and owner like upper('%&owner%')
   group by owner
ORDER BY   1
/