--SQL_WORKAREA_ACTIVE
col OPERATION_TYPE for a20
set lines 180
set pages 200
SELECT 
	inst_id,
	sid
	, operation_type operation_type
	, trunc(expected_size/1024/1024) expected_size_mb
	, trunc(actual_mem_used/1024/1024) actual_mem_used_mb
	, trunc(max_mem_used/1024/1024) max_mem_used_mb
	, number_passes
	, trunc(tempseg_size/1024/1024) tempseg_size_mb
FROM gV$sql_workarea_active
ORDER BY 1,2
/