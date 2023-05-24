col name for a50
select inst_id, name, round(value/1024/1024/1024) gb  from gv$pgastat
where
NAME in ( 'aggregate PGA target parameter', 'aggregate PGA auto target', 'total PGA inuse ', 
'total PGA allocated', 'maximum PGA used for auto workareas', 'cache hit percentage', 'over allocation count')
order by inst_id,name;
 