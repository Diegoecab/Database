ALTER SESSION SET tracefile_identifier = TestDCN;

ALTER SESSION SET sql_trace = true;

ALTER SYSTEM SET TIMED_STATISTICS = TRUE;

select count(*) from system.test;

ALTER SESSION SET sql_trace=FALSE;


TKPROF <trace-file> <output-file> 