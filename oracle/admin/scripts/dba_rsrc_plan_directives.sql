--dba_rsrc_plan_directives
set pages 1000
set lines 900
prompt Resource plan directive
prompt  Used by administrators to associate resource consumer groups with particular plans and allocate resources 
prompt among resource consumer groups 
select plan, group_or_subplan, type, cpu_p1, cpu_p2, cpu_p3, cpu_p4, status 
 from dba_rsrc_plan_directives 
order by 1,2,3,4,5,6;

prompt To see the current resource plan for a non-CDB or PDB for 11.2+ (for PDBs, execute from the PDB's container):
select group_or_subplan, mgmt_p1, mgmt_p2, mgmt_p3, mgmt_p4, mgmt_p5, mgmt_p6, mgmt_p7, mgmt_p8, max_utilization_limit from dba_rsrc_plan_directives where plan = (select name from v$rsrc_plan where is_top_plan = 'TRUE');