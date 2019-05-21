--dbms_stats_table.sql
REM
set verify off

exec DBMS_STATS.gather_table_stats('&owner', '&table_name', estimate_percent => &estimate_percent, cascade=>&cascade, method_opt=>'FOR ALL COLUMNS SIZE AUTO');
