column username format a14
set pagesize 500

break on username 

  column "Current UGA memory" format a30
SELECT username, value/1024 || 'KB' "Current UGA memory"
   FROM v$session sess, v$sesstat stat, v$statname name
WHERE sess.sid = stat.sid
   AND stat.statistic# = name.statistic#
   AND name.name = 'session uga memory' and sess.username is not null order by value DESC;
   