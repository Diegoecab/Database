--shared_pool_sql_highmem.sql


compute sum of Mem_KB on report
compute sum of sum_Mem_KB on report
col Stmt for a100
set lines 800

SELECT substr(sql_text,1,40) "Stmt", sql_id,count(*),
round(sum(sharable_mem)/1024)    "Mem_KB",
parsing_schema_name,
sum(users_opening)   "Open",  
sum(executions)      "Exec"         
FROM v$sql
where parsing_schema_name='ECHEQ'
GROUP BY substr(sql_text,1,40),sql_id,parsing_schema_name  
HAVING sum(sharable_mem/1024) > 100;


select parsing_schema_name, sum("Mem_KB") sum_Mem_KB from (
SELECT substr(sql_text,1,40) "Stmt", sql_id,count(*),
round(sum(sharable_mem)/1024)    "Mem_KB",
parsing_schema_name,
sum(users_opening)   "Open",  
sum(executions)      "Exec"         
FROM v$sql
GROUP BY substr(sql_text,1,40),sql_id,parsing_schema_name  
--HAVING sum(sharable_mem/1024) > 100
) group by parsing_schema_name
order by 2
;


/*
PARSING_SCHEMA_NAME            SUM("MEM_KB")
------------------------------ -------------
EMERDBPYC                                 19
ECHEQ                                1299744
BRE_GRAFANA                              103
DBSNMP                                  3131
C##GRAFANA                               114
SYS                                    12093
LBACSYS                                   31



*/

SELECT substr(sql_text,1,40) "Stmt", sql_id,count(*),
round(sum(sharable_mem)/1024)    "Mem_KB",
parsing_schema_name,
sum(users_opening)   "Open",  
sum(executions)      "Exec"         
FROM v$sql
where parsing_schema_name='ECHEQ'
GROUP BY substr(sql_text,1,40),sql_id,parsing_schema_name 
;
--HAVING sum(sharable_mem/1024) > 100;


select "Stmt", count(*) from (
SELECT substr(sql_text,1,30) "Stmt", sql_id,count(*),
round(sum(sharable_mem)/1024)    "Mem_KB",
parsing_schema_name,
sum(users_opening)   "Open",  
sum(executions)      "Exec"         
FROM v$sql
where parsing_schema_name='ECHEQ'
GROUP BY substr(sql_text,1,30),sql_id,parsing_schema_name
) group by "Stmt"
HAVING count("Stmt") > 100 order by 2;

