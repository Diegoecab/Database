select object_type,count(*)
from dba_objects where owner = upper('&1')
group by object_type
ORDER BY 1,2
/
