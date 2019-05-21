--shared_pool_memory_alloc.sql
SET PAGESIZE 9999
    SET LINESIZE 256
    SET TRIMOUT ON
    SET TRIMSPOOL ON
    COL 'Total Shared Pool Usage' FORMAT 99999999999999999999999
    COL bytes FORMAT 999999999999999
    COL current_size FORMAT 999999999999999
    COL name FORMAT A40
    COL value FORMAT A20
    ALTER SESSION SET nls_date_format='DD-MON-YYYY HH24:MI:SS';

--    SPOOL SGAPARAMS.TXT
prompt  
prompt Database identification 
prompt  
    SELECT name, platform_id, database_role FROM v$database;
    SELECT * FROM v$version WHERE banner LIKE 'Oracle Database%';
prompt  
prompt  Current instance parameter values 
prompt  
    SELECT n.ksppinm name, v.KSPPSTVL value
    FROM x$ksppi n, x$ksppsv v
    WHERE n.indx = v.indx
    AND (n.ksppinm LIKE '%shared_pool%' OR n.ksppinm IN ('_kghdsidx_count', '_ksmg_granule_size', '_memory_imm_mode_without_autosga'))
    ORDER BY 1;

prompt  
prompt  Current memory settings
prompt  
    SELECT component, current_size FROM v$sga_dynamic_components;

    /* Memory resizing operations */
    --SELECT start_time, end_time, component, oper_type, oper_mode, initial_size, target_size, final_size, status 
    --FROM v$sga_resize_ops
    --ORDER BY 1, 2;

    /* Historical memory resizing operations */
  --SELECT start_time, end_time, component, oper_type, oper_mode, initial_size, target_size, final_size, status 
--    FROM dba_hist_memory_resize_ops
    --ORDER BY 1, 2;

prompt  
prompt  Shared pool 4031 information
prompt  
    SELECT request_failures, last_failure_size FROM v$shared_pool_reserved;
prompt  
prompt Shared pool reserved 4031 information
prompt  
    SELECT requests, request_misses, free_space, avg_free_size, free_count, max_free_size FROM v$shared_pool_reserved;

prompt  
prompt Shared pool memory allocations by size
prompt  
    SELECT name, bytes FROM v$sgastat WHERE pool = 'shared pool' AND (bytes > 999999 OR name = 'free memory') ORDER BY bytes DESC;

prompt  
prompt Total shared pool usage
prompt  
    SELECT SUM(bytes) "Total Shared Pool Usage" FROM v$sgastat WHERE pool = 'shared pool' AND name != 'free memory';
prompt  
prompt  Cursor sharability problems
prompt  
prompt This version is for >= 10g; for <= 9i substitute ss.kglhdpar for ss.address!!!!
prompt  
    SELECT sa.sql_text,sa.version_count,ss.*
    FROM v$sqlarea sa,v$sql_shared_cursor ss
    WHERE sa.address=ss.address AND sa.version_count > 50
    ORDER BY sa.version_count ;

    --SPOOL OFF