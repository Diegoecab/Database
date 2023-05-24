--------------------------------------------------------------------------------
-- 
-- File name:   aas.sql v1.0
-- Purpose:     Display Average active session for an specific interval time and it status based on  cpu_count
--              
-- Author:      Diego Cabrera
-- Copyright:   
--              
-- Usage:       
--     @aas <fromtime> <totime>
--
-- Example:
--
--     @ash/aas sysdate+(1/1440*-60) sysdate
--	   @ash/aas sysdate+(1/1440*-180) sysdate+(1/1440*-15)
--     @ash/aas sysdate+(1/1440*-15) sysdate
--
--

col cpu_count			FOR 999
set lines 350
set pages 10000
set verify off
col begin_interval_time for a25
col end_interval_time for a25

select inst_id, begin_interval_time, end_interval_time, cpu_count, AAS, round(AAS*100/cpu_count,1) aas_pct, case when (AAS*100/cpu_count) < 80 then 'OK' when (AAS*100/cpu_count) between 80 and 100 then 'WARNING' else 'CRITICAL' end status from (
select inst_id,   TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') begin_interval_time, TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') end_interval_time, ( select to_number(value) cpu_count from gv$parameter
                 where name='cpu_count' and inst_id=a.inst_id) cpu_count,
ROUND(COUNT(*) / ((CAST(&2 AS DATE) - CAST(&1 AS DATE)) * 86400), 1) AAS from 
gv$active_session_history a
where sample_time BETWEEN &1 AND &2
group by inst_id);
