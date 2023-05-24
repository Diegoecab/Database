set serveroutput on
DECLARE
  v_char_err SMSCHANNEL.TBL_OUTBOX.identification%type;
  v_to_num NUMBER;
BEGIN
  FOR i IN
  (SELECT identification FROM SMSCHANNEL.TBL_OUTBOX
  )
  LOOP
    v_char_err:=i.identification;
    v_to_num  :=i.identification;    
  END LOOP;
EXCEPTION
WHEN OTHERS THEN
  dbms_output.put_line (v_char_err);                                          
  dbms_output.put_line (SUBSTR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE(),1,4000)); 
END;
/