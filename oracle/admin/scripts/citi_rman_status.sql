set echo off
set pagesize 30
col sid for a10
col host for a10
col mb_s for 99999 heading "MB/S"
col elap for 9999
col status for a8

select host,
       sid,
       status,
       started,
       finished,
       round(nvl((nvl(a.finished,sysdate)-a.started)*1440,0)) elap,
       type,
       round(output/1024/1024,2) size_mb, 
       round(output/1024/1024 / ((nvl(a.finished,sysdate)-a.started)*1440*60),0) mb_s
  from dbadmin.rman_backup_status a
where trunc(started)>=trunc(sysdate)-nvl('&days',0)
order by started asc;