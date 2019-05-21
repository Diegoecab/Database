prompt 
prompt Uso x Session
prompt
set heading on
col machine for a30
col tablespace for a10
col program for a20
col username for a20
Break on username on report 
compute sum of mb on report

SELECT s.username, s.sid, s.machine,s.program,u.tablespace, u.contents, u.extents, u.blocks, (u.blocks*8)/1024 mb
FROM v$session s, v$sort_usage u
WHERE s.saddr=u.session_addr
/

