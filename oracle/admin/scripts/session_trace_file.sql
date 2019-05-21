REM  Identificar archivo trace la sesion actual
REM ======================================================================
REM session_trace_file.sql        Version 1.1    07 Julio 2011
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependencias:
REM
REM
REM Notas:
REM     
REM
REM Precauciones:
REM
REM ======================================================================
REM
select u_dump.value || '/' || instance.value || '_ora_' || v$process.spid
|| nvl2(v$process.traceid, '_' || v$process.traceid, null ) || '.trc' tracefile
from V$PARAMETER u_dump
cross join V$PARAMETER instance
cross join V$PROCESS
join V$SESSION on v$process.addr = V$SESSION.paddr
where u_dump.name = 'user_dump_dest'
and instance.name = 'instance_name'
and V$SESSION.audsid=sys_context('userenv','sessionid')
/