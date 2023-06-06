elect * from table
    (rdsadmin.rds_file_util.read_text_file(
		        p_directory => 'PRODUCT_DESCRIPTIONS',
			        p_filename  => 'test.txt'));

