--@ash/ashtop_sql sysdate-1 sysdate username<>'SYS'
--@ash/ashtop_sql to_date('06-05-20:10:00','DD-MM-YY:HH24:MI') sysdate
--@ash/ashtop_sql sysdate+(1/1440*-60) sysdate 1=1

--COL p1     FOR 99999999999999
--COL p2     FOR 99999999999999
--COL p3     FOR 99999999999999
COL p1text              FOR A30 word_wrap
COL p2text              FOR A30 word_wrap
COL p3text              FOR A30 word_wrap
COL p1hex               FOR A17
COL p2hex               FOR A17
COL p3hex               FOR A17
COL AAS                 FOR 9999.9
COL totalseconds HEAD "Tot|Sec" FOR 999999
COL dist_sqlexec_seen HEAD "Dis|tin|ct|Execs|Seen" FOR 999999
COL event               FOR A15 TRUNCATE
COL EVENT2              FOR A15 TRUNCATE
COL time_model_name     FOR A15 TRUNCATE
COL program2            FOR A40 TRUNCATE
COL username            FOR A20 TRUNCATE
COL sql_text 			FOR A35 TRUNCATE
COL obj                 FOR A30
COL objt                FOR A50
COL sql_opname          FOR A20
COL top_level_call_name FOR A30
COL wait_class          FOR A15
COL machine 			FOR A20 TRUNCATE
COL program 			FOR A20 TRUNCATE
COL module 				FOR A12 TRUNCATE
COL awr_info			FOR A70 TRUNCATE 
COL inst_id 			HEAD "Inst|ID" FOR 99 
set lines 300
set pages 10000
set verify off

 select
     *
  from (
     select
        sql_id,
		username,
        count(*) as db_time,
        round(count(*)*100/sum(count(*)) over (), 2) as pct_activity
     from
        gv$active_session_history a,  dba_users u
     where
        sample_time BETWEEN &1 AND &2
		AND &3
		and a.user_id = u.user_id (+)
        and session_type <> 'BACKGROUND'
     group by
        sql_id, username
     order by
        count(*) desc)
  where
     rownum <=5;