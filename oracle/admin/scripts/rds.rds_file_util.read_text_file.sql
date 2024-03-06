
SELECT * FROM TABLE
    (rdsadmin.rds_file_util.read_text_file(
        p_directory => 'DATA_PUMP_DIR',
        p_filename  => 'prebkp_expdp_supplier_hub.log'));
		


SELECT * FROM TABLE(rdsadmin.rds_file_util.listdir(p_directory => 'DATA_PUMP_DIR'));


