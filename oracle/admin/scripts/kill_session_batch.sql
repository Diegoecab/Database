--kill_session_batch.sql

set serveroutput on

break on report

compute sum of num_user_sess active# inactive# on report

PROMPT
PROMPT Sesiones en la base de datos
PROMPT

  SELECT   LPAD (NVL (sess.username, '[B.G. Process]'), 20) username,
           COUNT ( * ) num_user_sess,
           NVL (act.COUNT, 0) active#,
           NVL (inact.COUNT, 0) inactive#
    FROM   v$session sess,
           (  SELECT   COUNT ( * ) COUNT,
                       NVL (username, '[B.G. Process]') username
                FROM   v$session
               WHERE   status = 'ACTIVE'
            GROUP BY   username) act,
           (  SELECT   COUNT ( * ) COUNT,
                       NVL (username, '[B.G. Process]') username
                FROM   v$session
               WHERE   status = 'INACTIVE'
            GROUP BY   username) inact
   WHERE   NVL (sess.username, '[B.G. Process]') = act.username(+)
           AND NVL (sess.username, '[B.G. Process]') = inact.username(+)
GROUP BY   sess.username, act.COUNT, inact.COUNT
ORDER BY   1;

SELECT   sessions_current, sessions_highwater FROM v$license;


begin
for r in (select username, sid, serial# from v$session where username = upper('&username'))
loop
dbms_output.put_line('alter system kill session '''||r.sid||','||r.serial#||''' immediate;');
begin
execute immediate ('alter system kill session '''||r.sid||','||r.serial#||''' immediate');
exception when others then
null;
end;
end loop;
end;
/