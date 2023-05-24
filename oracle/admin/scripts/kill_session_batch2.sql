 select 'alter system kill session '''||s.sid||','||s.serial#||',@'||s.inst_id||''' immediate;' from gv$session s ,gv$process p where s.paddr = p.addr
  --and s.username is not null and status = 'ACTIVE'
  --and s.sql_id='4nqnfu8ctc7u4'
 and s.username='S_CO_PRD_WSRECAR_DB'
/