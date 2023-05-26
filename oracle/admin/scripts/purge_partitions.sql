REM
REM AUTHOR
REM   Diego Cabrera
REM
REM SCRIPT
REM   purge_partitions.sql
REM
REM DESCRIPTION
REM   
REM

set serveroutput on
set feed off
declare
  l_limit_date date := sysdate-30;
  l_table_name varchar2(100) := 'TABLA1_PART';
  l_curr_date date;
begin
 select sysdate into l_curr_date from dual;
  dbms_output.put_line ('##############################################################################');
  dbms_output.put_line (to_char(l_curr_date,'dd-mm-yy hh24:mi:ss'));
  dbms_output.put_line ('Purging partitions for table '||l_table_name||' limit date '||l_limit_date);
  dbms_output.put_line ('##############################################################################');
  dbms_output.put_line(chr(10));
  for c in (select table_name,
                   partition_name,
                   interval,
                   high_value_in_date_format
              from (select table_name,
                           partition_name,
                           interval,
                           to_date(trim('''' from regexp_substr(extractvalue(dbms_xmlgen.
                                                                   getxmltype('select high_value from user_tab_partitions where table_name=''' ||
                                                                              table_name ||
                                                                              ''' and partition_name = ''' ||
                                                                              partition_name || ''''),
                                                                   '//text()'),
                                                      '''.*?''')),
                                   'syyyy-mm-dd hh24:mi:ss') high_value_in_date_format
                      from user_tab_partitions
                     where table_name = l_table_name)
             where high_value_in_date_format <= l_limit_date
             order by high_value_in_date_format) 
  loop
    if (c.interval = 'NO') then
	dbms_output.put_line ('Truncate table '||c.table_name||' partition ' || c.partition_name||' for high_value '||c.high_value_in_date_format);
      --execute immediate 'alter table '||c.table_name||' truncate partition ' || c.partition_name;
    else
	dbms_output.put_line ('Drop table '||c.table_name||' partition ' || c.partition_name||' for high_value '||c.high_value_in_date_format);
      --execute immediate 'alter table '||c.table_name||' drop partition ' ||  c.partition_name;
    end if;
  end loop;
  select sysdate into l_curr_date from dual;
  dbms_output.put_line(chr(10));
  dbms_output.put_line ('##############################################################################');
  dbms_output.put_line (to_char(l_curr_date,'dd-mm-yy hh24:mi:ss'));
  dbms_output.put_line ('Script finished');
  dbms_output.put_line ('##############################################################################');
end;
/