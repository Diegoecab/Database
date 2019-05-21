--dba_objects_invalid_owner
set pages 1000
set lines 200
set trims on
col owner for a20
col object_name for a40
col sql for a80

SELECT   owner,
           object_type,
           object_name,
           created,
           status,
           CASE object_type
              WHEN 'PACKAGE BODY'
              THEN
                    'ALTER PACKAGE '
                 || owner
                 || '.'
                 || object_name
                 || '  COMPILE BODY;'
              ELSE
                    'ALTER '
                 || object_type
                 || ' '
                 || owner
                 || '.'
                 || object_name
                 || '  compile;'
           END
              "SQL"
    FROM   dba_objects
   WHERE   status <> 'VALID' and owner like upper('%&owner%')
ORDER BY   1, 2, 3
/