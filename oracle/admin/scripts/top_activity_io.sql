/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  top_activity_io.sql v1.0
-- Purpose:    Script To Get Cpu Usage And Wait Event Information In Oracle Database
-- Usage:       
--     @top_activity_io <lastNminutes>
-- (rounded minutes)
-- Example:
--     Last hour
--     @top_activity_io 60
--AAS = (DB Time / Elapsed Time) AAS is a time-normalized DB Time
--Load on database = AAS = DB Time/elapsed ~ = count(*)/elapsed
*/

set lines 200
set pages 1000
col objn for a50
col otype for a30
col owner for a40
col event for a30
set trimout on
set tab off
set feed off
set verify off

Break on SAMPLE_TIME on report


select cnt,
 event,
 round(cnt/nullif(((
 to_date(beg,'DD/MM/YY HH24:MI:SS')-
 to_date(end,'DD/MM/YY HH24:MI:SS'))*
 24*60*60),0)
 ,2) aas,
 owner,
 objn,
 otype
from (
select
 count(*) cnt,
 to_char(nvl(min(sample_time),sysdate),
 'DD/MM/YY HH24:MI:SS') end,
 to_char(nvl(max(sample_time),sysdate),
 'DD/MM/YY HH24:MI:SS') beg,
 event,
 o.owner,
 o.object_name objn,
 o.object_type otype
from v$active_session_history ash,
 all_objects o
where ( event like 'db file s%' or event like 'direct%' or event like 'db file%' )
 and o.object_id (+)= ash.CURRENT_OBJ#
 and SAMPLE_TIME > SYSDATE - INTERVAL '&1' MINUTE
group by
 event,
 owner,
 CURRENT_OBJ#, o.object_name ,
 o.object_type
)
Order by cnt
/







