select segment_name,partition_name,segment_type,bytes,extents,tablespace_name,
initial_extent,next_extent,pct_increase
from user_segments
where segment_name like upper('%&&1%')
and tablespace_name like upper('&&2')
order by bytes desc
/
