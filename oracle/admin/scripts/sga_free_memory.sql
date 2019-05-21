--sga_free_memory

select POOL, round(bytes/1024/1024,0) FREE_MB
from v$sgastat
where name like '%free memory%';

PROMPT Para ver la memoria libre en toda la SGA:
PROMPT SELECT KSMCHCLS CLASS, COUNT(KSMCHCLS) NUM, SUM(KSMCHSIZ) SIZ, 
PROMPT To_char( ((SUM(KSMCHSIZ)/COUNT(KSMCHCLS)/1024)),'999,999.00')||'k' "AVG SIZE" 
PROMPT FROM X$KSMSP GROUP BY KSMCHCLS;
