ttitle 'Perfiles'
undefine all
set lines 400
col profile for a100
select * from dba_profiles 
where profile like upper('%&profile%')
order by 1,2;

ttitle off