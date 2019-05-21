col value format 99,999,999,999

select * from v$sga
/

select decode(pool,null,'buffer',pool), trunc(sum(bytes/1024)) "Used K bytes" from v$sgastat 
group by decode(pool,null,'buffer',pool)
/

select pool, trunc(bytes/1024) "Free K bytes" from v$sgastat where name = 'free memory'
/