select host, sid,
          trunc(started) started, type,
          round(sum(output)/1024/1024/1024,2) size_g,
          round(max(output)/1024/1024/1024,2) max_g,
          round(min(output)/1024,2) min_k,
          round(avg(output)/1024/1024/1024,2) avg_g,
          count(1)  num_bkp
  from dbadmin.rman_backup_status a
where host like '%&host%' and
upper(sid) like upper('%&sid%')
group by host, sid, trunc(started), type
order by 1,2;