--shared_pool_sql_highmem.sql


compute sum of Mem_KB on report
col Stmt for a100
set lines 400

SELECT substr(sql_text,1,40) "Stmt", sql_id,count(*),
round(sum(sharable_mem)/1024)    "Mem_KB",
parsing_schema_name,
sum(users_opening)   "Open",  
sum(executions)      "Exec"         
FROM v$sql
GROUP BY substr(sql_text,1,40),sql_id,parsing_schema_name  
HAVING sum(sharable_mem/1024) > 1024;