alter session set query_rewrite_enabled = true;
alter session set query_rewrite_integrity = trusted;
alter session set optimizer_goal=first_rows

create or replace package stats
as
     cnt number default 0;
end;
/
 
create or replace function my_soundex( p_string in varchar2 ) return varchar2
deterministic
as
     l_return_string varchar2(6) default substr( p_string, 1, 1 );
     l_char      varchar2(1);
     l_last_digit     number default 0;
  
     type vcArray is table of varchar2(10) index by binary_integer;
     l_code_table     vcArray;
  
begin
     stats.cnt := stats.cnt+1;
 
     l_code_table(1) := 'BPFV';
     l_code_table(2) := 'CSKGJQXZ';
     l_code_table(3) := 'DT';
     l_code_table(4) := 'L';
     l_code_table(5) := 'MN';
     l_code_table(6) := 'R';


     for i in 1 .. length(p_string)
     loop
         exit when (length(l_return_string) = 6);
         l_char := substr( p_string, i, 1 );

         for j in 1 .. l_code_table.count
         loop
         if ( instr( l_code_table(j), l_char ) > 0 AND j <> l_last_digit )
         then
             l_return_string := l_return_string || to_char(j,'fm9');
             l_last_digit := j;
         end if;
         end loop;
     end loop;

     return rpad( l_return_string, 6, '0' );
end;
/
 
drop table test_soundex;

create table test_soundex( name varchar2(30) );

set timing on
 
insert into test_soundex
select object_name
  from all_objects
 where rownum <= 1000;

set autotrace on explain
exec stats.cnt := 0;

select name
  from test_soundex A
 where my_soundex(name) = my_soundex( 'FILE$' )
/

set autotrace off
set timing off
exec dbms_output.put_line( stats.cnt )
 
drop table test_soundex;

create table test_soundex( name varchar2(30), x int );

create or replace view test_soundex_v
as
select name, substr(my_soundex(name),1,6) name_soundex
  from test_soundex
/

create index test_soundex_idx on test_soundex( substr(my_soundex(name),1,6) )
/
 
set timing on
 
exec stats.cnt := 0;

insert into test_soundex
select object_name, 0
  from all_objects
 where rownum <= 1000;

exec dbms_output.put_line( stats.cnt )

set autotrace on explain
exec stats.cnt := 0;

select name
  from test_soundex  B
 where substr(my_soundex(name),1,6) = my_soundex( 'FILE$' )
/

exec dbms_output.put_line( stats.cnt )
 
exec stats.cnt := 0;

select name
  from test_soundex_v B
 where name_soundex = my_soundex( 'FILE$' )
/

exec dbms_output.put_line( stats.cnt )



create or replace view test_soundex_v
as
select name, substr(my_soundex(name),1,6) name_soundex
  from test_soundex
/

set timing on
set autotrace on explain
 
exec stats.cnt := 0;

select name
  from test_soundex_v B
 where name_soundex = my_soundex( 'FILE$' )
/

exec dbms_output.put_line( stats.cnt )

set autotrace off
set timing off
spoo off

