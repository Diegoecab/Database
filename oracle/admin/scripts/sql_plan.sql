--sql_plan sqlid
SET LINES 1000
SET PAGES 1000
COLUMN I FORMAT A3


  SELECT /*+ NO_MERGE */ 
         ROWNUM-1||
   DECODE(access_predicates,NULL,DECODE(filter_predicates,NULL,'','*'),'*') "I",
         SUBSTR(LPAD(' ',(DEPTH-1))||
   OPERATION,1,40)||
   DECODE(OPTIONS,NULL,'',' (' 
   || OPTIONS 
   || ')') "Operation",
         SUBSTR(OBJECT_NAME,1,30) "Object Name",
         cardinality "# Rows",
         bytes,
         cost,
         time
    FROM (
         SELECT * 
           FROM gv$sql_plan 
          WHERE sql_id = '&1'
         ) plan
ORDER BY id
/