ejemplo 
ALTER SESSION SET "_use_nosegment_indexes" = TRUE;
CREATE INDEX IX_USERTYPE ON CUSTOMER.GO_EVENTS (USERTYPE) nosegment;

set autotrace traceonly explain
