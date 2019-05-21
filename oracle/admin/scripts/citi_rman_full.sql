set lines 400
set pages 1000
select host, sid,
          started,
          finished,
          round((FINISHED-started)*1440/60) h_taken,
          round((output)/1024/1024/1024,2) size_g
  from dbadmin.rman_backup_status a
where --host like 'lath14'
sid='dbrepo'
--  and sid='cdwpro'
  and type='FULL'
order by 1,2,3;