--sessions_degree.sql

--extracts the mapping of Query Co-coordinator with parallel slaves along with state of parallel slaves, 
--degree of parallelism, wait event that parallel slaves are waiting for, if any

--DOP Degree of parallelism
COL username for a12

COL "QC SID" for A6

COL "SID" for A6

COL "QC/Slave" for A8

COL "Req. DOP" for 9999

COL "Actual DOP" for 9999

COL "Slaveset" for A8

COL "Slave INST" for A9

COL "QC INST" for A6

SET pages 300 lines 300

COL wait_event format a30

SELECT   DECODE (px.qcinst_id,
                 NULL, username,
                    ' - '
                 || LOWER (SUBSTR (pp.server_name,
                                   LENGTH (pp.server_name) - 4,
                                   4
                                  )
                          )
                ) "Username",
         DECODE (px.qcinst_id, NULL, 'QC', '(Slave)') "QC/Slave",
         TO_CHAR (px.server_set) "SlaveSet", TO_CHAR (s.SID) "SID",
         TO_CHAR (px.inst_id) "Slave INST",
         DECODE (sw.state, 'WAITING', 'WAIT', 'NOT WAIT') AS state,
         CASE sw.state
            WHEN 'WAITING'
               THEN SUBSTR (sw.event, 1, 30)
            ELSE NULL
         END AS wait_event,
         DECODE (px.qcinst_id, NULL, TO_CHAR (s.SID), px.qcsid) "QC SID",
         TO_CHAR (px.qcinst_id) "QC INST", px.req_degree "Req. DOP",
         px.DEGREE "Actual DOP"
    FROM gv$px_session px, gv$session s, gv$px_process pp, gv$session_wait sw
   WHERE px.SID = s.SID(+)
     AND px.serial# = s.serial#(+)
     AND px.inst_id = s.inst_id(+)
     AND px.SID = pp.SID(+)
     AND px.serial# = pp.serial#(+)
     AND sw.SID = s.SID
     AND sw.inst_id = s.inst_id
ORDER BY DECODE (px.qcinst_id, NULL, px.inst_id, px.qcinst_id),
         px.qcsid,
         DECODE (px.server_group, NULL, 0, px.server_group),
         px.server_set,
         px.inst_id
/

--his SQL statement will show the actual progress in terms of work allocated to the parallel slave and the amount of work still to be completed by those parallel slaves.

SELECT   DECODE (px.qcinst_id,
                 NULL, username,
                    ' - '
                 || LOWER (SUBSTR (pp.server_name,
                                   LENGTH (pp.server_name) - 4,
                                   4
                                  )
                          )
                ) "Username",
         DECODE (px.qcinst_id, NULL, 'QC', '(Slave)') "QC/Slave",
         TO_CHAR (px.server_set) "SlaveSet", TO_CHAR (px.inst_id)
                                                                 "Slave INST",
         SUBSTR (opname, 1, 30) operation_name, SUBSTR (target, 1, 30) target,
         sofar, totalwork, units, start_time, --TIMESTAMP,
         DECODE (px.qcinst_id, NULL, TO_CHAR (s.SID), px.qcsid) "QC SID",
         TO_CHAR (px.qcinst_id) "QC INST"
    FROM gv$px_session px, gv$px_process pp, gv$session_longops s
   WHERE px.SID = s.SID
     AND px.serial# = s.serial#
     AND px.inst_id = s.inst_id
     AND px.SID = pp.SID(+)
     AND px.serial# = pp.serial#(+)
ORDER BY DECODE (px.qcinst_id, NULL, px.inst_id, px.qcinst_id),
         px.qcsid,
         DECODE (px.server_group, NULL, 0, px.server_group),
         px.server_set,
         px.inst_id
/

--v$pq_tqstat
select
   tq_id,
   server_type,
   process,
   num_rows
from
   v$pq_tqstat
where
   dfo_number =
   (select max(dfo_number)
    from
       v$pq_tqstat)
order by
   tq_id,
   decode (substr(server_type,1,4),
     'Prod', 0, 'Cons', 1, 3)
/