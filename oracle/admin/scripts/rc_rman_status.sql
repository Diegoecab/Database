--rc_rman_status
SET LINES 200
set pages 40
set echo off
set feed off
set head off
COL BASE format a10
COL OBJECT_TYPE format a20
COL TIPO format a15
COL STATUS format a10
COL COMIENZO format a22
COL FIN format a22
COL DURACION format a12
COL DEVICE format a8
COL OPERACION format a35

prompt =============================================
prompt "Operation" values in rc_rman_status
select distinct operation from rc_rman_status;
prompt =============================================
prompt "object_type" values in rc_rman_status
select distinct object_type from rc_rman_status;
prompt =============================================
prompt "output_device_type" values in rc_rman_status
select distinct output_device_type from rc_rman_status;
prompt =============================================
prompt 

set head on

SELECT * FROM (
select --dbid ,
db_name BASE,object_type TIPO, status, lpad(trunc( mod( (end_time-start_time)*24, 24 )),2,'0')|| ':'||lpad(trunc( mod( (end_time-start_time)*24*60, 60 )),2,'0') || ':'||
lpad(trunc( mod( (end_time-start_time)*24*60*60, 60 )),2,'0') "DURACION",
to_char(start_time, 'dd-mm-yy hh24:mi:ss' ) COMIENZO,
to_char(end_time, 'dd-mm-yy hh24:mi' ) FIN 
, round ( rs.output_bytes / 1000000000 ) GBytes_Processed,
output_device_type "DEVICE",
OPERATION
from rc_rman_status rs--, rc_database d
where --rs.db_key=d.db_key 
--and 
upper(OPERATION) like upper('%&operation%')
and upper(object_type) like upper('%&object_type%')
and trunc(start_time)>trunc(sysdate)-&days
and output_device_type like upper('%&output_device_type%')
and db_name like upper('%&db_name%')
ORDER BY DB_NAME DESC, start_time DESC
);
