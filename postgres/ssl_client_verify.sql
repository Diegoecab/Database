--current
create extension sslinfo;
select ssl_is_used();

--all sessions

select datname,
	usename,
	ssl,
	client_addr
from pg_stat_ssl inner join
	pg_stat_activity on pg_stat_ssl.pid = pg_stat_activity.pid
where ssl is true and usename<>'rdsadmin';
