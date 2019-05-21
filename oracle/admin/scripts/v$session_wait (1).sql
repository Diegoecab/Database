set pagesize 100
SELECT
event,
   p1 "file#",
   p2 "block#",
   p3 "class#"
FROM
   v$session_wait order by 1;