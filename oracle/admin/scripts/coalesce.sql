REM ************************************************************************

REM * Script start from here.

REM ************************************************************************

 

REM ****************** Check V_USED_SPACE View *******************

SET ECHO off;

SET FEEDBACK off

CREATE  OR  REPLACE  VIEW v_used_space AS SELECT  tablespace_name, sum(bytes) bytes

FROM dba_segments GROUP  BY  tablespace_name;

REM ****************** Check V_FREE_SPACE View *******************

CREATE  OR  REPLACE  VIEW v_free_space AS SELECT  tablespace_name, sum(bytes) bytes,

max(bytes) MAX_BYTES  FROM dba_free_space GROUP  BY  tablespace_name;

 

REM ****************** Check V_TOTAL_SPACE View *******************

CREATE  OR  REPLACE  VIEW  v_total_space AS  SELECT tablespace_name, sum(bytes) bytes

FROM dba_data_files a WHERE  EXISTS (SELECT 'x' FROM  dba_tablespaces b

   WHERE  b.tablespace_name = a.tablespace_name  and b.status = 'ONLINE')

GROUP  BY  tablespace_name

UNION

SELECT  ts.name,sum(bytes) bytes FROM  v$tempfile tm,ts$ ts

WHERE  tm.ts#=ts.ts#  GROUP  BY  ts.name;

 

REM ****************** Check V_SEGMENTS View *******************

CREATE  OR   REPLACE  VIEW  v_segments AS  SELECT  table_name segment_name,

       'TABLE' segment_type,   owner,tablespace_name,   initial_extent, next_extent,

       min_extents,max_extents,pct_increase FROM dba_tables

UNION

SELECt index_name segment_name, 'INDEX' segment_type, owner,tablespace_name,

       initial_extent,next_extent,min_extents,max_extents,pct_increase FROM  dba_indexes

UNION

SELECT segment_name,'ROLLBACK' segment_type,owner,tablespace_name, initial_extent,

       next_extent, min_extents, max_extents,pct_increase FROM dba_rollback_segs;

 

REM ****************** Check V_LARGEST_NEXT View *******************

CREATE  OR  REPLACE  VIEW v_largest_next  AS SELECT tablespace_name, max(next_extent) next_extent

FROM v_segments  GROUP  BY  tablespace_name;

REM ************************************************************************

REM *

REM *    Main program

REM *

REM ************************************************************************

SET  VERIFY off

SET  PAGESIZE 65

SET  LINESIZE 95

SET  PAUSE off

SET  ECHO off

SET  FEEDBACK off

SET  RECSEP off

 

COL  tablespace_name   FORMAT A25          HEADING "Tablespace" tru

COL  megs_used            FORMAT 99990.9    HEADING "Used|(Megs)"

COL  megs_free             FORMAT 99990.9    HEADING "Free|(Megs)"

COL  pct_used               FORMAT 990           HEADING " Pct| Used"

COL max_bytes             FORMAT 9990.9      HEADING "Largest|Free|Extent|(Megs)"

COL max_next_bytes     FORMAT 9990.9      HEADING "Largest|Next|Extent|(Megs)"

COL megs_total             FORMAT 99990.9    HEADING "Total|(Megs)"

COL fragments               FORMAT 99990       HEADING "FRAGMENTS"

 

BREAK ON report SKIP 1

COMPUTE  SUM OF megs_used megs_free  megs_total  ON report

 

TTITLE  SKIP 3 center 'Database  Summary Report by Tablespace' SKIP 2 -

 

SELECT t.tablespace_name,

       nvl(u.bytes,0)/1048576 megs_used,

       nvl(f.bytes,0)/1048576 megs_free,

       t.bytes/1048576 megs_total,

       nvl(f.max_bytes,0)/1048576 MAX_BYTES,

       nvl(n.next_extent,0)/1048576 MAX_NEXT_BYTES,

       (nvl(u.bytes,0)*100)/t.bytes pct_used,

       count(*) FRAGMENTS

FROM sys.v_used_space u, sys.v_free_space f, sys.v_total_space t,

sys.v_largest_next n, sys.ts$ a

WHERE   t.tablespace_name = u.tablespace_name(+)

  AND t.tablespace_name = f.tablespace_name(+)

  AND t.tablespace_name = n.tablespace_name(+)

  AND t.tablespace_name = a.name

GROUP  BY t.tablespace_name,nvl(u.bytes,0)/1048576,nvl(f.bytes,0)/1048576,

t.bytes/1048576,nvl(f.max_bytes,0)/1048576,

nvl(n.next_extent,0)/1048576,t.bytes/1048576,(nvl(u.bytes,0)*100)/t.bytes

ORDER  BY  pct_used  DESC

/