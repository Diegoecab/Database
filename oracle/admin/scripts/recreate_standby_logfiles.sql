set lines 600
set pages 100
select 'ALTER DATABASE DROP STANDBY LOGFILE GROUP '||group#||';' from v$standby_log;
select 'ALTER DATABASE ADD STANDBY LOGFILE GROUP '||group#||' (''+PDCP_FRA'') size '||ROUND (BYTES / 1024 / 1024)||'M ;'
from v$standby_log;