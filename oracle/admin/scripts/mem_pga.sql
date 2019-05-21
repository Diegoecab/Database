set linesize 150

prompt from Note:223730.1


SELECT * FROM V$PGASTAT;

prompt over allocation count  must be  0

sELECT LOW_OPTIMAL_SIZE/1024 low_kb,(HIGH_OPTIMAL_SIZE+1)/1024 high_kb,
       optimal_executions, onepass_executions, multipasses_executions
FROM   v$sql_workarea_histogram
WHERE  total_executions != 0;

prompt
prompt You can also use V$SQL_WORKAREA_HISTOGRAM to find the percentage of times work 
prompt areas were executed in optimal, one-pass, or multi-pass mode since start-up.


SELECT optimal_count, round(optimal_count*100/total, 2) optimal_perc,
       onepass_count, round(onepass_count*100/total, 2) onepass_perc,
       multipass_count, round(multipass_count*100/total, 2) multipass_perc
FROM
       (SELECT decode(sum(total_executions), 0, 1, sum(total_executions)) total,
               sum(OPTIMAL_EXECUTIONS) optimal_count,
               sum(ONEPASS_EXECUTIONS) onepass_count,
               sum(MULTIPASSES_EXECUTIONS) multipass_count
        FROM   v$sql_workarea_histogram
        WHERE  low_optimal_size > 64*1024);   
---- for 64 K optimal size 




prompt
prompt - V$SQL_WORKAREA_ACTIVE

prompt This view can be used to display the work areas that are active (or executing) 
prompt in the instance. Small active sorts (under 64 KB) are excluded from the view. 
prompt Use this view to precisely monitor the size of all active work areas and to 
prompt determine if these active work areas spill to a temporary segment.

SELECT to_number(decode(SID, 65535, NULL, SID)) sid,
       operation_type OPERATION,trunc(EXPECTED_SIZE/1024) ESIZE,
       trunc(ACTUAL_MEM_USED/1024) MEM, trunc(MAX_MEM_USED/1024) "MAX MEM",
       NUMBER_PASSES PASS, trunc(TEMPSEG_SIZE/1024) TSIZE
FROM V$SQL_WORKAREA_ACTIVE
ORDER BY 1,2;

prompt
prompt V$PGA_TARGET_ADVICE

select * from V$PGA_TARGET_ADVICE;