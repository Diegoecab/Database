col lmode format a10
col request format a10
col program format a15
set linesize 180
SELECT   sn.username, 
         --sn.inst_id, 
          sn.sid, sn.serial#, m.TYPE,
         DECODE (
            m.lmode,
            0, 'None',
            1, 'Null',
            2, 'Row Share',
            3, 'Row
        Excl.',
            4, 'Share',
            5, 'S/Row Excl.',
            6, 'Exclusive',
            LTRIM (TO_CHAR (lmode, '990'))
         ) lmode,
         DECODE (
            m.request,
            0, 'None',
            1, 'Null',
            2, 'Row Share',
            3, 'Row
        Excl.',
            4, 'Share',
            5, 'S/Row Excl.',
            6, 'Exclusive',
            LTRIM (TO_CHAR (m.request, '990'))
         ) request,
         m.id1, m.id2, logon_time,program
    FROM gv$session sn, gv$lock m
   WHERE (sn.inst_id = m.inst_id AND sn.sid = m.sid AND m.request ! = 0)
      OR ( sn.inst_id = m.inst_id AND  sn.sid = m.sid
          AND m.request = 0
          AND lmode != 4
          AND (id1, id2) IN (SELECT s.id1, s.id2
                               FROM gv$lock s
                              WHERE request != 0
                                AND s.id1 = m.id1
                                AND s.id2 = m.id2)
         )
ORDER BY id1, id2, m.request
/
