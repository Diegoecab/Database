//One row per server process, showing information related to the current activity of that process, such as state and current query. See pg_stat_activity for details.
select * from pg_stat_activity;

//The pg_statio_all_tables view will contain one row for each table in the current database (including TOAST tables), 
//showing statistics about I/O on that specific table. The pg_statio_user_tables and pg_statio_sys_tables views contain the same information, but filtered to only show user and system tables respectively.
//order by Number of disk blocks read from this table
select * from pg_statio_all_tables  order by heap_blks_read desc;



select * from pg_locks;




        SELECT usename, current_query, query_start  
FROM pg_stat_activity order by QUERY_START;




SELECT *
FROM pg_stat_activity order by QUERY_START;



select * from effective_cache_size


select procpid,query_start,datname,current_query from pg_stat_activity where current_query<>'<IDLE>' and not waiting and (query_start + interval '5 minute') < now();


opdb


/optware/abinitio/CoOp.V3-1-1-2/n64/lib/postgresql/bin/psql opdb

/optware/abinitio/CoOp.V3-1-1-2/n64/lib/postgresql/bin/psql -U opdb -c "select procpid, current_query from pg_stat_activity where current_query <> '<IDLE>' ;"



#!/bin/sh
psql -U opdb -c "select procpid,query_start,datname,current_query from pg_stat_activity where current_query<>'<IDLE>' and not waiting and (query_start + interval '5 minute') < now();"




psql -h localhost -U OPDB -c "select procpid,query_start,datname,current_query from pg_stat_activity where current_query<>'<IDLE>' and not waiting and (query_start + interval '5 minute') < now();"

psql -h localhost -c "select procpid,query_start,datname,current_query from pg_stat_activity where current_query<>'<IDLE>' and not waiting and (query_start + interval '5 minute') < now();"


PGPORT=6464; export PGPORT

psql -h localhost -d OPDB -c "select procpid,query_start,datname,current_query from pg_stat_activity where current_query<>'<IDLE>' and not waiting and (query_start + interval '5 minute') < now();"


cat /abinitio/data1/dbdata/OPDB/database/postgresql.conf |more




ab-db sql OPDB 'select procpid,query_start,datname,current_query from pg_stat_activity'







ab-db sql OPDB -c "select procpid,query_start,datname,current_query from pg_stat_activity" OPDB



abadmin@ai001p:/optware/abinitio/CoOp.V3-1-1-2/config > cat OPDB.env
. /abinitio/data1/dbdata/OPDB/db.env
abadmin@ai001p:/optware/abinitio/CoOp.V3-1-1-2/config > . /abinitio/data1/dbdata/OPDB/db.env
abadmin@ai001p:/optware/abinitio/CoOp.V3-1-1-2/config > psql OPDB
Password:
psql (8.4.2)
Type "help" for help.

OPDB=#



abinitio