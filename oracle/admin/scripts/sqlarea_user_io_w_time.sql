--v$sqlarea_user_io_w_time
COL sql_text for a40
COL module for a20
SET pagesize 10000
select *
from
(select
     sql_text,
     sql_id,
     round(elapsed_time/1000000,2) elapsed_time_segundos,
     cpu_time,
     user_io_wait_time
  from
     sys.v_$sqlarea
  order by 5 desc)
where rownum < 6;