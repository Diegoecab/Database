SET SERVEROUTPUT ON
accept 1 prompt 'Enter Tablespace: '
accept 2 prompt 'Enter AVG Row Len: '
accept 3 prompt 'Enter Num Rows: '
accept 4 prompt 'Enter PCTFREE: '
DECLARE
used_bytes NUMBER;
alloc_bytes NUMBER;
BEGIN
 SYS.DBMS_SPACE.create_table_cost ( upper('&1'),&2,&3,&4,used_bytes,alloc_bytes);
  DBMS_OUTPUT.PUT_LINE('used_bytes: '||used_bytes);
  DBMS_OUTPUT.PUT_LINE('alloc_bytes: '||alloc_bytes);
END;
/