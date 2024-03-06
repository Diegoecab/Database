Break on Date on report 
compute sum of Megs_Tran on report 
set pagesize 100
ttitle "Transacciones por dia en MB Semana anterior"
SELECT  to_char(first_time, 'dd-mm-yyyy') "Date",
        count(*) * (Select
       distinct bytes / 1024 / 1024
from sys.v_$log) "Megs_Tran"    
FROM    V$log_history
where first_time < trunc(sysdate - 7)
and first_time > trunc(sysdate - 14)
group by to_char(first_time, 'dd-mm-yyyy')
order by 1
/

Break on Date on report 
compute sum of Megs_Tran on report 
set pagesize 100
ttitle "Transacciones por dia en MB"
SELECT  to_char(first_time, 'dd-mm-yyyy') "Date",
        count(*) * (Select
       distinct bytes / 1024 / 1024
from sys.v_$log) "Megs_Tran"    
FROM    V$log_history
where first_time > trunc(sysdate - 7)
group by to_char(first_time, 'dd-mm-yyyy')
order by 1
/