--v$session_sid
col rownum for 99
col event for a40
col machine for a20
col program for a20
col username for a25
col module for a20
set linesize 180
accept SID prompt 'Ingrese SID: '
SELECT username,machine,program,module,status
  FROM v$session
 WHERE sid = '&SID'
 ORDER BY 1,2,3,4
 /