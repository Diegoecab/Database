select substr(sql_text,1,60), count(*) from v$sqlstats where executions < 4 group by substr(sql_text,1,60) having count(*) >1;

select sql_text,parse_calls, executions  from v$sqlstats order by parse_calls;
