#https://dba.stackexchange.com/questions/107521/generate-analyze-trace-for-error-1461

alter system set events '1461 trace name context forever, level 4';
from alert.log:

OS Pid: 4069 executed alter system set events '1461 trace name context forever, level 4'
from oradebug:

oradebug setmypid
oradebug eventdump system

1461 trace name CONTEXT level 4, forever