--wait_time_detail_10g.sql 
-- *************************************************
-- Copyright � 2005 by Rampant TechPress
-- This script is free for non-commercial purposes
-- with no warranties.  Use at your own risk.
--
-- To license this script for a commercial purpose,
-- contact info@rampant.cc
-- *************************************************

prompt 
prompt  This will compare values from dba_hist_waitstat with 
prompt  detail information from dba_hist_active_sess_history.
prompt

set pages 999
set lines 80

break on snap_time skip 2

col snap_time     heading 'Snap|Time'   format a20
col file_name     heading 'File|Name'   format a40
col object_type   heading 'Object|Type' format a10
col object_name   heading 'Object|Name' format a20
col wait_count    heading 'Wait|Count'  format 999,999
col time          heading 'Time'        format 999,999 

select 
   to_char(begin_interval_time,'yyyy-mm-dd hh24:mi') snap_time,
--   file_name,
   object_type,
   object_name,
   wait_count,
   time
from
   dba_hist_waitstat            wait,
   dba_hist_snapshot            snap,
   dba_hist_active_sess_history ash,
   dba_data_files               df,
   dba_objects                  obj
where
   wait.snap_id = snap.snap_id
and
   wait.snap_id = ash.snap_id
and
   df.file_id = ash.current_file#
and
   obj.object_id = ash.current_obj#
and
   wait_count > 50
order by
   to_char(begin_interval_time,'yyyy-mm-dd hh24:mi'),
   file_name
;