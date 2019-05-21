-- install with sys
-- create types
CREATE OR REPLACE TYPE v2_row AS OBJECT ( text varchar2(1024));
/
CREATE OR REPLACE TYPE v2_table AS TABLE OF v2_row;
/

-- create function
CREATE OR REPLACE FUNCTION list_files
( p_directory VARCHAR2
, p_recursive PLS_INTEGER := 0)
RETURN v2_table
IS
ns VARCHAR2(1024);
v_dir VARCHAR2(1024);
v_list v2_table := v2_table();
v_slash VARCHAR2(1) := '/' ;
v_dir_depth PLS_INTEGER;
BEGIN
IF instr(v_dir,'\') > 0 THEN
v_slash := '\';
END IF;
v_dir := p_directory||v_slash;
v_dir_depth := (LENGTH(v_dir) - LENGTH(REPLACE(v_dir,v_slash,'')))/LENGTH(v_slash);
DBMS_BACKUP_RESTORE.SEARCHFILES(v_dir, ns);
FOR i IN ( SELECT fname_krbmsft as name
, (LENGTH(fname_krbmsft) - LENGTH(REPLACE(fname_krbmsft,v_slash,'')))/LENGTH(v_slash) as dir_depth
FROM x$krbmsft
WHERE INSTR(fname_krbmsft,v_dir) > 0 )
LOOP
IF p_recursive = 0 THEN
IF v_dir_depth = i.dir_depth THEN
v_list.extend;
v_list(v_list.count) := v2_row(i.name);
END IF;
ELSIF p_recursive = 1 THEN
v_list.extend;
v_list(v_list.count) := v2_row(i.name);
END IF;
END LOOP;

RETURN v_list;
END list_files;
/
-- grants and private synonyms
GRANT EXECUTE ON V2_ROW TO SYSTEM;
GRANT EXECUTE ON V2_TABLE TO SYSTEM;
GRANT EXECUTE ON LIST_FILES TO SYSTEM;
CREATE SYNONYM SYSTEM.V2_ROW FOR V2_ROW;
CREATE SYNONYM SYSTEM.V2_TABLE FOR V2_TABLE;
CREATE SYNONYM SYSTEM.LS FOR LIST_FILES;