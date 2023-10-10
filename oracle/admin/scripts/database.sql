set lines 900
col current_scn for 9999999999999999
select dbid,name,db_unique_name,current_scn, created,open_mode,force_logging,database_role,log_mode,archivelog_compression from v$database
/

var v_current_scn number;
begin
select current_scn into :v_current_scn from v$database;
end;
/

select scn_to_timestamp(:v_current_scn) as scn_timestamp from dual;