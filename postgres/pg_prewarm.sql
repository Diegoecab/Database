pg_prewarm


I suggested you to install pg_prewarm extension on your db instance after restore from snapshot is completed. 

create extension pg_prewarm;

Once extension is created, run below query to warm up your database: 

SELECT clock_timestamp(), pg_prewarm(c.oid::regclass),
relkind, c.relname
FROM pg_class c
JOIN pg_namespace n
ON n.oid = c.relnamespace
JOIN pg_user u
ON u.usesysid = c.relowner
WHERE u.usename NOT IN ('rdsadmin', 'rdsrepladmin', ' pg_signal_backend', 'rds_superuser', 'rds_replication')
ORDER BY c.relpages DESC;

Once prewarm process is completed, you can initiate upgrade to 12.15. 
