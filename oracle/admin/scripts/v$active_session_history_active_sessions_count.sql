/*Max active sessions count during last hour*/

select max(cnt) from 
(SELECT count(*) cnt, SESSION_STATE, WAIT_CLASS, sample_time FROM gv$active_session_history where  
SAMPLE_TIME > SYSDATE - INTERVAL '60' MINUTE AND SAMPLE_TIME <= TRUNC(SYSDATE, 'MI') 
group by session_state, wait_class, sample_time order by sample_time)
/
