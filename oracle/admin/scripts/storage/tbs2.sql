REM ################################################
REM # Creator: Vincent Fenoll
REM # Created: 2004/01/22
REM # Name: tbslight.sql
REM  ################################################
REM #
REM # Compatible: Oracle 7 8i 9i 10g 11g
REM#
REM ################################################
REM #
REM # Tablespaces usage (light report)
REM #
REM ################################################
 
set echo off
set timing off
set pages 999
set verify off
set feedback off
 
column run_date  new_value xxrun_date noprint
column inst      new_value xxinst noprint
column host_name new_value xxhost noprint
column "% Libre" Format 999.99 heading "%|Libre"
column "Really used" Format 999,999,999 heading "Really|used"
column largest_free_chunk format 999,999,999 heading "Biggest|Chunk (M)"
column smallest_free_chunk format 999,999,999 heading "Smallest|Chunk (M)"
column Average_chunk format 999,999,999 heading "Average|Chunk (M)"
column COUNT_CHUNKS format 999,999 heading "# Free|Chunks"
column total_free format 999,999,999 heading "Free|Total"
column total_size format 999,999,999 heading "Space|total"
column tablespace_name format a25 heading "TableSpace name"
COMPUTE SUM LABEL 'Totals ' OF Total_Free on REPORT
COMPUTE SUM LABEL 'Totals ' OF Total_Size on REPORT
BREAK ON REPORT
 
select sysdate run_date from dual;
select instance_name inst, host_name from v$instance;
 
prompt************************************************************************
prompt   SPACE USED BY TABLESPACES 
prompt   DATABASE          : &xxinst
prompt   HOST              : &xxhost
prompt   Run date          : &xxrun_date
prompt 
prompt NOTE ** STATS ARE IN MEGABYTES **
prompt************************************************************************
select dfs.tablespace_name,
       trunc(sum(dfs.bytes)/1048576) "Total_Free",
       Round( (1 - ( ( (a.total_size) - sum(dfs.bytes) ) / (a.total_size) ) ) * 100,2) "% Libre", 
       trunc(a.total_size/1048576) - trunc(sum(dfs.bytes)/1048576) "Reellement occupe",
       trunc(a.total_size/1048576) "Total_Size"
from   dba_free_space dfs,
       (select tablespace_name, sum(bytes) total_size from dba_data_files group by tablespace_name) a
where  dfs.tablespace_name = a.tablespace_name
group by dfs.tablespace_name, a.total_size
order by 1
/
prompt
 
prompt 
prompt***************************** END OF  REPORT ****************************
prompt-------------------------------------------------------------------------
 
clear columns
clear computes
clear breaks