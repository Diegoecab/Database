SELECT spid
FROM v$process 
where addr = ( select paddr from v$session where sid= &1 and serial# =&2)
/