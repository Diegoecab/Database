max_connect_errors=10000
log_warnings = 2
max_connections = 950


select @@global.log_warnings
select @@global.max_connect_errors

set @@global.max_connections = 1500;