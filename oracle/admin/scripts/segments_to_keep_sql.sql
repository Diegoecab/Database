--segments_to_keep_Sql.sql
PROMPT ONLINE:
SELECT    'ALTER '
       || SEGMENT_TYPE
       || ' '
       || OWNER
       || '.'
       || SEGMENT_NAME
       || ' storage (buffer_pool keep);' SQL
  FROM DBAS.OBJETOS_TO_KEEP;
  
set linesize 120
col sql for a80
prompt
PROMPT TABLA DBAS.SEGMENTS_TO_KEEP
prompt
SELECT    'ALTER '
       || SEGMENT_TYPE
       || ' '
       || OWNER
       || '.'
       || SEGMENT_NAME
       || ' storage (buffer_pool keep);' SQL, MB
  FROM DBAS.SEGMENTS_TO_KEEP;

prompt
prompt luego de subir los objetos, ejecutar truncate table DBAS.SEGMENTS_TO_KEEP;
prompt