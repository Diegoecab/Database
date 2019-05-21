set serveroutput on
accept table_owner prompt 'table_owner: '
accept table_name prompt 'table_name: '

accept min_month prompt 'min_month(MM): '
accept min_year prompt 'min_year(YYYY): '
accept cnt_part prompt 'Count of partitions: '
accept add_par prompt 'Aditional parameters (ej. compress pctfree 5): '
declare
v_year number := &min_year;
v_min_month number := &min_month -1;
v2_min_month varchar2(2);
v2_next_month varchar2(2);
v_next_year varchar2(4);
v_next_month varchar2(2);
begin
for r in 1 .. &cnt_part 
loop

if (v_min_month = 12) then
v_min_month := 0;
v_year := v_year +1;
end if;
v_next_year := v_year;
v_min_month := v_min_month +1;


if (v_min_month = 12) then
v_next_month := '1';
v_next_year := v_next_year +1;
else
v_next_month := v_min_month +1;
end if;

if (length(v_min_month) = 1) then 
v2_min_month := '0'||v_min_month;
else 
v2_min_month := v_min_month;
end if;

if (length(v_next_month) = 1) then 
v2_next_month := '0'||v_next_month;
else 
v2_next_month := v_next_month;
end if;

dbms_output.put_line ('alter table &table_owner..&table_name add partition partition_'||v_year||''||v2_min_month||'00 values less than (TO_DATE('' '||v_next_year||'-'||v2_next_month||'-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) &add_par;');
end loop;
end;
/