--v$locked_object
--shows locked objects
col process for a12
select session_id,a.object_id,oracle_username,os_user_name,DECODE(a.locked_mode,
  1, 'No Lock',
  2, 'Row Share',
  3, 'Row Exclusive',
  4, 'Shared Table',
  5, 'Shared Row Exclusive',
  6, 'Exclusive') locked_mode, b.object_name, 
  process from v$locked_object a,dba_objects b where a.object_id=b.object_id order by 2;