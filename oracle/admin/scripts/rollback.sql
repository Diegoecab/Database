rem -----------------------------------------------------------------------
rem Filename:   rbs_act.sql
rem Purpose:    Display database sessions using rollback segments
rem Author:	Anonymous
rem -----------------------------------------------------------------------

col RBS format a5 trunc
col SID format 9990
col USER format a10 trunc
col COMMAND format a78 trunc
col status format a6 trunc

SELECT r.name "RBS", s.sid, s.serial#, s.username "USER", t.status,
       t.cr_get, t.phy_io, t.used_ublk, t.noundo,
       substr(s.program, 1, 78) "COMMAND"
FROM   sys.v_$session s, sys.v_$transaction t, sys.v_$rollname r
WHERE  t.addr = s.taddr
  and  t.xidusn = r.usn
ORDER  BY t.cr_get, t.phy_io
/


prompt para saber si est� haciendo rollback o procesando ver como crece used_urec

SELECT a.sid, a.username, b.xidusn, b.used_urec, b.used_ublk
  FROM v$session a, v$transaction b
  WHERE a.saddr = b.ses_addr;