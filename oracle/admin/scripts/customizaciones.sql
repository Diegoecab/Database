select owner, object_type, count(*)
from dba_objects where object_name like upper('&1')
group by owner, object_type
order by owner, object_type
/
