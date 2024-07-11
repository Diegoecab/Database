set lines 400

col sql_text for a50 TRUNCATE
col event for a20 TRUNCATE
col username for a15 TRUNCATE
col usuario for a15 TRUNCATE
col lock_user for a25 TRUNCATE
col wait_user for a30 TRUNCATE
col Object for a30 TRUNCATE
col name for a20 truncate
col Mode for  99999
col lmode for 99999
col owner for a10 TRUNCATE
col sql_text_locked for a35 TRUNCATE
col sql_text_lock for a35 TRUNCATE
col blocked_user for a25 TRUNCATE
col machine for a25 TRUNCATE
col sid for 99999
col SPID for a10
col sess for a15
col id1 for 999999999999
col id2 for 999999999999
col request for 999
col inst_id heading 'Inst|Id' for 99


--ac
SELECT /*+ RULE */
k.inst_id,
ss.username,
DECODE (request, 0, 'Holder: ', ' Waiter: ') || k.sid sess,
ss.sql_id,
k.id1,
k.id2,
k.lmode,
k.request,
k.TYPE,
SS.LAST_CALL_ET,SS.SECONDS_IN_WAIT,
SS.SERIAL#,
SS.MACHINE,
SS.EVENT,
ss.status,
P.SPID spid,
CASE
WHEN request > 0
THEN
CHR (BITAND (p1, -16777216) / 16777215)
|| CHR (BITAND (p1, 16711680) / 65535)
ELSE
NULL
END
"Name",
CASE WHEN request > 0 THEN (BITAND (p1, 65535)) ELSE NULL END "Mode"
FROM GV$LOCK k, gv$session ss, gv$process p
WHERE
(k.id1, k.id2, k.TYPE) IN (SELECT ll.id1, ll.id2, ll.TYPE
FROM GV$LOCK ll
WHERE request > 0)
AND k.sid = ss.sid
AND K.INST_ID = SS.INST_ID
AND ss.paddr = p.addr
AND SS.INST_ID = P.INST_ID
ORDER BY id1, request;



SELECT
s1.username "lock_user",
s1.machine,
s1.inst_id,
s1.sid,
s1.serial#,
s1.sql_id,
s1.inst_id,
--substr(sqlt2.sql_text,1,80) "sql_text_lock",
'|' as "|",
count(distinct(s2.sid||s2.SERIAL#)) "blocked_user_count",
round(max((s2.seconds_in_wait/60))) "max_minutes_in_wait",
s2.inst_id s2_inst_id,
s2.sid s2_sid,
s2.serial# s2_serial,
s2.username "blocked_user",
s2.sql_id "bloqued_sql_id"
FROM gv$lock l1,
gv$session s1 ,
gv$lock l2 ,
gv$session s2 ,
gv$sql sqlt1 ,
gv$sql sqlt2
WHERE s1.sid =l1.sid
AND s2.sid =l2.sid
AND sqlt1.sql_id= s2.sql_id
AND sqlt2.sql_id= s1.prev_sql_id
AND l1.BLOCK =1
AND l2.request > 0
AND l1.id1 = l2.id1
AND l2.id2 = l2.id2
and s1.sql_id is not null
group by
s1.username,
s1.machine,
s1.sid,
s1.serial#,
s1.sql_id,
s1.inst_id,
s2.inst_id ,
s2.sid ,
s2.serial# ,
s2.username,
s2.sql_id
order by "blocked_user_count"
/



SELECT
s1.username "lock_user",
s1.machine,
s1.sid,
s1.serial#,
s1.sql_id,
s1.inst_id,
--substr(sqlt2.sql_text,1,80) "sql_text_lock",
'|' as "|",
s2.username "blocked_user",
s2.machine,
s2.sid,
s2.SERIAL#,
s2.sql_id,
s2.inst_id,
round(s2.seconds_in_wait/60) "minutes_in_wait"--,
--substr(sqlt1.sql_text,1,80) "sql_text_locked"
FROM gv$lock l1,
gv$session s1 ,
gv$lock l2 ,
gv$session s2 ,
gv$sql sqlt1 ,
gv$sql sqlt2
WHERE s1.sid =l1.sid
AND s2.sid =l2.sid
AND sqlt1.sql_id= s2.sql_id
AND sqlt2.sql_id= s1.prev_sql_id
AND l1.BLOCK =1
AND l2.request > 0
AND l1.id1 = l2.id1
AND l2.id2 = l2.id2
order by s2.seconds_in_wait
/

select lock_user,machine,lock_sid,lock_serial,sql_id,sql_text_lock,blocked_user,blocked_sid, blocked_serial, blocked_machine,bloqued_sql_id, sql_text_locked, min(minutes_in_wait), max(minutes_in_wait),count(*) from (
select
s1.username lock_user,
s1.machine,
s1.sid lock_sid,
s1.serial# lock_serial,
s1.sql_id,
s1.inst_id,
substr(sqlt2.sql_text,1,80) sql_text_lock,
'|' as "|",
s2.username blocked_user,
s2.machine blocked_machine,
s2.sid blocked_sid,
s2.serial# blocked_serial,
s2.sql_id bloqued_sql_id,
s2.inst_id,
round(s2.seconds_in_wait/60) minutes_in_wait,
substr(sqlt1.sql_text,1,80) sql_text_locked
from gv$lock l1,
gv$session s1 ,
gv$lock l2 ,
gv$session s2 ,
gv$sql sqlt1 ,
gv$sql sqlt2
where s1.sid =l1.sid
and s2.sid =l2.sid
and sqlt1.sql_id= s2.sql_id
and sqlt2.sql_id= s1.prev_sql_id
and l1.block =1
and l2.request > 0
and l1.id1 = l2.id1
and l2.id2 = l2.id2
order by s2.seconds_in_wait
) group by lock_user,machine,sql_id,blocked_user,blocked_machine,bloqued_sql_id,sql_text_lock,sql_text_locked,lock_sid,lock_serial,blocked_sid,blocked_serial
order by sql_id
/

/*
set pages 1000
select 
'alter system kill session '''||a.sid||','||(select serial# from gv$session where inst_id=a.inst_id and sid=a.sid)||','||'@'||a.inst_id||''' immediate;' 
 from 
    gv$lock a, 
    gv$lock b
 where 
    a.block = 1
 and 
    b.request > 0
 and 
    a.id1 = b.id1
 and 
    a.id2 = b.id2
	and ((select username from gv$session where inst_id=a.inst_id and sid=a.sid))='BUSINESSDATA_COLOMBIA'
/


select 
    (select username from gv$session z where sid=a.sid and z.inst_id=a.inst_id) blocker,
    a.sid,
    ' is blocking ',
    (select username from gv$session z where sid=b.sid and z.inst_id=a.inst_id) blockee,
    b.sid
 from 
    gv$lock a, 
    gv$lock b
 where 
    a.block = 1
 and 
    b.request > 0
 and 
    a.id1 = b.id1
 and 
    a.id2 = b.id2;
	
Prompt Dba waiters
select * from dba_waiters;

Prompt Dba blockers
select * from dba_blockers;

prompt 
select b.*,username,sid,serial#,status,machine,osuser,program,SECONDS_IN_WAIT,LOGON_TIME from v$session a,
(
select
   session_id,
   owner,
   name,
   mode_held,
   mode_requested
from
   sys.dba_dml_locks --where owner like 'GEC01%'
   ) b
where a.sid=b.session_id
/

   */
   
 
