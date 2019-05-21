SELECT DISTINCT A.SID "waiting sid", D.SQL_TEXT "waiting SQL",
                A.ROW_WAIT_OBJ# "locked object",
                A.BLOCKING_SESSION "blocking sid",
                C.SQL_TEXT "SQL from blocking session"
           FROM V$SESSION A, V$ACTIVE_SESSION_HISTORY B, V$SQL C, V$SQL D
          WHERE A.EVENT = 'enq: TX - row lock contention'
            AND A.SQL_ID = D.SQL_ID
            AND A.BLOCKING_SESSION = B.SESSION_ID
            AND C.SQL_ID = B.SQL_ID
            AND B.CURRENT_OBJ# = A.ROW_WAIT_OBJ#
            AND B.CURRENT_FILE# = A.ROW_WAIT_FILE#
            AND B.CURRENT_BLOCK# = A.ROW_WAIT_BLOCK#