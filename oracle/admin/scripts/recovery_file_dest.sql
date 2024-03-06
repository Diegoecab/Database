TTITLE 'Flash Recovery Area Status'
COL name                FORMAT A50      HEADING 'File Name'
COL spc_lmt_mb          FORMAT 99999.99  HEADING 'Space|Limit|(MB)'
COL spc_usd_mb          FORMAT 9999.99  HEADING 'Space|Used|(MB)'
COL spc_rcl_mb          FORMAT 9999.99  HEADING 'Reclm|Space|(MB)'
COL number_of_files     FORMAT 99999    HEADING 'Files'

SELECT 
     name
    ,space_limit /(1024*1024) spc_lmt_mb
    ,space_used /(1024*1024) spc_usd_mb
    ,space_reclaimable /(1024*1024) spc_rcl_mb
    ,number_of_files
  FROM v$recovery_file_dest;