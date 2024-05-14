select * from table (rdsadmin.rds_file_util.listdir(p_directory => 'ARCHIVELOG_DIR')) order by filename;
