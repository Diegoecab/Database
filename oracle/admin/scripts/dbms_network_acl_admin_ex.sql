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