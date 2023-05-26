set heading off

SELECT   SYSDATE FROM DUAL;

set heading on
set verify off
undefine all

ttitle 'Tablespaces'

col dummy noprint

col  pct_used format 999
col  name    format a30
col  alloc   format 999999999 heading "ALLOC_MB"
col  used    format 999999999 heading "USED_MB"
col  free    format 999999999 heading "FREE_MB"
col  " DFs / Aut" format a10
col  max_size format 9999999
col  max_size_file format 9999999
col    block_size format a7
col Ctl format a3
col mxfrag format 999999 justify c heading 'MAX_FRAG_MB'
col nfrags  format 9999999 justify c
col pct_max_alloc for 999


Break on name on report

compute sum of alloc on report
compute sum of free  on report
compute sum of used  on report

set termout off
SET SERVEROUTPUT off;


-- < 1 prevents sqlplus from prompting for a value when it's not provided
column 1 new_value 1
SELECT '' "1" FROM dual WHERE ROWNUM = 0;

-- </ 1


variable tbs_usage number
 --Default  tbs_usage
execute :tbs_usage := nvl('&1', -1);



set termout on

set lines 900
set pages 10000



SELECT   a.name,
         ROUND (alloc) alloc,
         ROUND (free) free,
         ROUND (alloc - free) used,
         100 - ROUND ( (MAX - (alloc - free)) / MAX * 100) pct_used,
         '  ' || LPAD (dfs, 2, ' ') || ' / ' || LPAD (auto, 2, ' ') || ' '
            " DFs / Aut",
         a.nfrags,
         a.mxfrag,
         DECODE (auto, dfs, '   ', 0, '   ', ' X') Ctl,
         MAX Max_Size,
         maxf Max_Size_file,
         ROUND (DECODE (MAX, 0, 0, (alloc / MAX) * 100)) pct_max_alloc,
		 status,
		 logging,
		 extent_management, 
		 segment_space_management,
		 b.block_size / 1024 || 'K' block_size,
		 b.def_tab_compression
  FROM      (  SELECT   NVL (b.tablespace_name,
                             NVL (a.tablespace_name, 'UNKNOW'))
                           name,
                        alloc,
                        NVL (free, 0) free,
                        auto,
                        dfs,
                        --       maxn,
                        NVL (MAX, 0) + NVL (maxn, 0) MAX,
                        NVL (maxf, 0) maxf,
                        nfrags,
                        mxfrag
                 FROM   (  SELECT   ROUND (SUM (bytes) / 1024 / 1024) free,
                                    COUNT (bytes) nfrags,
                                    NVL (MAX (bytes) / 1024 / 1024, 0) mxfrag,
                                    tablespace_name
                             FROM   sys.dba_free_space
                         GROUP BY   tablespace_name) a,
                        (  SELECT   SUM (bytes) / 1024 / 1024 alloc,
                                    SUM (maxbytes) / 1024 / 1024 MAX,
                                    MAX (maxbytes) / 1024 / 1024 maxf,
                                    (SELECT   SUM (bytes) / 1024 / 1024
                                       FROM   dba_data_Files df3
                                      WHERE   df3.tablespace_name =
                                                 df1.tablespace_name
                                              AND df3.AUTOEXTENSIBLE = 'NO')
                                       maxn,
                                    tablespace_name,
                                    (SELECT   COUNT ( * )
                                       FROM   dba_data_files df2
                                      WHERE   df2.tablespace_name =
                                                 df1.tablespace_name
                                              AND df2.AUTOEXTENSIBLE = 'YES')
                                       auto,
                                    COUNT ( * ) dfs
                             FROM   sys.dba_data_files df1
                         GROUP BY   tablespace_name
                         UNION ALL
                           SELECT   SUM (bytes) / 1024 / 1024 alloc,
                                    SUM (maxbytes) / 1024 / 1024 MAX,
                                    MAX (maxbytes) / 1024 / 1024 maxf,
                                    (SELECT   SUM (bytes) / 1024 / 1024
                                       FROM   dba_temp_Files df3
                                      WHERE   df3.tablespace_name =
                                                 tablespace_name
                                              AND df3.AUTOEXTENSIBLE = 'NO')
                                       maxn,
                                    tablespace_name,
                                    (SELECT   COUNT ( * )
                                       FROM   dba_temp_files df2
                                      WHERE   df2.tablespace_name =
                                                 tablespace_name
                                              AND df2.AUTOEXTENSIBLE = 'YES')
                                       auto,
                                    COUNT ( * ) dfs
                             FROM   sys.dba_temp_files
                         GROUP BY   tablespace_name) b
                WHERE   a.tablespace_name(+) = b.tablespace_name
             ORDER BY   1) a
         INNER JOIN
            dba_tablespaces b
         ON b.tablespace_name = a.name
		 and 100 - round ( (max - (alloc - free)) / max * 100) > to_number(nvl(:tbs_usage,'-1'))
		 ORDER BY 3;


ttitle off
clear col