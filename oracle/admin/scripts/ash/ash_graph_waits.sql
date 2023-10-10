--ash_graph_waits.sql
/*
   "+" - represent CPU usage
   "-" - represent wait time
   "2" in the GRAPH is the number of CPUS on this machine
   GRAPH is a graphical representation of AVEACT (AAS)
TM                 NPTS  AVEACT GRAPH                   CPU WAITS
---------------- ------ ------- ---------------------- ---- -----
06-AUG  13:00:00    270     .33 +-        2              29    59
06-AUG  14:00:00   1040    2.24 ++--------2---          341  1984
06-AUG  15:00:00    623    6.67 ++++------2----------   438  3718
06-AUG  16:00:00   1088    2.59 ++--------2----         335  2486
06-AUG  17:00:00   1104    1.26 ++-----   2             349  1043
06-AUG  18:00:00   1093    1.38 +++----   2             663   842
06-AUG  19:00:00   1012    1.74 ++------- 2             373  1388
06-AUG  20:00:00   1131     .99 +----     2             304   820
06-AUG  21:00:00   1111    1.22 ++-----   2             344  1012
06-AUG  22:00:00   1010    1.66 ++------  2             414  1259
06-AUG  23:00:00   1120    1.08 +----     2             298   913
07-AUG  00:00:00   1024     .83 +---      2             273   576
07-AUG  01:00:00   1006    1.74 ++------- 2             319  1428
07-AUG  02:00:00   1090    2.47 ++--------2----         347  2345
07-AUG  03:00:00    687    6.59 +++-------2----------   382  4142
07-AUG  04:00:00   1004    1.95 ++++++--- 2            1299   659
07-AUG  05:00:00   1104    3.08 +++++-----2------      1170  2226
07-AUG  06:00:00   1122    1.91 +++++++-- 2            1582   558
07-AUG  07:00:00   1115    1.06 +++---    2             559   618
07-AUG  08:00:00   1140     .81 ++--      2             403   519
07-AUG  09:00:00   1128     .88 ++---     2             386   601

*/

Def v_days=1 -- amount of time
Def v_secs=60 -- size of bucket
Def v_bars=5 -- size of one AAS
Def v_graph=50 -- width of graph

col graph format a&v_graph
col aas format 999.99
col total format 99999
col npts format 99999
col waits for 9999
col cpu for 9999

set pages 1000
set lines 200

/*
      dba_hist_active_sess_history
*/

select
        to_char(to_date(tday||' '||tmod*&v_secs,'YYMMDD SSSSS'),'DD-MON  HH24:MI:SS') tm,
        samples npts,
        total/&v_secs aas,
        substr(
        substr(substr(rpad('+',round((cpu*&v_bars)/&v_secs),'+') ||
        rpad('-',round((waits*&v_bars)/&v_secs),'-')  ||
        rpad(' ',p.value * &v_bars,' '),0,(p.value * &v_bars)) ||
        p.value  ||
        substr(rpad('+',round((cpu*&v_bars)/&v_secs),'+') ||
        rpad('-',round((waits*&v_bars)/&v_secs),'-')  ||
        rpad(' ',p.value * &v_bars,' '),(p.value * &v_bars),10) ,0,30)
        ,0,&v_graph)
        graph,
        -- total,
        cpu,
        waits
from (
   select
       to_char(sample_time,'YYMMDD')                   tday
     , trunc(to_char(sample_time,'SSSSS')/&v_secs) tmod
     , sum(decode(session_state,'ON CPU',1,decode(session_type,'BACKGROUND',0,1)))  total
     , (max(sample_id) - min(sample_id) + 1 )      samples
     , sum(decode(session_state,'ON CPU' ,1,0))    cpu
     , sum(decode(session_state,'WAITING',1,0)) -
       sum(decode(session_type,'BACKGROUND',decode(session_state,'WAITING',1,0)))    waits
       /* for waits I want to subtract out the BACKGROUND
          but for CPU I want to count everyon */
   from
      v$active_session_history
   where sample_time > sysdate - &v_days
   group by  trunc(to_char(sample_time,'SSSSS')/&v_secs),
             to_char(sample_time,'YYMMDD')
union all
   select
       to_char(sample_time,'YYMMDD')                   tday
     , trunc(to_char(sample_time,'SSSSS')/&v_secs) tmod
     , sum(decode(session_state,'ON CPU',1,decode(session_type,'BACKGROUND',0,1)))  total
     , (max(sample_id) - min(sample_id) + 1 )      samples
     , sum(decode(session_state,'ON CPU' ,10,0))    cpu
     , sum(decode(session_state,'WAITING',10,0)) -
       sum(decode(session_type,'BACKGROUND',decode(session_state,'WAITING',10,0)))    waits
       /* for waits I want to subtract out the BACKGROUND
          but for CPU I want to count everyon */
   from
      dba_hist_active_sess_history
   where sample_time > sysdate - &v_days
   and sample_time < (select min(sample_time) from v$active_session_history)
   group by  trunc(to_char(sample_time,'SSSSS')/&v_secs),
             to_char(sample_time,'YYMMDD')
) ash,
  v$parameter p
where p.name='cpu_count'
order by to_date(tday||' '||tmod*&v_secs,'YYMMDD SSSSS')
/
