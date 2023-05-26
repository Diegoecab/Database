col inst_id form 9999 head inst
col name form a25
col value form a100 wrap
set lines 150
select * from v$diag_info
order by name
/