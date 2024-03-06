col event for a30
col sid for 9999

SELECT w.Event,
	s.sid,
	s.STATUS,
	s.program,
	w.p1,
	w.p2
FROM v$session s,v$transaction t,v$session_wait w
WHERE s.taddr=t.addr AND s.sid=w.sid;