exec rdsadmin.rdsadmin_util.create_directory(p_directory_name=> 'product_descriptions');
select directory_path from dba_directories where directory_name='PRODUCT_DESCRIPTIONS';     

