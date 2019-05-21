
select s.sid,s.serial#,
       s.username,s.osuser,
       s.machine,
       ao.owner,ao.object_name
from   v$locked_object lo,dba_objects ao,v$session s
where  ao.object_id = lo.object_id
and    lo.session_id = s.sid