-- ------------------------------------------------------------------------------
-- File       : tables_to_partition.sql
-- Purpose    : Oracle administration helper: tables to partition.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tables_to_partition.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--tables_To_partition.sql

col segment_name for a30
col col_part for a20
set lines 400

select a.owner,
           segment_name,
           ROUND ( (bytes / 1024 / 1024)) MB,
           b.last_analyzed,
           b.num_rows,
           DECODE ( (SELECT   COUNT ( * )
                       FROM   dba_Tab_partitions
                      WHERE   table_name = a.segment_name),
                   0, 'NO',
                   'YES')
              part,
           (SELECT   DISTINCT column_name
              FROM   dba_part_key_columns
             WHERE   name = a.segment_name)
              col_part,
           DECODE (
              (SELECT   COUNT ( * ) as cant
                 FROM   dba_tab_columns c
                WHERE   c.owner = a.owner AND c.table_name = segment_name
                        AND column_name IN
                                 (SELECT   DISTINCT column_name
                                    FROM   dba_part_key_columns
                                   WHERE   owner NOT IN
                                                 ('SYS', 'SYSTEM', 'AUDITINFO'))),
              0,
              'NO',
              1,
              (SELECT   column_name
                 FROM   dba_tab_columns c
                WHERE   c.owner = a.owner AND c.table_name = segment_name
                        AND column_name IN
                                 (SELECT   DISTINCT column_name
                                    FROM   dba_part_key_columns
                                   WHERE   owner NOT IN
                                                 ('SYS', 'SYSTEM', 'AUDITINFO')))
			 , (SELECT   COUNT ( * ) as cant
                 FROM   dba_tab_columns c
                WHERE   c.owner = a.owner AND c.table_name = segment_name
                        AND column_name IN
                                 (SELECT   DISTINCT column_name
                                    FROM   dba_part_key_columns
                                   WHERE   owner NOT IN
                                                 ('SYS', 'SYSTEM', 'AUDITINFO')))
           )
              col
    FROM   dba_Segments a, dba_tables b
   WHERE       (bytes / 1024 / 1024) > 1024
           AND b.owner = a.owner
           AND b.table_name = a.segment_name
           AND segment_type = 'TABLE'
           AND a.owner <> 'SYS'
ORDER BY   2, 1, 3
/