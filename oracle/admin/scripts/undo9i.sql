prompt
prompt UNDO
prompt ====
prompt
prompt Los datos son válidos siempre y cuando el undo management = auto y 
prompt la base tenga la suficiente actividad de undo 
prompt y si es 10g el undo_retention no sea 0, ya que de este modo es automàtico
prompt el undo_retention me determina el tiempo que se puede utilizar el flashback query
prompt
prompt Los valores están redondeados.
prompt

select to_char(min(begin_time),'dd-mm-yyyy hh24:mi:ss'), to_char(max(begin_time),'dd-mm-yyyy hh24:mi:ss')  from v$undostat

select value "UNDO MANAGMENT" from v$parameter where name like 'undo_management';

SELECT round(d.undo_size/(1024*1024)) "ACTUAL UNDO SIZE [MByte]",
       SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
       ROUND((d.undo_size / (to_number(f.value) * g.undo_block_per_sec))) "OPTIMAL UNDO RETENTION [Sec]",
       round((TO_NUMBER(e.value) * TO_NUMBER(f.value) * g.undo_block_per_sec) / (1024*1024)) "NEEDED UNDO SIZE [MByte]",
       q.max_query_len "NEEDED UNDO RETENTION [Sec]"
  FROM (
       SELECT SUM(a.bytes) undo_size
          FROM v$datafile a,
               v$tablespace b,
               dba_tablespaces c
         WHERE c.contents = 'UNDO'
           AND c.status = 'ONLINE'
           AND b.name = c.tablespace_name
           AND a.ts# = b.ts#
       ) d,
       v$parameter e,
       v$parameter f,
       (
       SELECT MAX(undoblks/((end_time-begin_time)*3600*24))
              undo_block_per_sec
         FROM v$undostat
       ) g,
       (select max(maxquerylen) max_query_len from v$undostat) q
WHERE e.name = 'undo_retention'
  AND f.name = 'db_block_size';


