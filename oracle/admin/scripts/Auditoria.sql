Auditoria de Base de Datos Oracle


      dba_audit_exists
      dba_audit_object
      dba_audit_session
      dba_audit_statement
      dba_audit_trail 

	  
Metadata views for Oracle auditing options:
    
      dba_obj_audit_opts
      dba_priv_audit_opts
      dba_stmt_audit_opts 


***********************************************************************
Parametro audit_trail.

DB=Activación de auditoria de Base de Datos

Ej. SQL> alter system set audit_trail = DB scope = spfile;

SQL> select name , value from v$parameter where name like 'audit_trail';

***********************************************************************

Auditoria de conexión y desconexión de los usuarios a la Base:

SQL> audit connect;

***********************************************************************

Auditoria sobre modificación de tablas

Ej.
SQL>audit insert,update on scott . bonus by access;

Para ver las tablas auditadas y el tipo de auditoria:

SQL>select * from user_obj_audit_opts;

((A/A) –> activado / por acceso)

Para ver si algún usuario que no sea el dueño de la tabla está realizando modificaciones en la tabla:

SQL>select * from sys.dba_audit_trail where ( action_name = 'INSERT' ) or ( action_name = 'UPDATE' ) ;

***********************************************************************
dba_audit_trail 
Vista con datos de auditoria

***********************************************************************

Vista de auditoria de conexión:

SQL> select username , action_name , priv_used , returncode from dba_audit_trail ;

***********************************************************************

user_obj_audit_opts 




------------




Audit all Oracle user activity.  :
audit all by FRED by access;

Audit all Oracle user viewing activity:
audit select table by FRED by access;

Audit all Oracle user data change activity:
audit update table, delete table,
      insert table by FRED by access;
	  
Audit all Oracle user viewing activity:

audit execute procedure by FRED by access;




