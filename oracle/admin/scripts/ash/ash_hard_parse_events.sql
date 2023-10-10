-- ash summary
with sum_by_session as (
        select ash.sql_id, ash.session_id, 
               trunc(ash.sample_time,'HH') timeframe, min(ash.sample_time) min_time, max(ash.sample_time) max_time,
               sum(ash.wait_time) + sum(ash.time_waited)  total_wait,
               ash.event, ash.p1, ash.p1text, ash.p2, ash.p2text, ash.p3, ash.p3text, ash.in_hard_parse
        from v$active_session_history ash
        join v$active_session_history sqlids on sqlids.sql_id = ash.sql_id
        where (ash.event like 'cursor: pin S%' or ash.in_hard_parse = 'Y' )
        and sqlids.event = 'cursor: pin S wait on X'
        group by  ash.sql_id,  ash.session_id, ash.event, ash.p1, ash.p1text, ash.p2, ash.p2text, ash.p3, ash.p3text, ash.in_hard_parse
                 ,trunc(ash.sample_time,'HH')
         )        
select s.sql_id, to_char(s.timeframe,'dd-Mon-RR HH24') timeframe,
       to_char(min(s.min_time),'HH24:MI:SS')||'-'||to_char(max(s.max_time),'HH24:MI:SS') timeperiod, 
       round(sum(total_wait)/1000000,2)  total_wait_in_s,
       s.event, s.p1, s.p1text, s.p2, s.p2text, s.p3, s.p3text, s.in_hard_parse, 
       listagg(s.session_id,',') within group (order by s.session_id) as sids
from sum_by_session s              
group by s.sql_id,  s.event, s.p1, s.p1text, s.p2, s.p2text, s.p3, s.p3text, s.in_hard_parse, s.timeframe
order by s.sql_id, s.in_hard_parse desc, s.timeframe;


select * from v$event_histogram 
where event = 'cursor: pin S wait on X';