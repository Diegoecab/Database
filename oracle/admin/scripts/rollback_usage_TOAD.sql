/* Formatted on 2005/07/28 09:15 (Formatter Plus v4.5.2) */
SELECT   r.NAME, -- rbs name
                s.sid, s.serial#, s.username, s.machine, t.status, t.cr_get, -- consistent gets
         t.phy_io, -- physical IO
                  t.used_ublk, -- Undo blocks used
                              t.noundo, --   Is a noundo transaction
                                       SUBSTR (s.program, 1, 78) "COMMAND",
         s.username "DB User", t.start_time, s.sql_address "Address",
         s.sql_hash_value "Sql Hash"
    FROM sys.v_$session s, sys.v_$transaction t, sys.v_$rollname r
   WHERE t.addr = s.taddr AND t.xidusn = r.usn
ORDER BY t.start_time;