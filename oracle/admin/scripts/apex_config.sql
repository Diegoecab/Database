SET SERVEROUTPUT ON
begin 
    apex_instance_admin.set_parameter(
        p_parameter => 'IMAGE_PREFIX',
        p_value     => 'https://static.oracle.com/cdn/apex/23.1.1/' );

    commit;
end;

begin 
    apex_instance_admin.get_parameter(
		p_parameters      
        p_NAME => 'IMAGE_PREFIX');
end;


	select * from apex_instance_parameters where name = 'IMAGE_PREFIX';

	NAME                           VALUE                                              CREATED_O LAST_UPDA
	------------------------------ -------------------------------------------------- --------- ---------
	IMAGE_PREFIX                   /i/                                                08-DEC-23 08-DEC-23

	SQL>


	SET SERVEROUTPUT ON
	begin 
		apex_instance_admin.set_parameter(
			p_parameter => 'IMAGE_PREFIX',
			p_value     => 'https://static.oracle.com/cdn/apex/23.1.1/' );

		commit;
	end;
	/
	
	
	SQL> select * from apex_instance_parameters where name = 'IMAGE_PREFIX';

	NAME                           VALUE                                              CREATED_O LAST_UPDA
	------------------------------ -------------------------------------------------- --------- ---------
	IMAGE_PREFIX                   https://static.oracle.com/cdn/apex/23.1.1/         08-DEC-23 12-DEC-23

	SQL>






select workspace from APEX_230100.apex_workspaces;
select user_name from APEX_230100.wwv_flow_fnd_user;




SET SERVEROUTPUT ON
begin 
    apex_instance_admin.set_parameter(
        p_parameter => 'IMAGE_PREFIX',
        p_value     => '/i/' );

    commit;
end;



