
col stale_percent format a20
set lines 120 
set pages 1000

connect sh/sh
set echo on 

-- This demo shows how to change the default perferences or parameter setting 
-- for gathering statistics. Before we start to change the parameters we 
-- should check what the default settings are. One of the parameters that 
-- people are concerned about is the STALE_PERCENT. STALE_PERCENT determine 
-- the percentage of rows in a table that have to change before the statistics 
-- on that table are deemed stale and should be regathered. The default is 10%
-- We can check the value by running dbms_stats.get_perfs

pause
select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'SALES') stale_percent 
from dual;

-- So the default value for the SALES table is 10%. In order to change a parameter 
-- or preference for the entire database you need to have dba privileges. Once connected 
-- as sysdba we will set the STALE_PRECENT for the entire database to be 13%. Then we 
-- will check again what the STALE_PRECENT value is for the SALES table. 
pause

connect / as sysdba

execute dbms_stats.set_global_prefs('STALE_PERCENT', '13');


connect sh/sh

select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'SALES') stale_percent 
from dual;

-- So now the STALE_PRECENT for the SALES table is 13% or the global value. 
-- What if you only want to change the STALE_PRECENT for a single table.  
-- You can do that by using the set_table_perfs procedure. Lets set the 
-- STALE_PRECENT For the SALES table to 65%. Since we are only changing 
-- one table that belongs to this schema we dont need to be logged in as sysdba.

pause
execute dbms_stats.set_table_prefs('SH', 'SALES', 'STALE_PERCENT', '65');

select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'SALES') stale_percent 
from dual;

-- So the STALE_PRECENT for sales has changed to 65% but what about all the other
-- tables in the schema, what STALE_PRECENT do they now have? Lets check the 
-- STALE_PRECENT for the PRODUCT table, it should be the new global default 13%.

pause
 
select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'PRODUCTS') stale_percent 
from dual;

-- Finally lets reset everything back to the default.
-- So we will delete the table preference we set on SALES.
-- It will then go back to having the global default value.
pause 
execute dbms_stats.delete_table_prefs('SH', 'SALES', 'STALE_PERCENT');

select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'SALES') stale_percent 
from dual;

-- Now we have to reconnect as the sysdba to reset the global defaults.
-- You dont need to remember what the default values are, you simple need
-- to set the preference value to null and that will restore the "factory"
-- default value.

pause
connect / as sysdba

execute dbms_stats.set_global_prefs('STALE_PERCENT', null);

connect sh/sh

select dbms_stats.get_prefs('STALE_PERCENT', 'SH', 'SALES') stale_percent 
from dual;
