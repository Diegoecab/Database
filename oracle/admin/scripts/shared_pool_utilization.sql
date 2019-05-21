--shared_pool_utilization.sql
COL good_percent for a14
COL good for a15
COL garbage for a15
COL users for a15
COL inst_id for a7
COL nopr for 99
TTITLE 'Shared Pool Utilization'
SPOOL sql_garbage
SELECT   1 nopr, TO_CHAR (a.inst_id) inst_id, a.users users,
         TO_CHAR (a.garbage, '9,999,999,999') garbage,
         TO_CHAR (b.good, '9,999,999,999') good,
         TO_CHAR ((b.good / (b.good + a.garbage)) * 100,
                  '9,999,999.999'
                 ) good_percent
    FROM (SELECT   a.inst_id, b.username users,
                   SUM (a.sharable_mem + a.persistent_mem) garbage,
                   TO_NUMBER (NULL) good
              FROM SYS.gv_$sqlarea a, dba_users b
             WHERE (a.parsing_user_id = b.user_id AND a.executions <= 1)
          GROUP BY a.inst_id, b.username
          UNION
          SELECT DISTINCT c.inst_id, b.username users,
                          TO_NUMBER (NULL) garbage,
                          SUM (c.sharable_mem + c.persistent_mem) good
                     FROM dba_users b, SYS.gv_$sqlarea c
                    WHERE (b.user_id = c.parsing_user_id AND c.executions > 1
                          )
                 GROUP BY c.inst_id, b.username) a,
         (SELECT   a.inst_id, b.username users,
                   SUM (a.sharable_mem + a.persistent_mem) garbage,
                   TO_NUMBER (NULL) good
              FROM SYS.gv_$sqlarea a, dba_users b
             WHERE (a.parsing_user_id = b.user_id AND a.executions <= 1)
          GROUP BY a.inst_id, b.username
          UNION
          SELECT DISTINCT c.inst_id, b.username users,
                          TO_NUMBER (NULL) garbage,
                          SUM (c.sharable_mem + c.persistent_mem) good
                     FROM dba_users b, SYS.gv_$sqlarea c
                    WHERE (b.user_id = c.parsing_user_id AND c.executions > 1
                          )
                 GROUP BY c.inst_id, b.username) b
   WHERE a.users = b.users
     AND a.inst_id = b.inst_id
     AND a.garbage IS NOT NULL
     AND b.good IS NOT NULL
UNION
SELECT   2 nopr, '-------' inst_id, '-------------' users,
         '--------------' garbage, '--------------' good,
         '--------------' good_percent
    FROM DUAL
UNION
SELECT   3 nopr, TO_CHAR (a.inst_id, '999999'),
         TO_CHAR (COUNT (a.users)) users,
         TO_CHAR (SUM (a.garbage), '9,999,999,999') garbage,
         TO_CHAR (SUM (b.good), '9,999,999,999') good,
         TO_CHAR (((SUM (b.good) / (SUM (b.good) + SUM (a.garbage))) * 100),
                  '9,999,999.999'
                 ) good_percent
    FROM (SELECT   a.inst_id, b.username users,
                   SUM (a.sharable_mem + a.persistent_mem) garbage,
                   TO_NUMBER (NULL) good
              FROM SYS.gv_$sqlarea a, dba_users b
             WHERE (a.parsing_user_id = b.user_id AND a.executions <= 1)
          GROUP BY a.inst_id, b.username
          UNION
          SELECT DISTINCT c.inst_id, b.username users,
                          TO_NUMBER (NULL) garbage,
                          SUM (c.sharable_mem + c.persistent_mem) good
                     FROM dba_users b, SYS.gv_$sqlarea c
                    WHERE (b.user_id = c.parsing_user_id AND c.executions > 1
                          )
                 GROUP BY c.inst_id, b.username) a,
         (SELECT   a.inst_id, b.username users,
                   SUM (a.sharable_mem + a.persistent_mem) garbage,
                   TO_NUMBER (NULL) good
              FROM SYS.gv_$sqlarea a, dba_users b
             WHERE (a.parsing_user_id = b.user_id AND a.executions <= 1)
          GROUP BY a.inst_id, b.username
          UNION
          SELECT DISTINCT c.inst_id, b.username users,
                          TO_NUMBER (NULL) garbage,
                          SUM (c.sharable_mem + c.persistent_mem) good
                     FROM dba_users b, SYS.gv_$sqlarea c
                    WHERE (b.user_id = c.parsing_user_id AND c.executions > 1
                          )
                 GROUP BY c.inst_id, b.username) b
   WHERE a.users = b.users
     AND a.inst_id = b.inst_id
     AND a.garbage IS NOT NULL
     AND b.good IS NOT NULL
GROUP BY a.inst_id
ORDER BY 1,2 DESC
/
SPOOL off
TTITLE off
SET pages 22