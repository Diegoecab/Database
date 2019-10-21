--dba_hist_undostat
prompt Longest running queries which could have caused ORA-01555

select *   from dba_hist_undostat where SSOLDERRCNT >0 ;