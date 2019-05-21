SET SERVEROUTPUT ON
declare maxs number;
BEGIN
for r in (
select column_name from dba_tab_columns where owner='DBADMIN' and table_name='TEST222' and data_type='VARCHAR2'
order by column_id)
loop
execute immediate 'select max(length('||r.column_name||')) from dbadmin.test222' into maxs;
dbms_output.put_line ('"'||R.column_name||'" VARCHAR2('||maxs||'),');
end loop;
END;
/