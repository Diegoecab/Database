--
-- creates a sql profile from existing sqlprofile to another sqlid
--
-- @dc_clone_sql_profile sql_profile_from sql_id_to child_no_to force_matching
--
-- E.g. @dc_clone_sql_profile coe_2r80mc8s6ws2d_704390078 amdpcwr723x15 1 TRUE
--


set serverout on format wrapped
set sqlblanklines on
set feedback off

declare
ar_profile_hints sys.sqlprof_attr;
cl_sql_text clob;
version varchar2(3);
l_category varchar2(30);
l_force_matching varchar2(3);
b_force_matching boolean;
begin
 select regexp_replace(version,'\..*') into version from v$instance;

if version = '10' then

   execute immediate -- to avoid 942 error 
   'select attr_val as outline_hints '||
   'from dba_sql_profiles p, sqlprof$attr h '||
   'where p.signature = h.signature '||
   'and p.category = h.category  '||
   'and name like (''&&1'') '||
   'order by attr#'
   bulk collect 
   into ar_profile_hints;

elsif version = '11' or version = '12' then

-- dbms_output.put_line('version: '||version);
   execute immediate -- to avoid 942 error 
   'select hint as outline_hints '||
   'from (select p.name, p.signature, p.category, row_number() '||
   '      over (partition by sd.signature, sd.category order by sd.signature) row_num, '||
   '      extractValue(value(t), ''/hint'') hint '||
   'from sys.sqlobj$data sd, dba_sql_profiles p, '||
   '     table(xmlsequence(extract(xmltype(sd.comp_data), '||
   '                               ''/outline_data/hint''))) t '||
   'where sd.obj_type = 1 '||
   'and p.signature = sd.signature '||
   'and p.category = sd.category '||
   'and p.name like (''&&1'')) '||
   'order by row_num'
   bulk collect 
   into ar_profile_hints;

end if;


select
sql_fulltext
into
cl_sql_text
from
gv$sql
where
sql_id = '&&2' --destination sql_id
and child_number = &&3; --destination child_number

dbms_sqltune.import_sql_profile(
sql_text => cl_sql_text
, profile => ar_profile_hints
, category => 'DEFAULT'
, name => 'dc_'||'&&2'||'_'||'&&3'||'_clone'
-- use force_match => true
-- to use CURSOR_SHARING=SIMILAR
-- behaviour, i.e. match even with
-- differing literals
, force_match => &&4
);
end;
/

