--pga_usage.sql
break on con_id skip 4
compute sum of pga_alloc_mem on con_id
SELECT p.con_id,
       p.spid,
       p.pid,
       s.sid,
       s.serial#,
       s.status,
       ROUND(p.pga_alloc_mem/1024/1024) as pga_alloc_mem,
       ROUND(p.pga_used_mem/1024/1024) as pga_used_mem,
       ROUND(p.PGA_MAX_MEM/1024/1024) as pga_max_mem,
       s.username,
       s.osuser,
       s.program
FROM v$process p, v$session s
WHERE s.paddr( + ) = p.addr
--AND p.background is null /* Remove prevent listing background processes */
ORDER BY con_id,pga_alloc_mem;

break on off


--PGA stats from V$PGASTAT:
--show max total pga allocated since instance startup

select name, ROUND(value/1024/1024) as Mbytes from v$pgastat
where name in ('maximum PGA allocated','aggregate PGA target parameter','aggregate PGA auto target');

--Summation of ALL PGA based on v$process:
REM allocated includes free PGA memory not yet released to the operating system by the server process

SELECT ROUND(SUM(pga_alloc_mem)/1024/1024) AS "Mbytes allocated", ROUND(SUM(PGA_USED_MEM)/1024/1024) AS "Mbytes used"
FROM v$process;


--show max pga allocated from history
select * from (select name,SNAP_ID, ROUND(VALUE/1024/1024) Mbytes from CDB_HIST_PGASTAT
where name='maximum PGA allocated'
order by Mbytes desc,snap_id desc)
where rownum <11;