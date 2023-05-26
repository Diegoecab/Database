-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

--------------------------------------------------------------------------------
-- 
-- File name:   ashtop.sql v1.2
-- Purpose:     Display top ASH time (count of ASH samples) grouped by your
--              specified dimensions
--              
-- Author:      Tanel Poder
-- Copyright:   (c) http://blog.tanelpoder.com
--              
-- Usage:       
--     @ashtop <grouping_cols> <filters> <fromtime> <totime>
--
-- Example:
--     Last hour
--     @ash/ashtop username,sql_id session_type='BACKGROUND' sysdate+(1/1440*-90) sysdate
--		@ash/ashtop sql_id "event='SQL*Net message from dblink'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop event "sql_id='91bj4f469kmh8'" sysdate+(1/1440*-15) sysdate
--		@ash/ashtop wait_class,username,sql_id "inst_id=2 and wait_class='User I/O' and MODULE not like 'Data Pump Wo%' "sysdate+(1/1440*-90) sysdate
--		@ash/ashtop username--,count(distinct(sql_id)) "inst_id=2 and wait_class='User I/O' and MODULE not like 'Data Pump Wo%' "sysdate+(1/1440*-90) sysdate
--		@ash/ashtop sql_id "username='COMEX_USER' and event='SQL*Net message from dblink'" sysdate+(1/1440*-120) sysdate
--		@ash/ashtop object_name "sql_id='cwkhcmw4u9afb'-- and sql_plan_hash_value='1994566811'" sysdate+(1/1440*-150) sysdate
--		@ash/ashtop event 1=1 sysdate+(1/1440*-60) sysdate
--		@ash/ashtop wait_class,event "Event like 'enq: TX - row lock conten%'" sysdate+(1/1440*-120) sysdate
--		@ash/ashtop session_type,program,module,sql_id "wait_class='Scheduler' --and sql_id='5hq4sk70mb9nx'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop wait_class,event "sql_id='7tuu7wmpdtf18'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop wait_class,event,object_name,session_state "sql_id='8n0jvgdz8jv84' and sql_plan_hash_value='1735514003' " trunc(sysdate) sysdate
-- 		@ash/ashtop wait_class,event 1=1 sysdate+(1/1440*-10) sysdate
-- 		@ash/ashtop username "1=1 --wait_class='Other' and event='OJVM: Generic'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop username "wait_class is null" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop program,username 1=1 sysdate+(1/1440*-60) sysdate
--		@ash/ashtop wait_class,event 1=1 sysdate+(1/1440*-15) sysdate
--		@ash/ashtop wait_class 1=1 sysdate+(1/1440*-40) sysdate+(1/1440*-20)
--		@ash/ashtop wait_class session_state='WAITING' sysdate+(1/1440*-3) sysdate
--		@ash/ashtop wait_class,event "sql_id='7x0w72nw20ngf' --and username='BUSINESSDATA_CHILE'" sysdate+(1/1440*-40) sysdate
--     @ash/ashtoph wait_class,event "sql_id='2xkaw74uaajbp' -- and username='BUSINESSDATA_URUGUAY'" sysdate+(1/1440*-340) sysdate+(1/1440*-300)
--	   @ash/ashtop wait_class,event,session_state,username,sid,serial,machine,objt "username like 'S_CO_PRD_K%'" sysdate+(1/1440*-180) sysdate
--		@ash/ashtop wait_class,event,username,sid,serial,sql_id "wait_class in ('Network')" sysdate+(1/1440*-90) sysdate
--		@ash/ashtop inst_id,wait_class,event,username 1=1 sysdate+(1/1440*-30) sysdate
--	   @ash/ashtop username "event='cell single block physical read'" sysdate+(1/1440*-180) sysdate
----	   @ash/ashtop session_type,session_state,wait_class,event,time_model_name,module,username,sql_id "wait_class='User I/O'" sysdate+(1/1440*-60) sysdate
--	   @ash/ashtop session_type,session_state,wait_class,event,time_model_name,module,username,sql_id,objt "wait_class='User I/O'" sysdate+(1/1440*-120) sysdate
--		@ash/ashtop event,object_name,sql_plan_operation,sql_plan_options,sql_id "wait_class='User I/O' and event='direct path read'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop event,sql_id,object_name,sql_plan_operation,sql_plan_options "wait_class='User I/O' and object_name='GO_EVENTS'" sysdate+(1/1440*-180) sysdate
--		@ash/ashtop session_type,session_state,wait_class,event,time_model_name,module,inst_id,username,sql_id 1=1 sysdate+(1/1440*-120) sysdate
-- @ash/ashtop wait_class,event,module,session_state,inst_id 1=1 "to_date('14-AUG-20 13:05','DD-MON-YY HH24:MI')" "to_date('14-AUG-20 13:21','DD-MON-YY HH24:MI')"
--@ash/ashtop wait_class,event,module,session_state,inst_id,username,sql_id,obj "wait_class='User I/O'" "to_date('14-AUG-20 13:05','DD-MON-YY HH24:MI')" "to_date('14-AUG-20 13:21','DD-MON-YY HH24:MI')"
--@ash/ashtop wait_class,session_state,inst_id 1=1 "to_date('14-AUG-20 13:05','DD-MON-YY HH24:MI')" "to_date('14-AUG-20 13:21','DD-MON-YY HH24:MI')"
--@ash/ashtop wait_class,event,module,session_state,inst_id,time_model_name,username,obj "sql_id='7wdpzn2a2d367'" trunc(sysdate-2) sysdate
--
--
--		@ash/ashtop wait_class,session_state,event,username,sql_id  "session_type='FOREGROUND' and session_state='WAITING'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop wait_class,session_state "session_type='FOREGROUND' and username not like 'OGG% and username != 'SYS' " sysdate+(1/1440*-60) sysdate
-- 		@ash/ashtop wait_class,inst_id,event "session_type='FOREGROUND' and session_state='WAITING'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtop wait_class,event,session_state "username='S_RG_ESB' -- and session_state='WAITING'" sysdate+(1/1440*-60) sysdate
--		@ash/ashtoph session_state "username='S_RG_ESB' -- and session_state='WAITING'" "to_date('18-AUG-20 11:00','DD-MON-YY HH24:MI')" "to_date('18-AUG-20 15:00','DD-MON-YY HH24:MI')"
--		@ash/ashtoph session_state "username='CAMPAIGN_AR' -- and session_state='WAITING'"  sysdate+(1/1440*-60) sysdate
--		@ash/ashtoph session_state,wait_class,event,sql_id "username='CAMPAIGN_AR' -- and session_state='WAITING'" sysdate+(1/1440*-60) sysdate
-- 		
--	   @ash/ashtop username,sql_id session_type='BACKGROUND' sysdate+(1/1440*-60) sysdate
--	   @ash/ashtop sid,serial,username,session_state,event sql_id='1ntpr2hkbspd9' sysdate+(1/1440*-200) sysdate
--	   @ash\ashtop username,sql_id session_type='FOREGROUND' "SYSDATE-INTERVAL '&minutes' MINUTE" sysdate
--	   @ash/ashtop username,sql_id session_type='FOREGROUND' to_date('17-JUL-2004:00:00','DD-MON-YYHH24:MI:SS') to_date('17-JUL-2010:00:00','DD-MON-YYHH24:MI:SS')
--	 @ash/ashtop session_state,event,sql_id "username='FACTURACION'" sysdate+(1/1440*-120) sysdate
--   @ash/ashtop session_state,event,sql_id "sid='5813'" sysdate+(1/1440*-180) sysdate
--   @ash/ashtop session_state,sql_id,event "sid='2331' and serial='57624' " sysdate+(1/1440*-600) sysdate
-- @ash/ashtop session_state,sql_id,event "module like 'Data Pump %'" sysdate+(1/1440*-15) sysdate
-- @ash/ashtop wait_class,username,sid,serial,inst_id,session_state,sql_id "event='db file sequential read'" sysdate+(1/1440*-60)  sysdate
-- @ash/ashtop username,session_state,event,module,time_model_name,machine,objt,sql_id "event2 like 'enq: TX - row l%'" sysdate+(1/1440*-60) sysdate

