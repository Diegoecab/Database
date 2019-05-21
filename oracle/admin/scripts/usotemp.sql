prompt 
prompt Uso Gral
prompt 

SELECT tablespace_name, extent_size, total_extents, used_extents,
free_extents, max_used_size
FROM v$sort_segment
/

prompt 
prompt Uso x Session
prompt

SELECT s.username, u.tablespace, u.contents, u.extents, u.blocks
FROM v$session s, v$sort_usage u
WHERE s.saddr=u.session_addr
/
