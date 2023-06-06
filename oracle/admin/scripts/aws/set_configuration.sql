begin
	   rdsadmin.rdsadmin_util.set_configuration(
		   name=> 'archivelog retention hours',
		   value=> '48');
end;
/
     
exec rdsadmin.rdsadmin_util.show_configuration ;

