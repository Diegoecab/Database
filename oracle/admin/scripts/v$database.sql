col current_scn for 9999999999999999999999999999999999999999999999
select dbid,name,current_scn, created,open_mode,force_logging,database_role,log_mode,archivelog_compression from v$database
/