connect sh/sh
select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'SALES') stale_percent 
from dual;