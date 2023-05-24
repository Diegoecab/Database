SELECT COUNT(*)
       FROM gv$transaction t, gv$session s, gv$mystat m
      WHERE t.inst_id = s.inst_id AND  s.inst_id = m.inst_id
		AND t.ses_addr = s.saddr
        AND s.sid = m.sid;