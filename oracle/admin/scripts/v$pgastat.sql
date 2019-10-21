col name for a50
select inst_id, name, round(value/1024/1024) mb  from gv$pgastat where name like '%PGA allocated';