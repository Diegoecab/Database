#!/bin/bash
####################################################################################################################
#
#  Oracle Instances Memory Usage on Linux server
#
# (C) 2021 Diego Cabrera
#
####################################################################################################################

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# exec_Sql
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
exec_Sql()
{
export sql=$1
export OUT=$(echo -e "
set head off
set feed off
${sql}
exit;"| sqlplus -s / as sysdba | sed 's/\t//g;s/ //g')

echo $OUT
}


hostname

grep Huge /proc/meminfo
free -h


MAXMEM_USED=0;
MAXSGA_USED=0;
MAXPGA_USED=0;

printf "Instance\tSGA_MAX_USED\tPGA_MAX_USED\tTotal Mem USED\n"
echo -e "---\t\t---\t\t---\t\t---"

for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo -e "\n database is $db"
export ORAENV_ASK=NO
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null

MAXMEM_USEDP=$(exec_Sql "select max(tot) from (
select sn.con_id,sn.INSTANCE_NUMBER, round(sga.mem_sga) sga, round(pga.mem_pga) pga,round(sga.mem_sga+pga.mem_pga) tot,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI:SS') end_interval_time
  from
(select con_id, snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_sga
   from DBA_HIST_SGASTAT
  group by con_id,snap_id,INSTANCE_NUMBER) sga
,(select con_id, snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024,2) mem_pga
    from DBA_HIST_PGASTAT where name = 'total PGA allocated'
   group by con_id,snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn
where sn.snap_id=sga.snap_id
  and sn.INSTANCE_NUMBER=sga.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
and
sn.begin_interval_time > sysdate-90
order by begin_interval_time
) group by con_id,INSTANCE_NUMBER;")


MAXPGA_USEDP=$(exec_Sql "
select max(pga) from (
select sn.con_id,sn.INSTANCE_NUMBER, round(sga.mem_sga) sga, round(pga.mem_pga) pga,round(sga.mem_sga+pga.mem_pga) tot,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI:SS') end_interval_time
  from
(select con_id, snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_sga
   from DBA_HIST_SGASTAT
  group by con_id,snap_id,INSTANCE_NUMBER) sga
,(select con_id, snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024,2) mem_pga
    from DBA_HIST_PGASTAT where name = 'total PGA allocated'
   group by con_id,snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn
where sn.snap_id=sga.snap_id
  and sn.INSTANCE_NUMBER=sga.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
and
sn.begin_interval_time > sysdate-90
order by begin_interval_time
) group by con_id,INSTANCE_NUMBER;
")

MAXSGA_USEDP=$(exec_Sql "
select max(sga) from (
select sn.con_id,sn.INSTANCE_NUMBER, round(sga.mem_sga) sga, round(pga.mem_pga) pga,round(sga.mem_sga+pga.mem_pga) tot,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI:SS') end_interval_time
  from
(select con_id, snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_sga
   from DBA_HIST_SGASTAT
  group by con_id,snap_id,INSTANCE_NUMBER) sga
,(select con_id, snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024,2) mem_pga
    from DBA_HIST_PGASTAT where name = 'total PGA allocated'
   group by con_id,snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn
where sn.snap_id=sga.snap_id
  and sn.INSTANCE_NUMBER=sga.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
and
sn.begin_interval_time > sysdate-90
order by begin_interval_time
) group by con_id,INSTANCE_NUMBER;
")



MAXMEM_USEDP="${MAXMEM_USEDP// /}"
MAXMEM_USED=$(($MAXMEM_USED + $MAXMEM_USEDP))

MAXPGA_USEDP="${MAXPGA_USEDP// /}"
MAXPGA_USED=$(($MAXPGA_USED + $MAXPGA_USEDP))
MAXSGA_USEDP="${MAXSGA_USEDP// /}"
MAXSGA_USED=$(($MAXSGA_USED + $MAXSGA_USEDP))

sqlplus -s / as sysdba <<!

col Mbytes for 9999999999
col value for a20 truncate
set lines 400
select name as Parameter, value from v\$parameter
where name in ('use_large_pages')
order by name;

select con_id, name as Parameter, value/1024/1024 as Mbytes from v\$parameter
where name in ('memory_target','memory_max_target','sga_max_size','sga_target','pga_aggregate_target','pga_aggregate_limit')
order by name;



!


printf "$db\t\t$((${MAXSGA_USEDP}))\t\t$((${MAXPGA_USEDP}))\t\t$((${MAXMEM_USEDP}))\n"

done

echo -e "---\t\t---\t\t---\t\t---"
printf "Total:\t\t${MAXSGA_USED}\t\t${MAXPGA_USED}\t\t${MAXMEM_USED}\n"
