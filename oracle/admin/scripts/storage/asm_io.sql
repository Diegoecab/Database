-- ------------------------------------------------------------------------------
-- File       : asm_io.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm io.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_io.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
col instname for a10
col dbname for a10
select
INSTNAME 
--,DBNAME ,GROUP_NUMBER
--,FAILGROUP
,sum (READS+WRITES) total_io ,round(ratio_to_report(sum(reads+WRITES)) over ()*100,2) "%_IO"
,sum (READS) reads ,round(ratio_to_report(sum(reads)) over ()*100,2) "%_Reads"
,sum (WRITES) writes ,round(ratio_to_report(sum(writes)) over ()*100,2) "%_Writes"
--,sum (READ_ERRS) read_err ,sum (WRITE_ERRS) write_err
,round(sum(READ_TIME)/60,2) read_time ,round(ratio_to_report(sum(read_time)) over ()*100,2) "%_Read_time" -- Minutes
,round(sum(WRITE_TIME)/60,2) write_time ,round(ratio_to_report(sum(write_time)) over ()*100,2) "%_Write_time" -- Minutes
,sum(BYTES_READ)/1024/1024 gb_read  ,round(ratio_to_report(sum(bytes_read)) over ()*100,2) "%_Gb_Read"
,sum(BYTES_WRITTEN)/1024/1024 gb_written ,round(ratio_to_report(sum(bytes_written)) over ()*100,2) "%_Gb_Written"
--,HOT_READS ,HOT_WRITES ,HOT_BYTES_READ ,HOT_BYTES_WRITTEN
--,COLD_READS ,COLD_WRITES ,COLD_BYTES_READ ,COLD_BYTES_WRITTEN
from V$ASM_DISK_IOSTAT
group by INSTNAME ,DBNAME 
order by 4,2
/
