CREATE OR REPLACE TRIGGER trg_logon_dbo_ebalance_reg
   AFTER LOGON ON dbo_ebalance_regional.schema
BEGIN
/*
19-FEB-14: Por migracion desde SQL Server, todas las consultas seran case insensitive
*/
      EXECUTE IMMEDIATE ('alter session set NLS_SORT=BINARY_CI');
      EXECUTE IMMEDIATE ('alter session set NLS_COMP=LINGUISTIC');
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error al ejecutar trigger trg_logon_dbo_ebalance_reg'
                       );
END trg_logon_dbo_ebalance_reg;
/



CREATE OR REPLACE TRIGGER trg_logon_bsbc_dw
   AFTER LOGON ON bsbc_dw.schema
BEGIN
     EXECUTE IMMEDIATE ('alter session set  tracefile_identifier =''2015_bsbc_dw''');
	 EXECUTE IMMEDIATE ('alter session set events ''10046 trace name context forever, level 8''');
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error al ejecutar trigger trg_logon_bsbc_dw'
                       );
END trg_logon_bsbc_dw;
/