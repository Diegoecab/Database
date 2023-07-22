aws rds create-db-instance \
        --db-instance-identifier pg1211 \
        --db-name pglab \
        --engine postgres \
        --engine-version 12.11 \
        --master-username postgres \
        --master-user-password  postgres \
        --db-instance-class db.t3.medium \
        --storage-type io1 \
        --iops 1000 \
        --allocated-storage 100 \
        --no-multi-az \
        --db-subnet-group rds-pg-labs-rdslabsrdsstack-26eop8vgzhqn-dbsubnetgroup-qgzyvn1dfx54 \
        --vpc-security-group-ids sg-0181c7c97efbe70c5 \
        --no-publicly-accessible \
        --enable-iam-database-authentication \
        --backup-retention-period 1 \
        --copy-tags-to-snapshot \
        --no-auto-minor-version-upgrade \
        --storage-encrypted \
        --enable-performance-insights \
        --performance-insights-retention-period 7 \
        --enable-cloudwatch-logs-exports '["postgresql","upgrade"]' \
        --no-deletion-protection \
        --region us-east-1


aws rds modify-db-instance \
    --db-instance-identifier pg1211 \
    --db-parameter-group-name postgres12-custom \
    --apply-immediately
	
aws rds reboot-db-instance \
    --db-instance-identifier pg1211

Source DB
1) Set the rds.logical_replication to 1 and Not Configuring the pglogical plugin:


	postgres=> show rds.logical_replication;
	 rds.logical_replication
	-------------------------
	 on
	(1 row)

	postgres=> select * FROM pg_catalog.pg_extension
	postgres-> ;
	  oid  | extname | extowner | extnamespace | extrelocatable | extversion | extconfig | extcondition
	-------+---------+----------+--------------+----------------+------------+-----------+--------------
	 14299 | plpgsql |       10 |           11 | f              | 1.0        |           |
	(1 row)

	postgres=>


2) creating a big table

	postgres=> select current_database();
	 current_database
	------------------
	 postgres
	(1 row)


	postgres=> create table articles3 (code int primary key, article varchar, name varchar, department varchar);
	CREATE TABLE
	postgres=> insert into articles3 (
		code, article, name, department
	)
	select
		(i),
		random()::text,
		random()::text,
		left((random()::text), 4)
	from generate_series(1, 1000000) s(i);
	INSERT 0 1000000
	postgres=>


3) create replication slot

	postgres=> SELECT * FROM pg_create_logical_replication_slot('test_slot', 'test_decoding');
	 slot_name |    lsn
	-----------+------------
	 test_slot | 0/1E30FE88
	(1 row)

	postgres=>
			
			Get the current LSN:

	postgres=> SELECT restart_LSN  FROM pg_replication_slots WHERE slot_name = 'test_slot';
	 restart_lsn
	-------------
	 0/1E30FE50
	(1 row)

	postgres=>


4) creating snapshot and restoring it to pg152

	aws rds create-db-snapshot \
		--db-instance-identifier pg1211 \
		--db-snapshot-identifier mydbsnapshot1211
		
	aws rds restore-db-instance-from-db-snapshot \
		--db-instance-identifier pg152 \
		--db-subnet-group rds-pg-labs-rdslabsrdsstack-26eop8vgzhqn-dbsubnetgroup-qgzyvn1dfx54 \
		 --vpc-security-group-ids sg-0181c7c97efbe70c5 \
		--db-snapshot-identifier mydbsnapshot1211 \
		--db-instance-class db.t3.medium 
5) Deleting rows 

	postgres=> select count(*) from articles3;
	  count
	---------
	 1000000
	(1 row)

	postgres=> delete from articles3 where code>999900;
	DELETE 100
	postgres=> select count(*) from articles3;
	 count
	--------
	 999900
	(1 row)

	postgres=>

Target DB

1) Upgrade DB after minor upgrade to 12.14

	
	aws rds modify-db-instance \
		--db-instance-identifier pg152 \
		--engine-version 15.2 \
		--allow-major-version-upgrade \
		--apply-immediately


2) Verifying the rows of the table articles3 in target database:


	postgres=> select count(*) from articles3;
	  count
	---------
	 1000000
	(1 row)

	postgres=>


DMS task

Creating the CDC task, starting from LSN 0/1E30FE88

{
    "rules": [
        {
            "rule-type": "selection",
            "rule-id": "1",
            "rule-name": "1",
            "object-locator": {
                "schema-name": "%",
                "table-name": "articles3"
            },
            "rule-action": "include",
            "filters": []
        }
    ]
}

aws dms create-replication-task \
    --replication-task-identifier CDCpg1211topg152 \
	--cdc-start-position "0/1E30FE88" \
    --source-endpoint-arn arn:aws:dms:us-east-1:274146641877:endpoint:EM365OHC4SFK666Y3JFWXGWP6MZ3CHCGQ5V6ZHQ	 \
    --target-endpoint-arn arn:aws:dms:us-east-1:274146641877:endpoint:HBVG6NX2WLAIMEJSP44X6CI67YWGSNANQQHO64Y \
    --replication-instance-arn arn:aws:dms:us-east-1:274146641877:rep:LUI5N3XRZ5JJ6RZ2HHR4NOGAYTZWFORAVNJK3NA \
    --migration-type cdc  \
    --table-mappings file://table-mappings.json


Target DB

	1) Verifying that CDC is working

		select count(*) from articles3;
		
		
		
		
		



CREATE USER dms_user WITH LOGIN PASSWORD 'dms_user';
GRANT USAGE ON SCHEMA * TO dms_user;
GRANT CONNECT ON DATABASE postgres to dms_user;
GRANT CREATE ON DATABASE postgres TO dms_user;
GRANT CREATE ON SCHEMA postgres TO dms_user;
GRANT UPDATE, INSERT, SELECT, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA postgres TO dms_user;
