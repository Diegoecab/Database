--db_wait_time_ratio.sql minute
set pages 100
set lines 120
set verify off

SELECT
  to_char(begin_time,'DD-MM-YY HH24:MI:SS') begin_time ,metric_name,
value "Average Wait time %"
FROM
   gv$sysmetric_history
WHERE metric_name = 'Database Wait Time Ratio'
and (begin_time > SYSDATE - INTERVAL '&1' MINUTE)
order by 1
/


SELECT
  metric_name,
  ROUND(AVG(value),1) "Average Wait time %"
FROM
   v$sysmetric_history
WHERE metric_name = 'Database Wait Time Ratio'
and (begin_time > SYSDATE - INTERVAL '&1' MINUTE)
GROUP BY metric_name;
