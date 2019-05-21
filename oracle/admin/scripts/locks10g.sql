 select    s.sid locker_sid,
           s.username locker_user,
           substr(s.program,1,40) locker_program,
           w.sid locked_sid,
           w.username locked_user,
           substr(w.program,1,40) locked_program,
           W.SECONDS_IN_WAIT,
           W.STATE,
           W.EVENT
 from v$session s, v$session w
 where w.blocking_session = s.sid
 and w.blocking_session_status='VALID' 
/



PROMPT
PROMPT mas informacion de los lockeos
PROMPT

select s.sid blocker,
       substr(s.program,1,40) program,
       s.ROW_WAIT_OBJ# row_wait_obj_blocker,
       s.ROW_WAIT_FILE#, s.ROW_WAIT_BLOCK#, s.ROW_WAIT_ROW#,
       w.username,
       w.sid blocked,
       substr(w.program,1,40) blocked_program,
       w.ROW_WAIT_OBJ# row_wait_obj_blocker,
w.ROW_WAIT_FILE#, w.ROW_WAIT_BLOCK#, w.ROW_WAIT_ROW#,
   SUBSTR(sa.sql_text, 1, 600) current_sql_blocker,
   SUBSTR(wa.sql_text, 1, 600) current_sql_blocked
from v$session s, v$session w,
    v$process p  
  , v$sqlarea sa
  , v$sqlarea wa
  ,  v$process wp  
where w.blocking_session = s.sid
and w.blocking_session_status='VALID'
and      p.addr           =  s.paddr
	  AND s.sql_address    =  sa.address(+) 
  AND s.sql_hash_value =  sa.hash_value(+)
and      wp.addr           =  w.paddr
	  AND w.sql_address    =  wa.address(+) 
  AND w.sql_hash_value =  wa.hash_value(+)
asdfsdfaczv
/
