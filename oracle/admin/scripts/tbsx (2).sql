ttitle ' '
col ba noprint new_value base
select name ba from v$database;
ttitle skip 2 center 'Espacio libre por tablespace de la base &base' skip 2
column dummy noprint
column  pct_used format 999.9       heading "%|Usado" 
column  name    format a20      heading "Tablespace Name" 
column  bytes   format 9,999,999,999,999    heading "Total Bytes" 
column  used    format 999,999,999,999   heading "Usado" 
column  free    format 999,999,999,999  heading "Libre" 
break   on report 
compute sum of bytes on report 
compute sum of free on report 
compute sum of used on report 
--spool tbs_&base

select a.tablespace_name                                          name,
       b.tablespace_name                                          dummy,
       sum(b.bytes)/count( distinct a.file_id||'.'||a.block_id )  bytes,
       sum(b.bytes)/count( distinct a.file_id||'.'||a.block_id ) -
       sum(a.bytes)/count( distinct b.file_id )		          used,
       sum(a.bytes)/count( distinct b.file_id )                   free,
	  100 * ( (sum(b.bytes)/count( distinct a.file_id||'.'||a.block_id )) -
			   (sum(a.bytes)/count( distinct b.file_id ) )) /
	   (sum(b.bytes)/count( distinct a.file_id||'.'||a.block_id )) pct_used
from sys.dba_free_space a, sys.dba_data_files b
where a.tablespace_name = b.tablespace_name
group by a.tablespace_name, b.tablespace_name
union all
select c.tablespace_name                                          name,
       null		                                          dummy,
       sum(c.bytes) 						  bytes,
       sum(c.bytes) 						  used,
       0					                  free,
       100  							  pct_used
from sys.dba_data_files c
where not exists (select 1 from sys.dba_free_space a
		  where a.tablespace_name = c.tablespace_name)
group by c.tablespace_name;


ttitle ' '
set linesize 100;
column c1 heading "Tablespace" format a20;
column c2 heading "File name";
column c3 heading "Size (MB)";
col c2 format  A50
col c3 format  9999999999999999
ttitle skip 2 center 'Tablespace con sus DataFiles de la base &base' skip 2
select   substr(tablespace_name,1,10) c1,
         substr(file_name,1,50) c2,
         round(sum(bytes)/1048576,2) c3
from     sys.dba_data_files
group by tablespace_name,file_name
order by tablespace_name;

ttitle ' '
