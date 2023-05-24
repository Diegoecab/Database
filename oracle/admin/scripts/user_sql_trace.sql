ALTER SESSION SET tracefile_identifier = dcabrera;

ALTER SESSION SET sql_trace = true;


SELECT count(*)FROM DTV_PROD_DATA.F_CHURN_PREPAGO;

ALTER SESSION SET sql_trace=FALSE;


TKPROF <trace-file> <output-file> 