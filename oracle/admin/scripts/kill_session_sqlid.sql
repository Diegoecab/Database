select 'alter system kill session '''||sid||','||serial#||',@'||inst_id||''' immediate;' from gv$session where sql_id='&sqlid'
/