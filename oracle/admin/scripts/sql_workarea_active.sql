/*
- V$SQL_WORKAREA_ACTIVE

This view can be used to display the work areas that are active (or executing) 
in the instance. Small active sorts (under 64 KB) are excluded from the view. 
Use this view to precisely monitor the size of all active work areas and to 
determine if these active work areas spill to a temporary segment.
*/

SELECT to_number(decode(SID, 65535, NULL, SID)) sid,
       operation_type OPERATION,trunc(EXPECTED_SIZE/1024) ESIZE,
       trunc(ACTUAL_MEM_USED/1024) MEM, trunc(MAX_MEM_USED/1024) "MAX MEM",
       NUMBER_PASSES PASS, trunc(TEMPSEG_SIZE/1024) TSIZE
FROM V$SQL_WORKAREA_ACTIVE
ORDER BY 1,2;