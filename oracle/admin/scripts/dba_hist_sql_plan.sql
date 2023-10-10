--dba_hist_sql_plan sqlid plan_hash_value
SET LINES 1000
SET PAGES 1000
col object_name for a20 truncate
col operation for a20 truncate
col filter_predicates for a20
col access_predicates for a20
COLUMN I FORMAT A3


  SELECT /*+ NO_MERGE */ 
         ROWNUM-1||
   DECODE(access_predicates,NULL,DECODE(filter_predicates,NULL,'','*'),'*') "I",
         SUBSTR(LPAD(' ',(DEPTH-1))||
   OPERATION,1,40)||
   DECODE(OPTIONS,NULL,'',' (' 
   || OPTIONS 
   || ')') operation,
         SUBSTR(OBJECT_NAME,1,30) object_name,
         cardinality "# Rows",
		/* filter_predicates,
		 access_predicates,*/
         bytes,
         cost,
         time
    FROM (
         SELECT * 
           FROM dba_hist_sql_plan
          WHERE sql_id = '&1'
		  and plan_hash_value='&2'
         ) plan
ORDER BY id
/