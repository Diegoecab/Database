--datafiles_io_gday.sql
break on trunc(begin_interval_time) skip 2

alter session set nls_date_format='dd/mm/yyyy';

column phyrds              format 999,999,999
column begin_interval_time format a25

select 
   trunc(begin_interval_time),
   filename,
   sum(phyrds), sum(phywrts)
from
   dba_hist_filestatxs 
natural join
   dba_hist_snapshot
group by trunc(begin_interval_time),filename
;