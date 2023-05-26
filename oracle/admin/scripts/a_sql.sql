--a_sql
--

define sql_id=&1
@sql_sqltext &sql_id
@sql.sql &sql_id
@dba_hist_snapshot_sqlid.sql &sql_id % % 30
@ash/ashtop username,sql_id sql_id='&sql_id' "sysdate-interval '600' minute" sysdate