exec dbms_stats.gather_system_stats(‘exadata’);
col sname format a15
col pname format a15
col pval2 format a20
set pagesize 25
set echo on
select * from aux_stats$;
