select * from pg_stat_replication;

-- To find the xmin of standby/replica servers:
	
SELECT application_name, client_addr, backend_xmin
FROM pg_stat_replication
ORDER BY age(backend_xmin) DESC;
