--inserts_x_min.sql
SELECT SUBSTR (sql_text, INSTR (sql_text, 'INTO '), 30) table_name,
       rows_processed,
       ROUND (  (SYSDATE - TO_DATE (first_load_time, 'YYYY-MM-DD HH24:MI:SS')
                )
              * 24
              * 60,
              1
             ) minutes,
       TRUNC (  rows_processed
              / (  (  SYSDATE
                    - TO_DATE (first_load_time, 'YYYY-MM-DD HH24:MI:SS')
                   )
                 * 24
                 * 60
                )
             ) rows_per_minute
  FROM SYS.v_$sqlarea
 WHERE sql_text LIKE 'INSERT%INTO%' AND open_versions > 0
/