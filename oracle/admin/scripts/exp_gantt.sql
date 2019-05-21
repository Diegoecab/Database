col gantt for a175
with periods as
( select    '('||BKP_MODE||') '||schema_name||'@'||db_sid label,
            started                  start_date,
            finished                 end_date
    from    exp_queue
   where    book_date=trunc(sysdate)-1
     and    finished is not null
     and    db_sid like '%&sid%'
  order by started
)
, limits as
( select    min(started)  period_start,
            max(finished) period_end,
            140 width
    from    exp_queue
   where    book_date=trunc(sysdate)-1
     and    finished is not null
     and    db_sid like '%&sid%'
)
, bars as
( select   rpad(label, '30')||'|' activity,
           (start_date - period_start)/(period_end - period_start) * width from_pos,
           (end_date   - period_start)/(period_end - period_start) * width to_pos
  from     periods,
           limits
)
select
         --activity||lpad('I',from_pos)||rpad('#', to_pos - from_pos, '#')||'#' gantt
         activity||lpad('[',from_pos)||rpad('-', to_pos - from_pos, '-')||']' gantt
from     bars
union all
select rpad('_',width + 22,'_')
from   limits
union all
select rpad('Period',30)||'|'||to_char(period_start,'DD-MON-YYYY HH24:MI')||lpad(to_char(period_end,'DD-MON-YYYY HH24:MI' ), width - 18)
from   limits
union all
select rpad('Elapsed',30)||'|'||round((period_end-period_start)*1440/60)||':'||round(mod(round((period_end-period_start)*1440),60))||':'||round(mod(round(mod(round((period_end-period_start)*1440),60)),60))||' hs, ' ||round((period_end-period_start)*1440)||' minutes'
from   limits
union all
select rpad('_',width + 22,'_')
from   limits
/
