--cpu_hist_per_module.sql
--CPU Time per module
set pages 4000
set lines 400
col Module for a50
SELECT   mymodule "Module", round(SUM (cpu_time)) "CPU Time", round(SUM (wait_time)) "Wait Time",
         round(SUM (cpu_time) + SUM (wait_time)) "Total Time"
    FROM (SELECT a.module mymodule,
                 (CASE (session_state)
                     WHEN 'ON CPU'
                        THEN wait_time / 100
                  END
                 ) cpu_time,
                 (CASE (session_state)
                     WHEN 'WAITING'
                        THEN time_waited / 100
                  END
                 ) wait_time
            FROM dba_hist_active_sess_history a, dba_hist_snapshot b
           WHERE b.end_interval_time > sysdate-&days
             AND a.snap_id = b.snap_id
             --AND a.user_id NOT IN (0, 5)
             AND a.instance_number = b.instance_number)
GROUP BY mymodule
  HAVING SUM (cpu_time) + SUM (wait_time) > 0
ORDER BY 2 DESC