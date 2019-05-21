select segment_name, cnt, max_extents, max_extents-cnt diff, username, sid, serial#, mb from(
select segment_name, count(*) cnt, (select max_extents from dba_rollback_segs where segment_name=a.segment_name) max_extents, 
b.username, b.sid, b.serial#, b.mb
from dba_undo_extents a, (select a.name,b.status , d.username , d.sid , d.serial#, ( select round(sum(bytes)/1024/1024)
		  from dba_segments 
		  where tablespace_name = upper((select value from v$parameter where name ='undo_tablespace')) and segment_name=a.name) mb
from   v$rollname a,v$rollstat b, v$transaction c , v$session d
where  a.usn = b.usn
and    a.usn = c.xidusn
and    c.ses_addr = d.saddr
and    a.name in (
		  select segment_name
		  from dba_segments 
		  where tablespace_name = upper((select value from v$parameter where name ='undo_tablespace'))
		 )) b where b.name = a.segment_name
group by segment_name, b.username, b.sid, b.serial#, b.mb)
/