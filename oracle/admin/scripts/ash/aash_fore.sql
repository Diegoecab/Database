select CNT,
( CNT / ((CAST(sysdate AS DATE) - CAST(sysdate-7 AS DATE)) * 86400)) as AAS,
round(( CNT / ((CAST(sysdate AS DATE) - CAST(sysdate-7 AS DATE)) * 86400))*100/( select to_number(value) cpu_count from v$parameter where name='cpu_count'),1) AAS_FORE_PCT
from (
 select  10 * (COUNT(*)) as CNT
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a where session_type <> 'BACKGROUND'
and sample_time BETWEEN sysdate-7 AND sysdate
 )
/
