col value format 99999999999

select * from v$sga
/

select decode(pool,null,'buffer',pool), trunc(sum(bytes/1024/1024/1024)) "Used G bytes" from v$sgastat 
group by decode(pool,null,'buffer',pool)
/

select pool, trunc(bytes/1024/1024/1024) "Free G bytes" from v$sgastat where name = 'free memory'
/