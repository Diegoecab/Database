select p.spid from v$process p,v$session s
where s.paddr=p.addr
and s.status='SNIPED'
/
