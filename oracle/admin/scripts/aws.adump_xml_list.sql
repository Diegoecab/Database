select count(*) num_files, round(sum(filesize)/1024/1024) mb, round(sysdate - min(mtime),4) days from table(rdsadmin.rds_file_util.listdir('ADUMP')) where type = 'file' and filename like '%.xml';
