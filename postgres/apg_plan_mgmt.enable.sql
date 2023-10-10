CREATE EXTENSION apg_plan_mgmt;
select extname,extversion from pg_extension where extname='apg_plan_mgmt';

show apg_plan_mgmt.capture_plan_baselines;
show apg_plan_mgmt.use_plan_baselines;


SELECT sql_hash, 
       plan_hash, 
       status, 
       enabled, 
       sql_text 
FROM   apg_plan_mgmt.dba_plans;


postgres=> create table test (num int);
CREATE TABLE
postgres=> insert into test values (10);
INSERT 0 1
postgres=> insert into test values (20);
INSERT 0 1
postgres=>

 select num from test where num=20;
 
 
SELECT sql_hash, 
       plan_hash, 
       status, 
       enabled, 
	    estimated_total_cost "cost",
       sql_text 
FROM   apg_plan_mgmt.dba_plans;

  sql_hash  | plan_hash  |  status  | enabled |           sql_text
------------+------------+----------+---------+-------------------------------
 -726849779 | -567055076 | Approved | t       | insert into test values (20);
 
 

postgres=> SELECT sql_hash,
postgres->        plan_hash,
postgres->        status,
postgres->        enabled,
postgres->        sql_text
postgres-> FROM   apg_plan_mgmt.dba_plans;
  sql_hash   | plan_hash  |  status  | enabled |              sql_text
-------------+------------+----------+---------+------------------------------------
  -726849779 | -567055076 | Approved | t       | insert into test values (20);
 -1649616980 | -573346532 | Approved | t       | select num from test where num=20;
(2 rows)


postgres=>
postgres=> explain (hashes true)  select num from test where num=20;
                      QUERY PLAN
------------------------------------------------------
 Seq Scan on test  (cost=0.00..41.88 rows=13 width=4)
   Filter: (num = 20)
 SQL Hash: -1649616980, Plan Hash: -573346532
(3 rows)


postgres=>