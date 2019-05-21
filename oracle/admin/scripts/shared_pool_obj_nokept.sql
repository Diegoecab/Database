--shared_pool_obj_nokept.sql
col name for a50
col owner for a30

SELECT   doc.owner, doc.NAME, doc.TYPE, doc.loads, round(doc.sharable_mem/1024) sharable_mem_kb,
         upper(ins.instance_name) instance_name
FROM     v$db_object_cache doc, v$instance ins
WHERE    doc.loads > 2
AND      doc.TYPE IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
AND KEPT = 'NO'
ORDER BY sharable_mem_kb
/