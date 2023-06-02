select * from table (rdsadmin.rds_file_util.listdir(p_directory => 'PRODUCT_DESCRIPTIONS'));