--
--User IO
--@ash/ashtop event,object_name,inst_id,sql_id,sid,serial,sql_plan_operation,sql_plan_options "wait_class='User I/O' and username='CUSTOMER' and object_name='GO_EVENTS'" sysdate+(1/1440*-3) sysdate
--@ash/ashtop event,object_name,inst_id,sql_id,sid,serial,sql_plan_operation,sql_plan_options "wait_class='User I/O' and username='CUSTOMER' and object_name='GO_EVENTS'" sysdate+(1/1440*-10) sysdate
--@ash/ashtop username,sql_id "wait_class='User I/O'" sysdate+(1/1440*-30) sysdate
--@ash/ashtop event,sql_id "username='EDW_PROD_LOADER' and wait_class='User I/O'" sysdate+(1/1440*-120) sysdate
--@ash/ashtop sql_id "username='EDW_PROD_LOADER' and wait_class='User I/O'" sysdate+(1/1440*-120) sysdate
--@ash/ashtop sql_id "username='EDW_PROD_LOADER' and wait_class='User I/O' and object_name in ('SA_EXTERNAL_CALL_HISTORY','F_FOTO_CONTRATO_PRODUCTO')" sysdate+(1/1440*-120) sysdate
--@ash/ashtop object_name "username='EDW_PROD_LOADER' and wait_class='User I/O'" sysdate+(1/1440*-120) sysdate
--@ash/ashtop object_name 1=1 sysdate+(1/1440*-120) sysdate
--@ash/ashtop username "module like 'osh@rgbisapp%'" sysdate+(1/1440*-120) sysdate
--@ash/ashtop module 1=1 sysdate+(1/1440*-120) sysdate
--@ash/ashtop wait_class,event,sql_plan_operation,sql_plan_options "sql_id='6jhhm0dfw8q7n'" sysdate+(1/1440*-120) sysdate
--@ash/ashtop wait_class,event 1=1 sysdate+(1/1440*-120) sysdate+(1/1440*-30)
 
