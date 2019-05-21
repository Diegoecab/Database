col rownum for 99
col event for a40
set linesize 180
accept SID prompt 'Ingrese SID: '
SELECT ROWNUM, event, total_waits, total_timeouts, time_waited, average_wait,
       max_wait, time_waited_micro
  FROM v$session_event
 WHERE SID = '&SID'
 /