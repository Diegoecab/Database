prompt
prompt Discoverer: Average workbook runs by week day
prompt =============================================

select week_day||'-'||run_day Day, 'Average Runs',trunc(sum(runs)/count(run_day)) average_runs
from
(
select run_month,week_day,run_day,month_day,run_year,count(*) runs
from
(
select qs_cost cost
, qs_act_cpu_time cpu_time
, qs_act_elap_time elapsed_time
, qs_num_rows rows_fetched
, qs_doc_owner doc_owner
, qs_doc_name workbook
, qs_doc_details worksheet
, qs_created_date run_date
, to_char(qs_created_date,'D') week_day
, to_char(qs_created_date,'DD') month_day
, to_char(qs_created_date,'Day') run_day
, to_char(qs_created_date,'Mon') run_month
, to_char(qs_created_date,'HH24') run_hour
, to_char(qs_created_date,'YYYY') run_year
from garba_eul.eul5_qpp_stats
where qs_created_date between sysdate - 7 and sysdate
) stats
group by run_month,week_day,run_day,month_day,run_year
)
group by run_day,week_day
order by week_day
/
prompt
prompt Slowest time for workbook
prompt =========================

select round(max(elapsed_time)/60) max_run_time
from
(
select qs_cost cost
, qs_act_cpu_time cpu_time
, qs_act_elap_time elapsed_time
, qs_num_rows rows_fetched
, qs_doc_owner doc_owner
, qs_doc_name workbook
, qs_doc_details worksheet
, qs_created_date run_date
, to_char(qs_created_date,'D') week_day
, to_char(qs_created_date,'DD') month_day
, to_char(qs_created_date,'Day') run_day
, to_char(qs_created_date,'Mon') run_month
, to_char(qs_created_date,'HH24') run_hour
, to_char(qs_created_date,'YYYY') run_year
from garba_eul.eul5_qpp_stats
where trunc(qs_created_date) between trunc(sysdate - 7) and trunc(sysdate)
) stats
/

prompt 
prompt Discoverer report runs total
prompt ============================

select count(*) runs
from
(
select qs_cost cost
, qs_act_cpu_time cpu_time
, qs_act_elap_time elapsed_time
, qs_num_rows rows_fetched
, qs_doc_owner doc_owner
, qs_doc_name workbook
, qs_doc_details worksheet
, qs_created_date run_date
, to_char(qs_created_date,'D') week_day
, to_char(qs_created_date,'DD') month_day
, to_char(qs_created_date,'Day') run_day
, to_char(qs_created_date,'Mon') run_month
, to_char(qs_created_date,'HH24') run_hour
, to_char(qs_created_date,'YYYY') run_year
from garba_eul.eul5_qpp_stats
where trunc(qs_created_date) = trunc(sysdate)
) stats
/

prompt
prompt Workbook runs by Hour
prompt =====================

select run_hour, 'Runs by Hour', round(sum(runs)/ count(run_hour)) hourly_runs
from
(
select run_month,month_day,run_hour,count(*) runs
from
(
select qs_cost cost
, qs_act_cpu_time cpu_time
, qs_act_elap_time elapsed_time
, qs_num_rows rows_fetched
, qs_doc_owner doc_owner
, qs_doc_name workbook
, qs_doc_details worksheet
, qs_created_date run_date
, to_char(qs_created_date,'D') week_day
, to_char(qs_created_date,'DD') month_day
, to_char(qs_created_date,'Day') run_day
, to_char(qs_created_date,'Mon') run_month
, to_char(qs_created_date,'HH24') run_hour
, to_char(qs_created_date,'YYYY') run_year
from garba_eul.eul5_qpp_stats
where qs_created_date between sysdate - 30 and sysdate
) stats
group by run_month,month_day,run_hour
)
group by run_hour
/



prompt
prompt Discoverer change overview
prompt ==========================

select 'New Workbooks' "Category", count(*) cnt from garba_eul.EUL5_DOCUMENTS
where doc_created_date between sysdate- 30 and sysdate
union all
select 'Updated Workbooks' catg, count(*) from garba_eul.EUL5_DOCUMENTS
where doc_updated_date between sysdate-30 and sysdate
union all
select 'Un-Used Workbooks', count(*)
from
garba_eul.EUL5_DOCUMENTS doc
where doc.doc_name not in
(
select distinct qs_doc_name from
garba_eul.eul5_qpp_stats stats
where qs_created_date between sysdate-30 and sysdate
)
union all
select 'Business Areas' "Objects", count(*) Total from garba_eul.EUL5_bas
union all
select 'Folders', count(*) from garba_eul.EUL5_objs
union all
select 'Items' , count(*) from garba_eul.EUL5_expressions
/