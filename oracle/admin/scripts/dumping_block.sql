126541


SELECT SEGMENT_NAME, SEGMENT_TYPE, RELATIVE_FNO FROM DBA_EXTENTS WHERE FILE_ID = 1 AND BLOCK_ID BETWEEN BLOCK_ID AND BLOCK_ID + BLOCKS - 1 /


select
   p1 "File #",
   p2 "Block #",
   p3 "Reason Code"
from
   v$session_wait
where
   event = 'buffer busy waits';


alter system dump datafile 1 block 126553;


select name from obj$ where obj# = 5927;
