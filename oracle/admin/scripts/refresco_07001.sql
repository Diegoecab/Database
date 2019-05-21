DECLARE
  CURSOR c_cursor IS SELECT c.scd_surrgt_pk, c.scd_ins_surrgt_fk, COUNT(a.cch_url) cant_work 
                       FROM discoverer5.ptm5_schedule c,          
                            discoverer5.ptm5_cache a
                      WHERE a.cch_ins_surrgt_fk (+) = c.scd_ins_surrgt_fk
                        AND c.scd_next_update < SYSDATE + 2 
                        AND TRUNC(scd_next_update) <= TRUNC(SYSDATE)
 				   GROUP BY c.scd_surrgt_pk, c.scd_ins_surrgt_fk;          
  v_minuto NUMBER := 1/24/60;
  v_number NUMBER;
  v_fecha DATE := SYSDATE; 
BEGIN  
  FOR c IN c_cursor LOOP
    v_number := v_minuto * c.cant_work / 4; 
    DBMS_OUTPUT.put_line(c.scd_surrgt_pk || ', ' || c.scd_ins_surrgt_fk || ', ' || TO_CHAR(v_fecha,'YYYY/MM/DD:HH24:MI:SS'));   
    
    UPDATE discoverer5.ptm5_schedule 
       SET scd_next_update = v_fecha
     WHERE scd_ins_surrgt_fk = c.scd_ins_surrgt_fk;  
     
    UPDATE discoverer5.ptm5_cache a  
       SET cch_next_update = v_fecha + 0.0002
     WHERE a.cch_ins_surrgt_fk = c.scd_ins_surrgt_fk;

    v_fecha := v_fecha + v_number;
  END LOOP;
  COMMIT;
END; 


