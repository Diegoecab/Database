--awr_stats_hist.sql
set trimspool on
set pages 50000
set lines 132
set tab off
set feedback off

clear break compute;
repfooter off;
ttitle off;
btitle off;
set timing off veri off space 1 flush on pause off termout on numwidth 10;
set echo off feedback off pagesize 50000 linesize 1000 newpage 1 recsep off;
set trimspool on trimout on;

-- 
-- Request the DB Id and Instance Number, if they are not specified

column instt_num  heading "Inst Num"  format 99999;
column instt_name heading "Instance"  format a12;
column dbb_name   heading "DB Name"   format a12;
column dbbid      heading "DB Id"     format a12 just c;
column host       heading "Host"      format a20;

prompt
prompt
prompt instances IN this workload repository SCHEMA
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT DISTINCT ( CASE
                    WHEN cd.dbid = wr.dbid
                         AND cd.name = wr.db_name
                         AND ci.instance_number = wr.instance_number
                         AND ci.instance_name = wr.instance_name THEN '* '
                    ELSE '  '
                  END )
                || wr.dbid         dbbid,
                wr.instance_number instt_num,
                wr.db_name         dbb_name,
                wr.instance_name   inst_name,
                wr.host_name       host
FROM   dba_hist_database_instance wr,
       v$database cd,
       v$instance ci;

prompt
prompt USING &&dbid FOR DATABASE id
-- 
--  Set up the binds for dbid and instance_number
variable dbid NUMBER;
BEGIN
    :dbid := &dbid;
END;
/
--  Error reporting
whenever SQLERROR EXIT;
variable max_snap_time CHAR(10);
DECLARE
    CURSOR cidnum IS
      SELECT 'X'
      FROM   dba_hist_database_instance
      WHERE  dbid = :dbid;
    CURSOR csnapid IS
      SELECT To_char(Max(end_interval_time), 'dd/mm/yyyy')
      FROM   dba_hist_snapshot
      WHERE  dbid = :dbid;
    vx CHAR(1);
BEGIN
    -- Check Database Id/Instance Number is a valid pair
    OPEN cidnum;

    FETCH cidnum INTO vx;

    IF cidnum%NOTFOUND THEN
      Raise_application_error(-20200, 'Database/Instance '
                                      || :dbid
                                      || '/'
                                      ||
      ' does not exist in DBA_HIST_DATABASE_INSTANCE');
    END IF;

    CLOSE cidnum;

    -- Check Snapshots exist for Database Id/Instance Number
    OPEN csnapid;

    FETCH csnapid INTO :max_snap_time;

    IF csnapid%NOTFOUND THEN
      Raise_application_error(-20200,
      'No snapshots exist for Database/Instance '
      ||:dbid
      ||'/');
    END IF;

    CLOSE csnapid;
END;
/

whenever SQLERROR CONTINUE;
-- 
--  Ask how many days of snapshots to display
set termout ON;
column instart_fmt noprint;
column inst_name format a12 heading 'Instance';
column db_name format a12 heading 'DB Name';
column snap_id format 99999990 heading 'Snap Id';
column snapdat format a18 heading 'Snap Started' just c;
column lvl format 99 heading 'Snap|Level';
prompt
prompt
prompt specify the NUMBER OF days OF snapshots TO choose FROM
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
prompt entering the NUMBER OF days (n) will result IN the most recent
prompt (n) days OF snapshots being listed. pressing  without
prompt specifying a NUMBER LISTS ALL completed snapshots.
prompt
prompt
set heading OFF;
column num_days new_value num_days noprint;
SELECT 'Listing '
       || Decode(Nvl('&&num_days', 3.14), 0, 'no snapshots',
                                          3.14, 'all Completed Snapshots',
                                          1,
          'the last day''s Completed Snapshots',
          'the last &num_days days of Completed Snapshots'
          ),
       Nvl('&&num_days', 3.14) num_days
FROM   sys.dual;

set heading ON;
-- 
-- List available snapshots
break ON inst_name ON db_name ON host ON instart_fmt skip 1;
ttitle OFF;
SELECT To_char(s.startup_time, 'dd Mon "at" HH24:mi:ss')   instart_fmt,
       di.instance_name                                    inst_name,
       di.db_name                                          db_name,
       s.snap_id                                           snap_id,
       To_char(s.end_interval_time, 'dd Mon YYYY HH24:mi') snapdat,
       s.snap_level                                        lvl
FROM   dba_hist_snapshot s,
       dba_hist_database_instance di
WHERE  s.dbid = :dbid
       AND di.dbid = :dbid
       AND di.dbid = s.dbid
       AND di.instance_number = s.instance_number
       AND di.startup_time = s.startup_time
       AND s.end_interval_time >= Decode(&num_days, 0, To_date('31-JAN-9999',
                                                       'DD-MON-YYYY'
                                                       ),
                                                    3.14, s.end_interval_time,
                                                    To_date(:max_snap_time,
                                                    'dd/mm/yyyy')
                                                    - ( &num_days - 1 ))
ORDER  BY db_name,
          instance_name,
          snap_id;

