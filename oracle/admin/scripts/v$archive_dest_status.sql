--v$archive_dest_status
select ads.dest_id,
ads.db_unique_name,
max(sequence#) "Current Sequence",
max(log_sequence) "Last Archived",
max(applied_seq#) "Last Sequence Applied"
from v$archived_log al, v$archive_dest ad, v$archive_dest_status ads
where ad.dest_id=al.dest_id
and al.dest_id=ads.dest_id
group by ads.dest_id, ads.db_unique_name
/
