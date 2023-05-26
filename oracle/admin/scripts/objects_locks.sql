--objects_locks
--shows locked objects
col process for a15
col owner for a20 truncate
col object_name for a30 truncate
col machine for a30 truncate
set lines 300
select session_id,serial#,a.inst_id, a.object_id,oracle_username,machine,os_user_name,DECODE(a.locked_mode,
  1, 'No Lock',
  2, 'Row Share',
  3, 'Row Exclusive',
  4, 'Shared Table',
  5, 'Shared Row Exclusive',
  6, 'Exclusive') locked_mode, owner, b.object_name, 
  a.process from gv$locked_object a,dba_objects b, gv$session c where a.object_id=b.object_id and c.sid=a.session_id and c.inst_id=a.inst_id and c.process=a.process order by b.object_name ;