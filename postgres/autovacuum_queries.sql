	1) To check for long-running transactions:
	
SELECT pid, datname, usename, state, backend_xmin, backend_xid
FROM pg_stat_activity
WHERE backend_xmin IS NOT NULL OR backend_xid IS NOT NULL
ORDER BY greatest(age(backend_xmin), age(backend_xid)) DESC;

	2) To check for an abandoned replication slot:

SELECT slot_name, slot_type, database, xmin
FROM pg_replication_slots
ORDER BY age(xmin) DESC;
	
	3) To check for orpaned prepared transactions:
	
SELECT gid, prepared, owner, database, transaction AS xmin
FROM pg_prepared_xacts
ORDER BY age(transaction) DESC;

	4) To find the xmin of standby/replica servers:
	
SELECT application_name, client_addr, backend_xmin
FROM pg_stat_replication
ORDER BY age(backend_xmin) DESC;




