--triggers_fixed_owner.sql

set timing on
set feed on

/*
with x
as
(select owner,name,line,text from 
dba_source where owner not in ('SYS','SYSTEM') and type='TRIGGER' and line between 0 and 10),
y
as
(select owner,trigger_type,trigger_name,table_owner,table_name from dba_triggers where triggering_event not in ('LOGON ','SHUTDOWN ','STARTUP ') )
select y.owner,y.trigger_type,y.trigger_name,x.line,x.text from x,y 
where 
y.owner=x.owner 
and y.trigger_name=x.name 
and upper(x.text) like ('%'||y.table_owner||'.'||y.table_name||'%')
order by owner,trigger_name,line
/
*/

drop table temp_triggers_fixed_dc22057;

create table temp_triggers_fixed_dc22057 (owner varchar2(40),trigger_type varchar2(20),triggering_event varchar2(40),trigger_name varchar2(40),line varchar2(3),text varchar2(200));

set serveroutput on
declare
--tab varchar2(1) := CHR(9);
tab varchar2(3) := ''',''';
begin
for r in
(select owner,trigger_type,triggering_event,trigger_name,table_owner,table_name from dba_triggers where triggering_event not in ('LOGON ','SHUTDOWN ','STARTUP ') order by owner,trigger_name)
loop
	for p in
	(select owner,name,line,text from dba_source where owner not in ('SYS','SYSTEM','MDSYS','WMSYS','XDB','OLAPSYS') and owner=r.owner and name=r.trigger_name and type='TRIGGER' and line between 0 and 10 and upper(text) like ('%'||r.table_owner||'.'||r.table_name||'%'))
	loop
	begin
	--dbms_output.put_line (r.owner||tab||r.trigger_type||tab||r.trigger_name||tab||p.line||tab||p.text);
	execute immediate ('insert into temp_triggers_fixed_dc22057 values ('''||r.owner||tab||r.trigger_type||tab||r.triggering_event||tab||r.trigger_name||tab||p.line||tab||p.text||''')');
	commit;
	exception when others then
	dbms_output.put_line ('Error en '||r.owner||tab||r.trigger_type||tab||r.triggering_event||tab||r.trigger_name||tab||p.line||tab||p.text);
	end;
	end loop;
end loop;
end;
/

col text for a150
col owner for a15
col triggering_event for a30
set lines 300

select * from temp_triggers_fixed_dc22057;

select owner,count(*) from temp_triggers_fixed_dc22057 group by owner order by 1;