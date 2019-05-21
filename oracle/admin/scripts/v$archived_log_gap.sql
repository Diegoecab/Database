--v$archived_log_gap.sql
col name for a20
select dest_id, lower(name) name, applied, count(*) from v$archived_log 
where dest_id <> 1 and applied <> 'YES'
group by dest_id, lower(name), applied
order by dest_id;