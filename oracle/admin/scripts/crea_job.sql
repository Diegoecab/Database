/* JOB Ejemplo...*/

SET SERVEROUTPUT ON
DECLARE
  X NUMBER;
  JobNumber VARCHAR2(100);
BEGIN
  SYS.DBMS_JOB.SUBMIT
    (
      job        => X
     ,what       => 'execute immediate ''alter system flush buffer_cache'';'
     ,next_date  => to_date('15/06/2010 23:50:00','dd/mm/yyyy hh24:mi:ss')
     ,interval   => 'SYSDATE+1'
     ,no_parse   => FALSE
    );
JobNumber := to_char(X);
sys.dbms_output.put_line('Job creado nro.: ' ||JobNumber);
END;
/
commit;