col c1 format a15 heading 'snapshot|date'
col c2 format a25 heading 'table|name'
col c3 format 999,999,999 heading 'space|used|total'
 
select
   to_char(begin_interval_time,'yy/mm/dd hh24:mm')     c1,
   object_name      c2,
   space_used_total c3
from
   dba_hist_seg_stat       s,
   dba_hist_seg_stat_obj   o,
   dba_hist_snapshot       sn
where
   o.owner = '&OWNER'
and
   s.obj# = o.obj#
and
   sn.snap_id = s.snap_id
order by
   begin_interval_time; 