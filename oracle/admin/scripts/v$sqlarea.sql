--v$sqlarea
set lines 600
col sql_text for a100
col module for a20
set pagesize 10000

select *
from
(select substr(sql_text,1,100),
        sql_id,
		rows_processed,
        elapsed_time,
        cpu_time,
        user_io_wait_time
from    sys.v_$sqlarea
order by 6 desc)
where rownum < 10;