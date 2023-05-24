select * from v$sga order by 1;
select * from v$sgainfo order by 1;
select nvl(pool,name) pool, sum(bytes)/1024/1024/1024 Gb from v$sgastat group by nvl(pool,name) order by 1;
select component, current_size, user_specified_size from v$memory_dynamic_components order by 1;