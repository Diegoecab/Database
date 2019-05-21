--segments_to_keep.sql
Break on segment_name on report 
compute sum of mb on report 
col owner for a15
col segment_name for a30
set pagesize 100

prompt Vista Online
SELECT   a.*, ROUND (SUM (BYTES / 1024 / 1024), 1) mb
    FROM dbas.objetos_to_keep a JOIN dba_segments b
         ON b.owner = a.owner
       AND b.segment_name = a.segment_name
       AND b.segment_type = a.segment_type
GROUP BY a.owner, a.segment_type, a.segment_name
ORDER BY MB
/

prompt tabla dbas.segments_to_keep
select distinct owner,segment_type,segment_name,MB from dbas.segments_to_keep order by MB
/

prompt
prompt **************************************************
Prompt Ejecutar segments_to_keep_sql.sql para
prompt extraer ddl para levantar los objetos a keep
prompt **************************************************
prompt
prompt **************************************************
Prompt Ejecutar segments_keep.sql para
prompt ver cuales son los segmentos que estan en keep
prompt **************************************************