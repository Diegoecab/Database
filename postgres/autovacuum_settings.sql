show autovacuum;
select name, setting, source, context, min_val, max_val, boot_val from pg_settings where name like 'autovacuum%';
--Tuning autovacuum parameters
--https://docs.aws.amazon.com/prescriptive-guidance/latest/tuning-postgresql-parameters/autovacuum-parameters.html

/*
autovacuum:
	You can enable autovacuum globally by setting the autovacuum configuration parameter to on, or you can enable it on a per-table basis by setting the autovacuum_enabled column of the pg_class table to true for a specific table.
	When you enable autovacuum on a table, the database server periodically scans the table for dead rows and tuples and removes them in the background, without any intervention from the database administrator. This helps to keep the table small, improve query performance, and reduce the size of backups.

autovacuum_work_mem:
	autovacuum_work_mem is a PostgreSQL configuration parameter that controls the amount of memory used by the autovacuum process when it performs table maintenance tasks such as vacuuming or analysis.
	Default value: GREATEST({DBInstanceClassMemory/32768},131072) in Aurora PostgreSQL-Compatible, 64 MB in Amazon RDS for PostgreSQL. However, the default value might vary depending on the specific version of Amazon RDS or Aurora you're using.

autovacuum_naptime:
	The autovacuum_naptime parameter controls the time interval between successive runs of the autovacuum process. The default value is 15 seconds for Amazon RDS for PostgreSQL and 5 seconds for Aurora PostgreSQL-Compatible.
	You can use autovacuum_naptime to manage the load caused by the vacuum process, especially if you have a busy server that already has a high CPU or I/O load. The longer you set the nap time, the less frequently autovacuum runs, which reduces the load on the server

autovacuum_max_workers:
	The autovacuum_max_workers parameter controls the maximum number of worker processes that the autovacuum process can create. Each worker process is responsible for vacuuming or analyzing a single table.
	If you set autovacuum_max_workers to a high value such as 8, up to eight tables can be vacuumed simultaneously. This can make the cleaning process faster for databases that contain many tables
	Default value: GREATEST(DBInstanceClassMemory/64371566592,3)

autovacuum_vacuum_scale_factor:
	The autovacuum_vacuum_scale_factor configuration parameter controls how aggressive the autovacuum process should be when vacuuming a table.
	The vacuum scale factor is a fraction of the total number of tuples in a table that must be modified before autovacuum cleans the table.
	The default value is 0.2 (that is, 20 percent of the tuples must be modified) in Amazon RDS for PostgreSQL.
	Default value: 0.2 (Amazon RDS for PostgreSQL), 0.1 (Aurora PostgreSQL-Compatible)

autovacuum_analyze_scale_factor:
	The autovacuum_analyze_scale_factor parameter controls how aggressive the autovacuum process should be when analyzing (collecting statistics about the distribution of data in a table.
	The autovacuum process uses this parameter to calculate a threshold based on the number of tuples in a table. If the number of tuple inserts, updates, or deletes exceeds this threshold, autovacuum analyzes the table. The default value is 0.05 (that is, 5 percent of the tuples must be modified) for both Amazon RDS for PostgreSQL and Aurora PostgreSQL-Compatible.


autovacuum_vacuum_threshold:
	The autovacuum_vacuum_threshold parameter controls the minimum number of tuple update or delete operations that must occur on a table before autovacuum vacuums it. This setting can be useful to prevent unnecessary vacuuming on tables that do not have a high rate of these operations.
	The default value is 50, which is the PostgreSQL engine default, for both Amazon RDS for PostgreSQL and Aurora PostgreSQL-Compatible.
	For example, let's say you have a table with 100,000 rows and autovacuum_vacuum_threshold is set to 50. If the table receives only 49 updates or deletes, autovacuum won't vacuum it. If the table receives 50 or more updates or deletes, autovacuum will vacuum it, depending on the value of autovacuum_vacuum_scale_factor multiplied by the number of table rows as a controlling factor.
	The autovacuum_vacuum_threshold parameter works in conjunction with the autovacuum_vacuum_scale_factor, autovacuum_vacuum_cost_limit, and autovacuum_naptime parameters. The optimal settings depend on the specific requirements of your database and table size.


autovacuum_analyze_threshold:
	The autovacuum_analyze_threshold parameter is similar to autovacuum_vacuum_threshold. It controls the minimum number of tuple inserts, updates, or deletes that must occur on a table before autovacuum analyzes it. This setting can be useful to prevent unnecessary vacuuming on tables that don't have a high rate of these operations. The default value is 50, which is the PostgreSQL engine default, for both Amazon RDS for PostgreSQL and Aurora PostgreSQL-Compatible.
	For example, let's say you have a table with 100,000 rows and you keep the autovacuum_analyze_threshold default at 50. If the table receives only 49 inserts, updates, or deletes, autovacuum won't analyzes it. If the table receives 50 or more inserts, updates, or deletes, autovacuum will analyze it, keeping the value of autovacuum_analyze_scale_factor multiplied by the number of table rows as a controlling factor.

autovacuum_vacuum_cost_limit:
	The autovacuum_vacuum_cost_limit parameter controls the amount of CPU and I/O resources that an autovacuum worker can consume.
	The parameter specifies a cost limit, which is a unit of work that the worker is allowed to perform before it must pause and check to see if it's still under the limit. For example, if the parameter is set to 2,000, a worker is allowed to process 2,000 units of work before pausing.
	You can set the autovacuum_vacuum_cost_limit parameter by using the SET command in a PostgreSQL session, or use an AWS CLI command.
	Default value: GREATEST({log(DBInstanceClassMemory/21474836480)*600},200)
	If you set the value of autovacuum_vacuum_cost_limit too high, the autovacuum process might consume too many resources and slow down other queries. If you set it too low, the autovacuum process might not reclaim enough space, which causes the table to become larger over time. It's essential to find the right balance that works for your system.
	This parameter affects only the autovacuum process, not the manual VACUUM commands. Also, it only applies to the autovacuum processes for VACUUM but not for ANALYZE.

*/
