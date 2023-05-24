--dba_services
col name for a20 truncate
col network_name for a20 truncate
col pdb for a20 truncate
select name, network_name, enabled, pdb, GLOBAL_SERVICE, GOAL,EDITION from dba_services;
select name, network_name, enabled, pdb, GLOBAL_SERVICE, GOAL,EDITION from cdb_services;