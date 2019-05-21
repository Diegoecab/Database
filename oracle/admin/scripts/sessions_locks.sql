col sql_text for a80
set lines 400

select s.sid,
       s.username "Wait User",
	   s.machine,
	   s.osuser,
       l2.sid,
       s2.username "Lock User",
	   s2.machine,
	   s2.osuser,
       us.username "Owner",
       ob.object_name "Object"
  from v$session s,
       v$lock l,
       v$lock l2,
       v$session s2,
       v$resource re,
       dba_objects ob,
       dba_users us
 where s.lockwait is not null
   and l.sid = s.sid
   and l2.id1 = l.id1
   and s2.sid = l2.sid
   and s.sid != l2.sid
--   and l.lmode = 0
   and l2.id2 = 0
   and ob.owner = us.username
   and re.id1 = ob.object_name
   and l2.id1 = re.id1
 order by 1
/


SELECT
s1.username "LockUser",
s1.machine,
s1.sid,
substr(sqlt2.sql_text,1,80) "sql_text_lock",
s2.username "LockedUser",
s2.machine,
s2.sid,
substr(sqlt1.sql_text,1,80) "sql_text_locked"
FROM v$lock l1,
v$session s1 ,
v$lock l2 ,
v$session s2 ,
v$sql sqlt1 ,
v$sql sqlt2
WHERE s1.sid =l1.sid
AND s2.sid =l2.sid
AND sqlt1.sql_id= s2.sql_id
AND sqlt2.sql_id= s1.prev_sql_id
AND l1.BLOCK =1
AND l2.request > 0
AND l1.id1 = l2.id1
AND l2.id2 = l2.id2
/

SELECT sid, serial# , username, event,blocking_session, seconds_in_wait, sql_id
FROM v$session
WHERE state = 'WAITING'AND wait_class!= 'Idle';