clear break;
ttitle OFF;
-- 
--  Ask for the snapshots Id's which are to be compared
prompt
prompt
prompt specify the BEGIN AND END SNAPSHOT ids
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
prompt BEGIN SNAPSHOT id specified: &&begin_snap
prompt
prompt END SNAPSHOT id specified: &&end_snap
prompt
-- 
--  Set up the snapshot-related binds
-- 
variable bid NUMBER;
variable eid NUMBER;
BEGIN
    :bid := &begin_snap;

    :eid := &end_snap;
END;
/

prompt
-- 
--  Ask for Statistics Name Filter
-- 
prompt
prompt
prompt search statistic
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
prompt search BY STATISTICS name. pressing  without
prompt specifying anything show ALL STATISTICS.
set heading OFF;
column stat_search new_value stat_search noprint;
SELECT 'Statistic Name Filter: '
       || Nvl('&&stat_search', '%'),
       Nvl('&&stat_search', '%') stat_search
FROM   sys.dual;

set heading ON;
column stat_id heading "Statistic ID" format 9999999999999;
column name heading "Statistic Name" format a64;
column class_name heading "Statistic Class" format a10;
SELECT stat_id,
       ( CASE
           WHEN class = 1 THEN 'USER'
           WHEN class = 2 THEN 'REDO'
           WHEN class = 4 THEN 'ENQUEUE'
           WHEN class = 8 THEN 'CACHE'
           WHEN class = 16 THEN 'OS'
           WHEN class = 32 THEN 'RAC'
           WHEN class = 40 THEN 'RAC-CACHE'
           WHEN class = 64 THEN 'SQL'
           WHEN class = 72 THEN 'SQL-CACHE'
           WHEN class = 128 THEN 'DEBUG'
           ELSE To_char(class)
         END ) CLASS_NAME,
       name
FROM   v$sysstat
WHERE  Upper(name) LIKE Trim(Upper('%&stat_search%'))
ORDER  BY class,
          name
/

-- 
--  Ask for the statistics
variable stat_filter_id NUMBER
variable stat_filter_name VARCHAR2(64)
prompt
prompt
prompt specify the STATISTICS
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
prompt enter STATISTICS id OR STATISTICS name.
prompt
BEGIN
    SELECT To_number('&&stat_input')
    INTO   :stat_filter_id
    FROM   dual;
EXCEPTION
    WHEN invalid_number THEN
      :stat_filter_name := '&stat_input';
END;
/

prompt STATISTICS specified : &&stat_input
column end_interval_time heading 'Snap Started' format a18 just c;
column dbid heading 'DB Id' format a12 just c;
column instance_number heading 'Inst|Num' format 99999;
column elapsed heading 'Elapsed' format 999999;
column stat_value heading 'Stat Value' format 999999999999
column stat_name heading 'Stat Name' format a64 just l;
SELECT snap_id,
       To_char(dbid)                                     DBID,
       instance_number,
       elapsed,
       To_char(end_interval_time, 'dd Mon YYYY HH24:mi') END_INTERVAL_TIME,
       --stat_name,
       ( CASE
           WHEN stat_value > 0 THEN stat_value
           ELSE 0
         END )                                           STAT_VALUE
FROM   (SELECT snap_id,
               dbid,
               instance_number,
               elapsed,
               end_interval_time,
               stat_name,
               ( stat_value - Lag (stat_value, 1, stat_value)
                                over (
                                  PARTITION BY dbid, instance_number
                                  ORDER BY snap_id) ) AS STAT_VALUE
        FROM   (SELECT snap_id,
                       dbid,
                       instance_number,
                       elapsed,
                       end_interval_time,
                       stat_name,
                       SUM(stat_value) AS STAT_VALUE
                FROM   (SELECT X.snap_id,
                               X.dbid,
                               X.instance_number,
                               Trunc(SN.end_interval_time, 'mi')
                               END_INTERVAL_TIME,
                               X.stat_name,
                               Trunc(( Cast(SN.end_interval_time AS DATE) -
                                       Cast(SN.begin_interval_time AS DATE) ) *
                                     86400)                      ELAPSED,
                               ( CASE
                                   WHEN ( X.stat_name = :stat_filter_name
                                           OR X.stat_id = :stat_filter_id ) THEN
                                   X.value
                                   ELSE 0
                                 END )                           AS STAT_VALUE
                        FROM   dba_hist_sysstat X,
                               dba_hist_snapshot SN,
                               (SELECT instance_number,
                                       Min(startup_time) STARTUP_TIME
                                FROM   dba_hist_snapshot
                                WHERE  snap_id BETWEEN :bid AND :eid
                                GROUP  BY instance_number) MS
                        WHERE  X.snap_id = sn.snap_id
                               AND X.dbid = sn.dbid
                               AND x.dbid = :dbid
                               AND x.snap_id BETWEEN :bid AND :eid
                               AND SN.startup_time = MS.startup_time
                               AND SN.instance_number = MS.instance_number
                               AND X.instance_number = sn.instance_number
                               AND ( X.stat_name = :stat_filter_name
                                      OR X.stat_id = :stat_filter_id ))
                GROUP  BY snap_id,
                          dbid,
                          instance_number,
                          elapsed,
                          end_interval_time,
                          stat_name));


undefine dbid
undefine num_days
undefine begin_snap
undefine end_snap
undefine stat_id
undefine stat_search
undefine stat_filter_name
undefine stat_filter_id
undefine stat_input