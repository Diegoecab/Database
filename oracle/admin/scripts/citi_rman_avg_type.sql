select host, sid,
       type,
       round((avg(output))/1024/1024/1024,2) size_g
  from dbadmin.rman_backup_status a
where host like 'lath14'
group by host, sid, type
order by 1,2,3;