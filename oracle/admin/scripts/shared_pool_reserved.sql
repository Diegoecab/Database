--Ver cuanta memoria disponible y utilizada hay en shared pool reserved
--v$shared_pool_reserved
SELECT ROUND(FREE_SPACE/(1024*1014), 2) SHARED_POOL_RESERVED_FREE_MB, 
ROUND(USED_SPACE/(1024*1024),2) SHARED_POOL_RESERVED_USED_MB 
FROM V$SHARED_POOL_RESERVED;

col requests for 9999999999
col last_failure_size for 9999999999 head "LAST FAILURE| SIZE " 
col last_miss_size for 9999999999 head "LAST MISS|SIZE " 
col pct for 999 head "HIT|% " 
col request_failures for 9999999999 head "FAILURES" 
select requests, 
decode(requests,0,0,trunc(100-(100*(request_misses/requests)),0)) PCT, request_failures, last_miss_size, last_failure_size 
from v$shared_pool_reserved;