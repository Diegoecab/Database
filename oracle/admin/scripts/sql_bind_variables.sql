
set lines 400

col sql_text for a100
col value_string for a20

 SELECT
 name,
 position,
 DATATYPE_string,
 VALUE_STRING
FROM
  gv$sql_bind_capture b,
  gv$sqlarea          a
WHERE
   b.sql_id = '5ujtj95kvk645'
 --  and a.plan_hash_value = '&plan_hash_value'
   --and parsing_schema_name = '&parsing_schema_name'
AND
   b.sql_id = a.sql_id;
   
   
   
   -- tab=Last captured binds
select name, value_string, datatype_string, last_captured
from   ( select distinct name, value_string, datatype_string, b.last_captured, dense_rank() over(partition by name order by last_captured desc) as capture_seq
         from   dba_hist_sqlbind b
         where  b.sql_id = '5ujtj95kvk645'
         and    b.was_captured = 'YES' )
where  capture_seq = 1
order by lpad(ltrim(name,':B'),30);