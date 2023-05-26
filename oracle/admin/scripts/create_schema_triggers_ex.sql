CREATE TABLE AUDIT_DDL (
  d date,
  OSUSER varchar2(255),
  CURRENT_USER varchar2(255),
  HOST varchar2(255),
  TERMINAL varchar2(255),
  owner varchar2(30),
  type varchar2(30),
  name varchar2(30),
  sysevent varchar2(30));

CREATE OR REPLACE TRIGGER before_createindex
 BEFORE DDL ON DATABASE
  BEGIN
   if (ora_sysevent = 'CREATE' and ora_dict_obj_type='INDEX' and owner !=  ) then
	   insert into audit_ddl(d, osuser,current_user,host,terminal,owner,type,name,sysevent)
    values(
      sysdate,
      sys_context('USERENV','OS_USER') ,
      ora_dict_obj_owner_list,
      sys_context('USERENV','HOST') ,
      sys_context('USERENV','TERMINAL') ,
      ora_dict_obj_owner,
      ora_dict_obj_type,
      ora_dict_obj_name,
      ora_sysevent
    );
   end if;
END;
/



CREATE OR REPLACE TRIGGER before_createindex_myschema
 BEFORE DDL ON A310275.schema
  BEGIN
  insert into audit_ddl(d, osuser,current_user,host,terminal,owner,type,name,sysevent)
    values(
      sysdate,
      sys_context('USERENV','OS_USER') ,
      ora_dict_obj_owner,
      sys_context('USERENV','HOST') ,
      sys_context('USERENV','TERMINAL') ,
      ora_dict_obj_owner,
      ora_dict_obj_type,
      ora_dict_obj_name,
      ora_sysevent
    );
   if (ora_sysevent = 'CREATE' and ora_dict_obj_type='INDEX' and ora_dict_obj_owner != 'A310275') then
	RAISE_APPLICATION_ERROR(-20000, 'Index creation not allowed, please contact the database administrator');
   end if;
END;
/



CREATE OR REPLACE TRIGGER before_createindex_myschema
 BEFORE DDL ON A310275.schema
  DECLARE
   is_my_table number := 0;
  BEGIN
  insert into audit_ddl(d, osuser,current_user,host,terminal,owner,type,name,sysevent)
    values(
      sysdate,
      sys_context('USERENV','OS_USER') ,
      ora_dict_obj_owner,
      sys_context('USERENV','HOST') ,
      sys_context('USERENV','TERMINAL') ,
      ora_dict_obj_owner,
      ora_dict_obj_type,
      ora_dict_obj_name,
      ora_sysevent
    );
   if (ora_sysevent = 'CREATE' and ora_dict_obj_type='INDEX') then
    select count(*) into is_my_table from dba_tables where table_name = ora_dict_obj_name and owner in ('ALLOWED_OWNERS');
	if (is_my_table = 0) then
	 RAISE_APPLICATION_ERROR(-20000, 'Index creation not allowed, please contact the database administrator');
	end if;
   end if;
END;
/


CREATE OR REPLACE TRIGGER before_createindex_myschema
 BEFORE DDL ON MYSCHEMA.schema
  DECLARE
   is_my_table number := 0;
  BEGIN
   if (ora_sysevent = 'CREATE' and ora_dict_obj_type='INDEX') then
    select count(*) into is_my_table from dba_tables where table_name = ora_dict_obj_name and owner in ('NOT_ALLOWED_OWNERS');
	if (is_my_table = 0) then
	 RAISE_APPLICATION_ERROR(-20000, 'Index creation not allowed, please contact the database administrator');
	end if;
   end if;
END;
/


CREATE OR REPLACE TRIGGER before_createindex_myschema
 AFTER DDL ON A310275.schema
  DECLARE
   is_my_table number := 0;
  BEGIN
  insert into audit_ddl(d, osuser,current_user,host,terminal,owner,type,name,sysevent)
    values(
      sysdate,
      sys_context('USERENV','OS_USER') ,
      ora_dict_obj_owner,
      sys_context('USERENV','HOST') ,
      sys_context('USERENV','TERMINAL') ,
      ora_dict_obj_owner,
      ora_dict_obj_type,
      ora_dict_obj_name,
      ora_sysevent
    );
   if (ora_sysevent = 'CREATE' and ora_dict_obj_type='INDEX') then
    select count(*) into is_my_table from dba_tables where table_name = ora_dict_obj_name and owner in ('ALLOWED_OWNERS');
	if (is_my_table = 0) then
	 RAISE_APPLICATION_ERROR(-20000, 'Index creation not allowed, please contact the database administrator');
	end if;
   end if;
END;
/




CREATE OR REPLACE TRIGGER before_createindex
 BEFORE DDL ON DATABASE
  BEGIN
   if (ora_sysevent = 'CREATE' and ora_dict_obj_type='INDEX' and ) then
	RAISE_APPLICATION_ERROR(-20000, 'Index creation not allowed, please contact the database administrator');
   end if;
END;
/