connect sh/sh
alter session set nls_date_format='mm/dd hh24:mi:ss';
-- delete statistics
exec dbms_stats.delete_table_stats('SH', 'CUSTOMERS_OBE');

