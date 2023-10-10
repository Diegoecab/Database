col instname    format a08      heading 'inst|name'
col dbname      format a08      heading 'db name'
col group_name  format a08      heading 'disk|group|name'
col disk_number format 9999     heading 'asm|disk|#'
col reads       format 9999999999 heading 'disk|reads'
col read_time   format 9999999999   heading 'read|time|(s)'
col read_errs   format 99999999   heading 'read|errors'
col mb_read     format 99999999 heading 'bytes|read|(mb)'
col writes      format 99999999 heading 'disk|writes'
col write_errs  format 99999999   heading 'write|errors'
col write_time  format 99999999   heading 'write|time|(s)'
col mb_wrtn     format 99999999.9 heading 'bytes|written|(mb)'
col name for a20 truncate
col inst_id for 99
set pages 1000
set lines 400

ttitle 'ASM disk I/O statistics'

select
a.inst_id,
  a.instname,
  a.DISK_NUMBER,
  c.name,
  b.name         group_name,
  a.disk_number,
  a.reads,
  a.read_errs,
  a.read_time,
  round( a.bytes_read / (1024*1024*1024)) gb_read,
  a.writes,
  a.write_errs,
  a.write_time,
  a.READ_TIMEOUT,
  a.WRITE_TIMEOUT,
  round( a.bytes_written / (1024*1024*1024)) gb_written,
  round(a.hot_bytes_read / (1024*1024*1024))      hot_gb_read,
  round(a.cold_bytes_read / (1024*1024*1024))    cold_gb_read,
  round(a.hot_bytes_written / (1024*1024*1024))  hot_gb_wrtn,
  round(a.cold_bytes_written / (1024*1024*1024)) cold_gb_wrtn
 from
     gv$asm_disk_iostat a,
     gv$asm_diskgroup   b,
	 gv$asm_disk  c
 where a.group_number = b.group_number and a.inst_id = b.inst_id
 and c.DISK_NUMBER =a.disk_number and c.INST_ID=b.inst_id 
 order by
 a.inst_id,
  a.DISK_NUMBER,
	a.bytes_read,
   c.name,
   a.instname;
   
   
   
Prompt Below query returns name of disk group, average read/write time in millisecs, total number of reads/writes

SELECT inst_id,name, ROUND(total_mb / 1024) total_gb, active_disks,
 reads / 1000 reads1k, writes / 1000 writes1k,
 ROUND(read_time) read_time, ROUND(write_time) write_time,
 ROUND(read_time * 1000 / reads, 2) avg_read_ms,
 ROUND(write_time * 1000 / writes, 2) avg_write_ms
 FROM v$asm_diskgroup_stat dg
 JOIN
 (SELECT inst_id, group_number, COUNT(DISTINCT disk_number)
active_disks,
 SUM(reads) reads, SUM(writes) writes,
 SUM(read_time) read_time, SUM(write_time)
write_time
 FROM gv$asm_disk_stat
 WHERE mount_status = 'CACHED'
 GROUP BY inst_id,group_number) ds
 ON (ds.group_number = dg.group_number)
 ORDER BY dg.group_number;