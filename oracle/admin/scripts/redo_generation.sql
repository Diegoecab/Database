--redo_generation.sql

prompt Query V$SESS_IO. This view contains the column BLOCK_CHANGES which indicates
prompt how much blocks have been changed by the session. High values indicate a 
prompt session generating lots of redo.
prompt 
prompt Run the query multiple times and examine the delta between each occurrence
prompt of BLOCK_CHANGES. Large deltas indicate high redo generation by the session.

SELECT s.sid, s.serial#, s.username, s.program,
i.block_changes
FROM v$session s, v$sess_io i
WHERE s.sid = i.sid
and i.block_changes > 20000
ORDER BY 5 desc, 1, 2, 3, 4;   

prompt Query V$TRANSACTION. This view contains information about the amount of
prompt undo blocks and undo records accessed by the transaction (as found in the 
prompt USED_UBLK and USED_UREC columns).
prompt Run the query multiple times and examine the delta between each occurrence
prompt of USED_UBLK and USED_UREC. Large deltas indicate high redo generation by 
prompt the session.
   
SELECT s.sid, s.serial#, s.username, s.program, 
t.used_ublk, t.used_urec
FROM v$session s, v$transaction t
WHERE s.taddr = t.addr
ORDER BY 5 desc, 6 desc, 1, 2, 3, 4;