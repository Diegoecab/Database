select sername, OPNAME, TARGET, SOFAR, TOTALWORK, UNITS, START_TIME, TIME_REMAINING, ELAPSED_SECONDS from v$session_longops

select OPNAME,SQL_ID ,TOTALWORK,UNITS,START_TIME,TIME_REMAINING,
ELAPSED_SECONDS from v$session_longops where username='GARBA_EUL' and time_remaining > 0;

SELECT SQL_TEXT FROM V$SQL WHERE SQL_ID ='55d439b5zjamb';

//////////////////
Para versiones anteriores ver Note:1067799.6 de metalink
//////////////////