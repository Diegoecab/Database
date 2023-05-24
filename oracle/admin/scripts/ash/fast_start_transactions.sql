set lines 300
alter session set NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS'; 

SELECT inst_id,usn, state, undoblockstotal "Total", undoblocksdone "Done", 
undoblockstotal-undoblocksdone "ToDo", 
DECODE(cputime,0,'unknown',SYSDATE+(((undoblockstotal-undoblocksdone) / (undoblocksdone / cputime)) / 86400)) 
"Finish at" 
FROM gv$fast_start_transactions; 