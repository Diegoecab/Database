rem
rem     Script:    trend_awr_stat.sql
rem     Author:    Jonathan Lewis
rem     Dated:     Sep 2006
rem     Purpose:
rem
rem     Last tested
rem             10.2.0.3
rem     Not Tested
rem             11.2.0.1
rem             11.1.0.7
rem     Not relevant
rem              9.2.0.8
rem              8.1.7.4
rem
rem     Warning:
rem     Requires licence for Diagnostic Pack
rem
rem     Notes:
rem     Trend through AWR system stats
rem     Accesses data for current instance and DBID
rem
rem     Hard coded to go 30 days back in history
rem
rem     Reports a timestamp at the start of an interval
rem     with the activity that happened in that interval
rem
rem     Ignores database restarts
rem
rem     Generally okay to pick up the next snap_id because of
rem     the way that the AWR code generates snapshot ids
rem     (Not true for statspack unless you set the sequence
rem     to nocache).
rem
rem     Change the following define to pick a different statistic
rem

define m_stat_name = 'SQL*Net message to/from client'
define m_stat_name = 'CPU used by this session'

set timing off
set linesize 180
set pagesize 60
set trimspool on

column  instance_number  new_value m_instance  noprint
column  dbid             new_value m_dbid      noprint

select
        ins.instance_number,
        db.dbid
from
        v$instance        ins,
        v$database        db
;

column  value       format  99999999999999999
column  curr_value  format  99999999999999999
column  prev_value  format  99999999999999999

spool trend_awr_stat

with base_line as (
        select
                /*+ materialize */
                snp.snap_id,
				sst.stat_name,
                to_char(snp.end_interval_time,'Mon-dd hh24:mi:ss')     end_time,
                sst.value
        from
                dba_hist_snapshot       snp,
                dba_hist_sysstat        sst
        where
                snp.dbid            = &m_dbid
        and     snp.instance_number = &m_instance
        and     end_interval_time   between sysdate - 30 and sysdate
        /*                                                        */
        and     sst.dbid            = snp.dbid
        and     sst.instance_number = snp.instance_number
        and     sst.snap_id         = snp.snap_id
        --and     sst.stat_name       like ('%&m_stat_name%')
        /*                                                        */
)
select
        b1.end_time             start_of_delta,
        b1.value                prev_value,
		b1.stat_name,
        b2.value                curr_value,
        b2.value - b1.value     value
from
        base_line        b1,
        base_line        b2
where
        b2.snap_id = b1.snap_id + 1
order by
        b1.snap_id
;

spool off


/*
 with base_line as (
        select
                /*+ materialize */
                snp.snap_id,
				sst.stat_name,
                to_char(snp.end_interval_time,'Mon-dd')     end_time,
                sst.value
        from
                dba_hist_snapshot       snp,
                dba_hist_sysstat        sst
        where
                snp.dbid            = &m_dbid
        and     snp.instance_number = &m_instance
        and     end_interval_time   between sysdate - 90 and sysdate
        /*                                                        */
        and     sst.dbid            = snp.dbid
        and     sst.instance_number = snp.instance_number
        and     sst.snap_id         = snp.snap_id
        --and     sst.stat_name       like ('%&m_stat_name%')
and UPPER(stat_name) like upper('%NET%')
)
select
        b1.end_time             start_of_delta,
        sum(b1.value)                prev_value,
		b1.stat_name,
        sum(b2.value)                curr_value,
        sum(b2.value) - sum(b1.value)     value
from
        base_line        b1,
        base_line        b2
where
        b2.snap_id = b1.snap_id + 1
group by  b1.end_time,b1.stat_name
order by
1
/




select
to_char(snp.end_interval_time,'Mon-dd')     end_time,
				sst.stat_name,
                sum(sst.value) value
        from
                dba_hist_snapshot       snp,
                dba_hist_sysstat        sst
        where
                snp.dbid            = &m_dbid
        and     snp.instance_number = &m_instance
        and     end_interval_time   between sysdate - 90 and sysdate
        and     sst.dbid            = snp.dbid
        and     sst.instance_number = snp.instance_number
        and     sst.snap_id         = snp.snap_id
		and UPPER(stat_name) like upper('%NET%')
		and sst.value <> 0
group by  to_char(snp.end_interval_time,'Mon-dd'),stat_name
order by 1
*/