--https://oracle-base.com/articles/12c/multitenant-resource-manager-cdb-and-pdb-12cr1
--https://oracle-base.com/articles/12c/multitenant-resource-manager-pdb-performance-profiles-12cr2

profile : The profile the directive relates to.
shares : The proportion of the CDB resources available to the PDB.
utilization_limit : The percentage of the CDBs available CPU that is available to the PDB.
parallel_server_limit : The percentage of the CDBs available parallel servers (PARALLEL_SERVERS_TARGET initialization parameter) that are available to the PDB.


DECLARE
  l_plan VARCHAR2(30) := 'cdb_rsrc_plan';
BEGIN
  DBMS_RESOURCE_MANAGER.clear_pending_area;
  DBMS_RESOURCE_MANAGER.create_pending_area;

  DBMS_RESOURCE_MANAGER.create_cdb_plan(
    plan    => l_plan,
    comment => 'CDB resource plan');

  DBMS_RESOURCE_MANAGER.create_cdb_plan_directive(
    plan                  => l_plan, 
    pluggable_database    => 'RIO196', 
    shares                => 1, 
    utilization_limit     => 100,
    parallel_server_limit => 100);

  DBMS_RESOURCE_MANAGER.validate_pending_area;
  DBMS_RESOURCE_MANAGER.submit_pending_area;
END;
/


COLUMN plan FORMAT A30
COLUMN comments FORMAT A30
COLUMN status FORMAT A10
SET LINESIZE 100

SELECT plan_id,
       plan,
       comments,
       status,
       mandatory
FROM   dba_cdb_rsrc_plans
WHERE  plan = 'CDB_RSRC_PLAN';


DECLARE
  l_plan VARCHAR2(30) := 'CDB_RSRC_PLAN';
BEGIN
  DBMS_RESOURCE_MANAGER.clear_pending_area;
  DBMS_RESOURCE_MANAGER.create_pending_area;

  DBMS_RESOURCE_MANAGER.update_cdb_plan_directive(
    plan                      => l_plan, 
    pluggable_database        => 'RIO196', 
    new_shares                => 1, 
    new_utilization_limit     => 75,
    new_parallel_server_limit => 75);

  DBMS_RESOURCE_MANAGER.validate_pending_area;
  DBMS_RESOURCE_MANAGER.submit_pending_area;
END;
/

COLUMN plan FORMAT A30
COLUMN pluggable_database FORMAT A25
COLUMN profile FORMAT A25
SET LINESIZE 150 VERIFY OFF

SELECT plan,
       pluggable_database,
       profile,
       shares,
       utilization_limit AS util,
       parallel_server_limit AS parallel
FROM   dba_cdb_rsrc_plan_directives
WHERE  plan = 'CDB_RSRC_PLAN'
ORDER BY plan, pluggable_database, profile;


alter system set resource_manager_plan=CDB_RSRC_PLAN scope=both;