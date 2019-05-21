select	count(last_analyzed) left_to_do
from	dba_tables
where	trunc(last_analyzed) < trunc(sysdate)
order	by 1;
/

