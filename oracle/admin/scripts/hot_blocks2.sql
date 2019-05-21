-- How To Identify a Hot Block Within The Database Buffer Cache.
--  	Doc ID: 	Note:163424.1

prompt
prompt conectarse como sysdba !!!!!
prompt
prompt By examining the waits on this latch, information about the segment and the 
prompt specific block can be obtained using the following queries.
prompt
prompt First determine which latch id(ADDR) are interesting by examining the number of 
prompt sleeps for this latch. The higher the sleep count, the more interesting the 
prompt latch id(ADDR) is:

select CHILD#  "cCHILD"
,      ADDR    "sADDR"
,      GETS    "sGETS"
,      MISSES  "sMISSES"
,      SLEEPS  "sSLEEPS" 
from v$latch_children 
where name = 'cache buffers chains'
order by 5, 1, 2, 3;

prompt
prompt Run the above query a few times to to establish the id(ADDR) that has the most 
prompt  consistent amount of sleeps. Once the id(ADDR) with the highest sleep count is found
prompt then this latch address can be used to get more details about the blocks
prompt currently in the buffer cache protected by this latch. 
prompt The query below should be run just after determining the ADDR with 
prompt the highest sleep count.
prompt

accept ADDR_Value prompt "Enter ADDR from query above: "


column segment_name format a35
select /*+ RULE */
  e.owner ||'.'|| e.segment_name  segment_name,
  e.extent_id  extent#,
  x.dbablk - e.block_id + 1  block#,
  x.tch,
  l.child#
from
  sys.v$latch_children  l,
  sys.x$bh  x,
  sys.dba_extents  e
where
  x.hladdr  = '&ADDR_Value' and
  e.file_id = x.file# and
  x.hladdr = l.addr and
  x.dbablk between e.block_id and e.block_id + e.blocks -1
  order by x.tch desc ;



prompt
prompt
prompt Example of the output :
prompt SEGMENT_NAME                          EXTENT#       BLOCK#    TCH     CHILD#
prompt -------------------------------- ------------ ------------ ------ ----------
prompt SCOTT.EMP_PK                             5          474       17      7,668
prompt SCOTT.EMP                                1          449        2      7,668

prompt Depending on the TCH column (The number of times the block is hit by a SQL 
prompt statement), you can identify a hotblock. The higher the value of the TCH column,
prompt the more frequent the block is accessed by SQL statements.
prompt
prompt In order to reduce contention for this object the following mechanisms can be put in place:
prompt
prompt    1)Examine the application to see if the execution of certain DML
prompt     and SELECT statements can be reorganized to eliminate contention
prompt     on the object.
prompt   2)Decrease the buffer cache -although this may only help in a small amount of cases.
prompt   3)DBWR throughput may have a factor in this as well.
prompt      If using multiple DBWR's then increase the number of DBWR's
prompt   4)Increase the PCTFREE for the table storage parameters via ALTER TABLE 
prompt     or rebuild. This will result in less rows per block.
prompt   5)Consider implementing reverse key indexes 
prompt     (if range scans aren't commonly used against the segment)
 