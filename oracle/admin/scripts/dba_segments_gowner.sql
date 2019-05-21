Break on owner on report 
compute sum of GB on report 
set verify off

select owner,round(sum(bytes/1024/1024/1024),1) GB from dba_Segments 
where owner like upper('%&owner%')
group by owner order by 2,1
/