-- Other:
--     This script uses only the in-memory GV$ACTIVE_SESSION_HISTORY, use
--     @dashtop.sql for accessiong the DBA_HIST_ACTIVE_SESS_HISTORY archive
-- Notes: 12-Apr-2020 Modified by Diego Cabrera
--			Adding historic view of ASH
--			Adding AAS summary
--
-- AAS =  Average Active Session => load on the database = DB Time/elapsed ~ = count(*)/elapsed
-- If AAS ~ 0 then the database is idle.
--If AAS < 1 the database is fine
--If AAS << # of CPUs the database is fine
--If AAS ~ # of CPUs there might be performance problems
--If AAS > # of CPUs there is definitely a performance problem.
--------------------------------------------------------------------------------
COL "%This" FOR A7
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
COL event               FOR A30 TRUNCATE
COL EVENT2              FOR A25 TRUNCATE
COL time_model_name     FOR A15 TRUNCATE
COL program2            FOR A40 TRUNCATE
COL username            FOR A20 TRUNCATE
COL sql_text 			FOR A45 TRUNCATE
COL obj                 FOR A30
COL objt                FOR A35 TRUNCATE
COL object_name 		FOR A35 TRUNCATE
COL sql_opname          FOR A20
COL top_level_call_name FOR A30
COL wait_class          FOR A15
COL machine 			FOR A15 TRUNCATE
COL program 			FOR A20 TRUNCATE
COL module 				FOR A12 TRUNCATE
COL inst_id 			HEAD "Inst|ID" FOR 99 
col sql_plan_operation for a15 truncate 
col sql_plan_options for a15 truncate 
col cpu_count			FOR 999
set lines 350
set pages 10000
set verify off
col FIRST_SEEN for a20
col LAST_SEEN for a20

