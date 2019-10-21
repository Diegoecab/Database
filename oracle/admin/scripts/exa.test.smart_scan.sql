


--SMART SCAN TEST

SET TIMING on
 
--Tablespace en ASM 
CREATE bigfile TABLESPACE SC_TBS DATAFILE '+DATAC2' size 2G autoextend on next 100M maxsize 50G;


CREATE TABLE TABLE1_OFSTORAGE_ON TABLESPACE SC_TBS AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE dt
         FROM DUAL
   CONNECT BY LEVEL <= 2000000;
   
  
set serveroutput on
begin
for r in 1..8 
loop
	dbms_output.put_line ('insert /*+APPEND*/ into TABLE1_OFSTORAGE_ON select * from TABLE1_OFSTORAGE_ON;');
	insert /*+APPEND*/ into TABLE1_OFSTORAGE_ON select * from TABLE1_OFSTORAGE_ON;
	commit;
end loop;
end;
/


@dba_segments

exit

ALTER SYSTEM flush BUFFER_CACHE;
ALTER SYSTEM flush shared_pool;

set timing on
set autotrace on
select count(*) from (select id from TABLE1_OFSTORAGE_ON) a where a.id between 10002 and 120455;





@exa.io.mystat.sql

SP2-0612: Error generating AUTOTRACE report

  COUNT(*)
----------
  56552448


Elapsed: 00:00:10.24

Execution Plan
----------------------------------------------------------
Plan hash value: 2927852851

--------------------------------------------------------------------------------
------------------

| Id  | Operation                  | Name                | Rows  | Bytes | Cost
(%CPU)| Time     |

--------------------------------------------------------------------------------
------------------

|   0 | SELECT STATEMENT           |                     |     1 |     6 |  2416
   (1)| 00:00:01 |

|   1 |  SORT AGGREGATE            |                     |     1 |     6 |
      |          |

|*  2 |   TABLE ACCESS STORAGE FULL| TABLE1_OFSTORAGE_ON |   110K|   647K|  2416
   (1)| 00:00:01 |

--------------------------------------------------------------------------------
------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - storage("ID"<=120455 AND "ID">=10002)
       filter("ID"<=120455 AND "ID">=10002)

SP2-0612: Error generating AUTOTRACE STATISTICS report
SQL> set autotrace off
SQL> @exa.io.mystat.sql

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical read total bytes                                        34868.6875
physical write total bytes                                                0
cell physical IO interconnect bytes                              633.950668
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes eligible for predicate offload            34860.8203
cell physical IO bytes eligible for smart IOs                    34860.8203
cell physical IO bytes saved by columnar cache                            0
cell physical IO bytes saved by storage index                    1328.13281
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO interconnect bytes returned by smart scan       626.083481

NAME                                                                     MB
---------------------------------------------------------------- ----------
cell physical write bytes saved by smart file initialization              0
cell IO uncompressed bytes                                       33533.6172
cell physical write IO bytes eligible for offload                         0
cell physical write IO host network bytes written during offloa           0

15 rows selected.

Elapsed: 00:00:00.06

--con SMART SCAN DEShabilitado
ALTER DISKGROUP DATAC2 SET ATTRIBUTE 'cell.smart_scan_capable' = 'FALSE';
--tambien se puede deshabilitar en la misma query con el hint /*+ OPT_PARAM('cell_offload_processing' 'false') */

   
   
ALTER TABLE TABLE1_OFSTORAGE_ON rename to TABLE1_OFSTORAGE_OFF;
    
  
@dba_segments
 
ALTER SYSTEM flush BUFFER_CACHE;
ALTER SYSTEM flush shared_pool;

exit

set timing on
set autotrace on
select count(*) from (select id from TABLE1_OFSTORAGE_OFF) a where a.id between 10002 and 120455;
set autotrace off
@exa.io.mystat.sql


  COUNT(*)
----------
  56552448

SP2-0612: Error generating AUTOTRACE report
Elapsed: 00:00:31.90

Execution Plan
----------------------------------------------------------
Plan hash value: 2563767434

--------------------------------------------------------------------------------
-----------

| Id  | Operation          | Name                 | Rows  | Bytes | Cost (%CPU)|
 Time     |

--------------------------------------------------------------------------------
-----------

|   0 | SELECT STATEMENT   |                      |     1 |     6 |  2416   (1)|
 00:00:01 |

|   1 |  SORT AGGREGATE    |                      |     1 |     6 |            |
          |

|*  2 |   TABLE ACCESS FULL| TABLE1_OFSTORAGE_OFF |   110K|   647K|  2416   (1)|
 00:00:01 |

--------------------------------------------------------------------------------
-----------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("ID"<=120455 AND "ID">=10002)

SP2-0612: Error generating AUTOTRACE STATISTICS report
SQL> set autotrace off
SQL> @exa.io.mystat.sql

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical read total bytes                                        34861.3672
physical write total bytes                                                0
cell physical IO interconnect bytes                              34861.3672
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes eligible for predicate offload                     0
cell physical IO bytes eligible for smart IOs                             0
cell physical IO bytes saved by columnar cache                            0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO interconnect bytes returned by smart scan                0

NAME                                                                     MB
---------------------------------------------------------------- ----------
cell physical write bytes saved by smart file initialization              0
cell IO uncompressed bytes                                                0
cell physical write IO bytes eligible for offload                         0
cell physical write IO host network bytes written during offloa           0



ALTER DISKGROUP DATAC2 SET ATTRIBUTE 'cell.smart_scan_capable' = 'TRUE';
DROP TABLESPACE SC_TBS including contents and datafiles;