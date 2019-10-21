SELECT NVL(s.username, '[bkgrnd]') AS username,
       s.inst_id, count(*)
FROM   gv$session s,
       gv$process p
WHERE  s.paddr      = p.addr
AND    s.inst_id = p.inst_id
GROUP BY NVL(s.username, '[bkgrnd]'), s.inst_id
ORDER BY 1
/