-- To check for orpaned prepared transactions:
	
SELECT gid, prepared, owner, database, transaction AS xmin
FROM pg_prepared_xacts
ORDER BY age(transaction) DESC;
