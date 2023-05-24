--sql_profile_hints.sql
set lines 155
set serverout on format wrapped
set sqlblanklines on
set feedback off
col hint for a150
select hint from (
select p.name, p.signature, p.category,
       row_number()
         over (partition by sd.signature, sd.category order by sd.signature) row_num,
       extractValue(value(t), '/hint') hint
from sys.sqlobj$data sd, dba_sql_profiles p,
     table(xmlsequence(extract(xmltype(sd.comp_data),
                               '/outline_data/hint'))) t
where sd.obj_type = 1
and p.signature = sd.signature
and p.name like nvl('&sqlprofilename',name)
)
order by row_num
/