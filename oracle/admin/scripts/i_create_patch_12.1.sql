set serveroutput on
DECLARE
  l_sql_text        CLOB        ;
  l_sql_id          VARCHAR2(30) :='dzj9muxh82338';--E.g. 4nqnfu8ctc7u4
  l_sql_patch_hints VARCHAR2(500):= 'PARALLEL(8)'; --E.g.driving_site (ADINTERNET) driving_site (KWESTRATO) LEADING(CP_107_108 SH_107) PARALLEL(4)
  l_sql_patch_name  VARCHAR2(30) :='diec_dzj9muxh82338_patch';
  l_sql_patch_desc  VARCHAR2(500):='';
  l_output          varchar2(100);
BEGIN
  IF (l_sql_text IS NULL) THEN
    SELECT sql_fulltext INTO l_sql_text FROM gv$sqlarea WHERE sql_id = l_sql_id AND ROWNUM < 2;
  END IF;
  DBMS_SQLDIAG_INTERNAL.i_create_patch(
      sql_text    => l_sql_text
    , hint_text   => l_sql_patch_hints
    , name        => l_sql_patch_name
    , description => l_sql_patch_desc
  );
END;
/

/*
BEGIN
  SYS.DBMS_SQLDIAG.drop_sql_patch(name => 'diec_3b58mux5mf6zm_patch');
END;
/
*/