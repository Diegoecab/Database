--Is OJVM installed?
SELECT version, status FROM dba_registry WHERE comp_id='JAVAVM';





--Is OJVM used?
select count(*) from x$kglob where KGLOBTYP = 29 OR KGLOBTYP = 56;


col service_name format a20
col username format a20
col program format a20
set num 8

select sess.service_name, sess.username,sess.program, count(*)
from
gv$session sess,
dba_users usr,
x$kgllk lk,
x$kglob
where kgllkuse=saddr
and kgllkhdl=kglhdadr
and kglobtyp in (29,56)
and sess.user# = usr.user_id
and usr.oracle_maintained = 'N'      --#### omit this line on 11.2.0.4
group by sess.service_name, sess.username, sess.program
order by sess.service_name, sess.username, sess.program;