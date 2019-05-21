clear col
undefine all
break on tablespace on report
compute sum of mb on report

select  tmp.tablespace,s.sid, --s.osuser, s. process, 
        s.sql_id, tmp.segtype, 
       ((tmp.blocks*8)/1024)MB
from  
       v$tempseg_usage tmp,
       v$session s
where tmp.session_num=s.serial#
--and segtype in ('HASH','SORT')
order by blocks desc
/