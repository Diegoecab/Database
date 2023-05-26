set pagesize 1000 
col first_scn format 999999999999999999 
col next_scn format 999999999999999999 
alter session set nls_date_format='dd-mon-yyyy hh24:mi:ss'; 
select source_database,thread#,sequence#,name,modified_time,first_scn,next_scn,dictionary_begin,dictionary_end from dba_registered_archived_log where 634962926571  between first_scn and next_scn; 