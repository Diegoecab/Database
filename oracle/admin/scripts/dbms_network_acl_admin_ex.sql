col PRINCIPAL for a30 truncate
col ACL for a30 truncate
col ACL_OWNER for a30 truncate
col PRIVILEGE for a20 truncate
set lines 600
col HOST for a30 truncate
BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (acl       => '/sys/acls/open_acl_file.xml',
                         description => '/sys/acls/open_acl_file.xml',
                                           principal => 'SYS',
                                           is_grant  => true,
                                           privilege => 'connect');
END;
/

BEGIN
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => '/sys/acls/open_acl_file.xml',
                                       principal => 'ENGINEERING',
                                       is_grant  => true,
                                       privilege => 'resolve');
END;
/

BEGIN									   
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => '/sys/acls/open_acl_file.xml',
                                       principal => 'GTMS',
                                       is_grant  => true,
                                       privilege => 'resolve');
END;
/

BEGIN
DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => '/sys/acls/open_acl_file.xml',
                                    host => '*');
END;
/


select * from dba_network_acls;

SQL> select ACL_OWNER,ACL ,HOST from dba_network_acls  WHERE HOST = '*';

SQL> select PRINCIPAL,ACL, PRIVILEGE, ACL_OWNER from dba_network_acl_privileges;



DECLARE
  l_principal VARCHAR2(20) := 'APEX_210100';
BEGIN
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host       => 'api-dumbo-fdb-dev-fdbdumbo.apps.ocp.ar.bsch',
    lower_port => null,
    upper_port => null,
    ace        => xs$ace_type(privilege_list => xs$name_list('connect', 'resolve'),
                              principal_name => l_principal,
                              principal_type => xs_acl.ptype_db)); 
END;
/