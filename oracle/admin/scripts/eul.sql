-- Behind the scenes...




-- Here are the queries that run behind each portlet in this dashboard

-- BA Metrics

select 'Business Areas' Metric,count(*) "Total"
from EUL5_bas
union all
select 'Workbooks' , count(*)
from EUL5_documents a
union all
select 'Modified Folder Items this Week' , count(*)
from EUL5_expressions i
, EUL5_objs f
, EUL5_ba_obj_links l
, EUL5_bas b
where f.obj_id= i.it_obj_id
and f.obj_id= l.bol_obj_id
and b.ba_id= l.bol_ba_id
and i.exp_updated_date between trunc(next_day(sysdate-7,'SUNDAY')) and sysdate
union all
select 'Modified Folders this Week' , count(*)
from
EUL5_objs f
, EUL5_ba_obj_links l
, EUL5_bas b
where 1=1
and f.obj_id= l.bol_obj_id
and b.ba_id= l.bol_ba_id
and f.obj_updated_date between trunc(next_day(sysdate-7,'SUNDAY')) and sysdate

union all

select 'Reports Run', count(*)

from EUL5_qpp_stats

---------------

Business Areas

select ba_name "Business Area"

,ba_created_by "Creator"

,ba_created_date "Creation Date"

,ba_updated_by "Updated By "

,ba_updated_date "Last Update Date"

,ba_id

from SYSTEM.EUL5_bas

------------------

Folders

select b.ba_name,f.obj_name folder_name,f.obj_id,f.obj_ext_owner Owner

from

SYSTEM.EUL5_objs f

, SYSTEM.EUL5_ba_obj_links l

, SYSTEM.EUL5_bas b

where 1=1

and f.obj_id= l.bol_obj_id

and b.ba_id= l.bol_ba_id

and upper(b.ba_name) like upper('Video Store Tutorial')

and upper(f.obj_name) like upper('%')

order by b.ba_name,f.obj_name

----------------

Folder Items

select i.exp_name item_name,i.exp_id,i.it_ext_column

,f.obj_name folder_name

,b.ba_name, i.*

from SYSTEM.EUL5_expressions i

, SYSTEM.EUL5_objs f

, SYSTEM.EUL5_ba_obj_links l

, SYSTEM.EUL5_bas b

where f.obj_id= i.it_obj_id

--and f.obj_name like

and f.obj_id= l.bol_obj_id

and b.ba_id= l.bol_ba_id

and upper(i.exp_name) like upper('%')

and upper(b.ba_name) like upper('Video Store Tutorial')

and upper(f.obj_name) like upper('Products')

order by b.ba_name,f.obj_name,i.exp_name

---------------------------

Folder Joins

select key_description

from SYSTEM.EUL5_key_cons

----------------------------------

Average Run Time

select replace(qs_doc_name,'LINKSYS','') ||' ('||

qs_doc_details||')' "Workbook (Worksheet)",

round(avg(qs_act_cpu_time)/60,2) cpu_time,

round(avg(qs_act_elap_time)/60,2) total_time

from SYSTEM.EUL5_qpp_stats

where upper(qs_doc_name) like upper('%')