select inst_id, cpu_count, AAS, case when AAS < cpu_count then 'OK' when AAS = cpu_count then 'WARNING' else 'CRITICAL' end status from (
select inst_id, ( select to_number(value) cpu_count from gv$parameter
                 where name='cpu_count' and inst_id=a.inst_id) cpu_count,
ROUND(COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS from 
gv$active_session_history a
where sample_time BETWEEN &3 AND &4
group by inst_id);



SELECT
    h.*--, (select distinct(cast(substr(sql_text,1,80) as varchar(100 byte))) from dba_hist_sqltext s where s.sql_id = h.sql_id) sql_text
FROM (
    WITH bclass AS (SELECT class, ROWNUM r from v$waitstat)
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , &1
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
	  /*, time_model_name
	  --, program
	  , machine
	  , module
--    , MAX(sql_exec_id) - MIN(sql_exec_id) */
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
	  /*, event2
	  , inst_id
	  , objt*/
    FROM
        (SELECT
             a.*
           , session_id sid
           , session_serial# serial
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p1 ELSE null END, '0XXXXXXXXXXXXXXX') p1hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p2 ELSE null END, '0XXXXXXXXXXXXXXX') p2hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p3 ELSE null END, '0XXXXXXXXXXXXXXX') p3hex
           , NVL(event, session_state)||
                CASE 
                    WHEN event like 'enq%' AND session_state = 'WAITING'
                    THEN ' [mode='||BITAND(p1, POWER(2,14)-1)||']'
                    WHEN a.event IN (SELECT name FROM v$event_name WHERE parameter3 = 'class#')
                    THEN ' ['||CASE WHEN a.p3 <= (SELECT MAX(r) FROM bclass) 
                               THEN (SELECT class FROM bclass WHERE r = a.p3)
                               ELSE (SELECT DECODE(MOD(BITAND(a.p3,TO_NUMBER('FFFF','XXXX')) - 17,2),0,'undo header',1,'undo data', 'error') FROM dual)
                               END  ||']' 
                    ELSE null 
                END event2 -- event is NULL in ASH if the session is not waiting (session_state = ON CPU)
           , CASE WHEN a.session_type = 'BACKGROUND' OR REGEXP_LIKE(a.program, '.*\([PJ]\d+\)') THEN
                REGEXP_REPLACE(SUBSTR(a.program,INSTR(a.program,'(')), '\d', 'n')
             ELSE
                '('||REGEXP_REPLACE(REGEXP_REPLACE(a.program, '(.*)@(.*)(\(.*\))', '\1'), '\d', 'n')||')'
             END || ' ' program2
           , CASE WHEN BITAND(time_model, POWER(2, 01)) = POWER(2, 01) THEN 'DBTIME '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 02)) = POWER(2, 02) THEN 'BACKGROUND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 03)) = POWER(2, 03) THEN 'CONNECTION_MGMT '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 04)) = POWER(2, 04) THEN 'PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 05)) = POWER(2, 05) THEN 'FAILED_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 06)) = POWER(2, 06) THEN 'NOMEM_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 07)) = POWER(2, 07) THEN 'HARD_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 08)) = POWER(2, 08) THEN 'NO_SHARERS_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 09)) = POWER(2, 09) THEN 'BIND_MISMATCH_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 10)) = POWER(2, 10) THEN 'SQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 11)) = POWER(2, 11) THEN 'PLSQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 12)) = POWER(2, 12) THEN 'PLSQL_RPC '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 13)) = POWER(2, 13) THEN 'PLSQL_COMPILATION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 14)) = POWER(2, 14) THEN 'JAVA_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 15)) = POWER(2, 15) THEN 'BIND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 16)) = POWER(2, 16) THEN 'CURSOR_CLOSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 17)) = POWER(2, 17) THEN 'SEQUENCE_LOAD '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 18)) = POWER(2, 18) THEN 'INMEMORY_QUERY '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 19)) = POWER(2, 19) THEN 'INMEMORY_POPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 20)) = POWER(2, 20) THEN 'INMEMORY_PREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 21)) = POWER(2, 21) THEN 'INMEMORY_REPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 22)) = POWER(2, 22) THEN 'INMEMORY_TREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 23)) = POWER(2, 23) THEN 'TABLESPACE_ENCRYPTION ' END time_model_name 
        FROM gv$active_session_history a) a
      , dba_users u
      , (SELECT
             object_id,data_object_id,owner,object_name,subobject_name,object_type
           , owner||'.'||object_name obj
           , owner||'.'||object_name||' ['||object_type||']' objt
         FROM dba_objects) o
    WHERE
        a.user_id = u.user_id (+)
    AND a.current_obj# = o.object_id(+)
    AND &2
    AND sample_time BETWEEN &3 AND &4
    GROUP BY
        &1--, event2, inst_id, objt, time_model_name, machine, module
    ORDER BY
        TotalSeconds DESC
       , &1
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
       , &1
/

