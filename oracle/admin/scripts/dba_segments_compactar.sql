--dba_segments_compactar.sql
REM LOCATION:   Object Management\Tables\Reports
REM FUNCTION:   Tables that may benefit from a rebuild.
REM TESTED ON:  10.2.0.3, 11.1.0.6 (Will not work versions < 10.1.)
REM PLATFORM:   non-specific
REM REQUIRES:   dba_tables, dba_segments, v$parameter.
REM             Tables must be analyzed.
REM NOTE:       The use of the FIRST_ROWS hint is needed to bypass a bug in 10g
REM             when querying the VALUE column if v$parameter. It can be removed
REM             if you are using this query with Oracle 11g, as this problem
REM             has been corrected. Reference Metalink note 1016476.102 for more info.
REM
REM  This is a part of the Knowledge Xpert for Oracle Administration library.
REM  Copyright (C) 2008 Quest Software
REM  All rights reserved.
REM
REM ******************** Knowledge Xpert for Oracle Administration ********************
UNDEF ENTER_OWNER_NAME
--UNDEF ENTER_TABLE_NAME

SET pages 56 lines 132 newpage 0 verify off echo off feedback off
SET serveroutput on
-- when the table is > 10 blocks and
-- total space usage up to the  HWM is < 30% of the size of the HWM, we will consider the table 
-- a candidate for shrinking. 

BEGIN
   DBMS_OUTPUT.put_line
      ('This report produces a list of tables that may benefit from compacting.'
      );
   DBMS_OUTPUT.put_line (CHR (13));

   FOR space_usage IN
      (SELECT /*+ FIRST_ROWS */
              dba_tables.owner, dba_tables.table_name,
              dba_tables.blocks blocks_below,
              dba_segments.blocks total_blocks,
              dba_tables.num_rows * dba_tables.avg_row_len total_data_size,
              ROUND ((  100
                      * (dba_tables.num_rows * dba_tables.avg_row_len)
                      / (GREATEST (dba_tables.blocks, 1) * v$parameter.VALUE)
                     ),
                     3
                    ) hwm_full,
              ROUND ((  100
                      * (dba_tables.num_rows * dba_tables.avg_row_len)
                      / (GREATEST (dba_segments.blocks, 1) * v$parameter.VALUE
                        )
                     ),
                     3
                    ) space_full
         FROM dba_tables, v$parameter, dba_segments
        WHERE dba_tables.owner NOT IN ('SYS', 'SYSTEM')
          AND dba_tables.owner LIKE UPPER ('&&ENTER_OWNER_NAME')
         -- AND dba_tables.table_name LIKE UPPER ('&&ENTER_TABLE_NAME')
          AND dba_tables.owner = dba_segments.owner
          AND dba_tables.table_name = dba_segments.segment_name
          AND v$parameter.NAME = LOWER ('db_block_size')
          AND (  100
               * (dba_tables.num_rows * dba_tables.avg_row_len)
               / (GREATEST (dba_segments.blocks, 1) * v$parameter.VALUE)
              ) < 30
          AND dba_segments.blocks > 10)
   LOOP
      DBMS_OUTPUT.put_line (   'Candidate table is '
                            || space_usage.owner
                            || '.'
                            || space_usage.table_name
                           );
      DBMS_OUTPUT.put_line (   'Which is using  '
                            || space_usage.space_full
                            || '% of allocated space. '
                           );
      DBMS_OUTPUT.put_line (   'Which is using  '
                            || space_usage.hwm_full
                            || '% of allocated space to the HWM. '
                           );
      DBMS_OUTPUT.put_line ('You can use this script to compact the table:');
      DBMS_OUTPUT.put_line (   'alter table '
                            || space_usage.owner
                            || '.'
                            || space_usage.table_name
                            || ' enable row movement; '
                           );
      DBMS_OUTPUT.put_line (   'alter table '
                            || space_usage.owner
                            || '.'
                            || space_usage.table_name
                            || ' shrink space cascade; '
                           );
      DBMS_OUTPUT.put_line (CHR (13));
   END LOOP;
END;
/