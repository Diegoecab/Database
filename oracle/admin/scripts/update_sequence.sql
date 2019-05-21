declare 
v_max_col number := 0;
v_max_seq number := 0;
v_diff number := 0;
v_owner_table varchar2(100) := '&v_owner_table';
v_column_name varchar2(100) := '&v_column_name';
v_table_name varchar2(100) := '&v_table_name';

v_owner_sequence varchar2(100) := '&v_owner_sequence';
v_sequence_name varchar2(100) := '&v_sequence_name';

begin
execute immediate ('select max('||v_column_name||') from '||v_owner_table||'.'||v_table_name) into v_max_col;
execute immediate ('select LAST_NUMBER from dba_Sequences where sequence_owner= UPPER('''||v_owner_sequence||''') and sequence_name= UPPER('''||v_sequence_name||''')') into v_max_seq;
if v_max_seq < v_max_col then
v_diff := v_max_col - v_max_seq;
dbms_output.put_line ('Diff => '||v_diff);
    for r in 0 .. v_diff loop
    execute immediate ('select '||v_owner_sequence||'.'||v_sequence_name||'.nextval from dual') into v_max_seq;
    end loop;
end if;
dbms_output.put_line ('Current Last Number Sequence => '||v_max_seq);
dbms_output.put_line ('Current max id in table => '||v_max_col);
end;
/