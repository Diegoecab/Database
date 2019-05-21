How to insert table data into excel sheet
******************************************

Now open tab.xls with excel .... 

-----------------

As sys user:

CREATE OR REPLACE DIRECTORY TEST_DIR AS 'c:\myfiles'  /* directory on the Oracle database server */
/ 
GRANT READ, WRITE ON DIRECTORY TEST_DIR TO myuser
/ 



--As myuser:

DECLARE
  v_fh        UTL_FILE.FILE_TYPE;
  v_dir       VARCHAR2(30) := 'TEST_DIR';
  v_file      VARCHAR2(30) := 'myfile.xls';
  PROCEDURE run_query(p_sql IN VARCHAR2) IS
    v_v_val     VARCHAR2(4000);
    v_n_val     NUMBER;
    v_d_val     DATE;
    v_ret       NUMBER;
    c           NUMBER;
    d           NUMBER;
    col_cnt     INTEGER;
    f           BOOLEAN;
    rec_tab     DBMS_SQL.DESC_TAB;
    col_num     NUMBER;
  BEGIN
    c := DBMS_SQL.OPEN_CURSOR;
    -- parse the SQL statement
    DBMS_SQL.PARSE(c, p_sql, DBMS_SQL.NATIVE);
    -- start execution of the SQL statement
    d := DBMS_SQL.EXECUTE(c);
    -- get a description of the returned columns
    DBMS_SQL.DESCRIBE_COLUMNS(c, col_cnt, rec_tab);
    -- bind variables to columns
    FOR j in 1..col_cnt
    LOOP
      CASE rec_tab(j).col_type
        WHEN 1 THEN DBMS_SQL.DEFINE_COLUMN(c,j,v_v_val,4000);
        WHEN 2 THEN DBMS_SQL.DEFINE_COLUMN(c,j,v_n_val);
        WHEN 12 THEN DBMS_SQL.DEFINE_COLUMN(c,j,v_d_val);
      ELSE
        DBMS_SQL.DEFINE_COLUMN(c,j,v_v_val,4000);
      END CASE;
    END LOOP;
    -- Output the column headers
    UTL_FILE.PUT_LINE(v_fh,'<ss:Row>');
    FOR j in 1..col_cnt
    LOOP
      UTL_FILE.PUT_LINE(v_fh,'<ss:Cell>');
      UTL_FILE.PUT_LINE(v_fh,'<ss:Data ss:Type="String">'||rec_tab(j).col_name||'</ss:Data>');
      UTL_FILE.PUT_LINE(v_fh,'</ss:Cell>');
    END LOOP;
    UTL_FILE.PUT_LINE(v_fh,'</ss:Row>');
    -- Output the data
    LOOP
      v_ret := DBMS_SQL.FETCH_ROWS(c);
      EXIT WHEN v_ret = 0;
      UTL_FILE.PUT_LINE(v_fh,'<ss:Row>');
      FOR j in 1..col_cnt
      LOOP
        CASE rec_tab(j).col_type
          WHEN 1 THEN DBMS_SQL.COLUMN_VALUE(c,j,v_v_val);
                      UTL_FILE.PUT_LINE(v_fh,'<ss:Cell>');
                      UTL_FILE.PUT_LINE(v_fh,'<ss:Data ss:Type="String">'||v_v_val||'</ss:Data>');
                      UTL_FILE.PUT_LINE(v_fh,'</ss:Cell>');
          WHEN 2 THEN DBMS_SQL.COLUMN_VALUE(c,j,v_n_val);
                      UTL_FILE.PUT_LINE(v_fh,'<ss:Cell>');
                      UTL_FILE.PUT_LINE(v_fh,'<ss:Data ss:Type="Number">'||to_char(v_n_val)||'</ss:Data>');
                      UTL_FILE.PUT_LINE(v_fh,'</ss:Cell>');
          WHEN 12 THEN DBMS_SQL.COLUMN_VALUE(c,j,v_d_val);
                      UTL_FILE.PUT_LINE(v_fh,'<ss:Cell ss:StyleID="OracleDate">');
                      UTL_FILE.PUT_LINE(v_fh,'<ss:Data ss:Type="DateTime">'||to_char(v_d_val,'YYYY-MM-DD"T"HH24:MI:SS')||'</ss:Data>');
                      UTL_FILE.PUT_LINE(v_fh,'</ss:Cell>');
        ELSE
          DBMS_SQL.COLUMN_VALUE(c,j,v_v_val);
          UTL_FILE.PUT_LINE(v_fh,'<ss:Cell>');
          UTL_FILE.PUT_LINE(v_fh,'<ss:Data ss:Type="String">'||v_v_val||'</ss:Data>');
          UTL_FILE.PUT_LINE(v_fh,'</ss:Cell>');
        END CASE;
      END LOOP;
      UTL_FILE.PUT_LINE(v_fh,'</ss:Row>');
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(c);
  END;
  --
  PROCEDURE start_workbook IS
  BEGIN
    UTL_FILE.PUT_LINE(v_fh,'<?xml version="1.0"?>');
    UTL_FILE.PUT_LINE(v_fh,'<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">');
  END;
  PROCEDURE end_workbook IS
  BEGIN
    UTL_FILE.PUT_LINE(v_fh,'</ss:Workbook>');
  END;
  --
  PROCEDURE start_worksheet(p_sheetname IN VARCHAR2) IS
  BEGIN
    UTL_FILE.PUT_LINE(v_fh,'<ss:Worksheet ss:Name="'||p_sheetname||'">');
    UTL_FILE.PUT_LINE(v_fh,'<ss:Table>');
  END;
  PROCEDURE end_worksheet IS
  BEGIN
    UTL_FILE.PUT_LINE(v_fh,'</ss:Table>');
    UTL_FILE.PUT_LINE(v_fh,'</ss:Worksheet>');
  END;
  --
  PROCEDURE set_date_style IS
  BEGIN
    UTL_FILE.PUT_LINE(v_fh,'<ss:Styles>');
    UTL_FILE.PUT_LINE(v_fh,'<ss:Style ss:ID="OracleDate">');
    UTL_FILE.PUT_LINE(v_fh,'<ss:NumberFormat ss:Format="dd/mm/yyyy\ hh:mm:ss"/>');
    UTL_FILE.PUT_LINE(v_fh,'</ss:Style>');
    UTL_FILE.PUT_LINE(v_fh,'</ss:Styles>');
  END;
BEGIN
  v_fh := UTL_FILE.FOPEN(upper(v_dir),v_file,'w',32767);
  start_workbook;
  set_date_style;
  start_worksheet('EMP');
  run_query('select * from emp');
  end_worksheet;
  start_worksheet('DEPT');
  run_query('select * from dept');
  end_worksheet;
  end_workbook;
  UTL_FILE.FCLOSE(v_fh);
END;
