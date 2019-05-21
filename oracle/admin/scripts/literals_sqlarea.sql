
REM  Filename:  literals_sqlarea.sql
REM
REM  ORA 9i: select substr(sql_text,1,40) "SQL",          count(*) ,          sum(executions) "TotExecs"    from v$sqlarea   where executions < 5   group by substr(sql_text,1,40)  having count(*) > 30   order by 2  ;
REM

set pages 10000
set linesize 300
col force_matching_signature format 99999999999999999999999
col sql_text for a100

with c 
as
(select force_matching_signature,count(*) cnt
from v$sqlarea
where force_matching_signature!=0
group by force_matching_signature having count(*) > 20),
sq 
as
(select sql_id,sql_text ,force_matching_signature,row_number() over (partition BY force_matching_signature order by sql_id desc) p
from v$sqlarea s
where force_matching_signature in
(select force_matching_signature from c))
select sq.sql_text ,sq.sql_id,sq.force_matching_signature,c.cnt "unshared count"
from c,sq
where sq.force_matching_signature=c.force_matching_signature and sq.p =1
order by c.cnt desc
/