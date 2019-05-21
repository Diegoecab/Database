declare
     l_plans_loaded pls_integer;
begin
     l_plans_loaded := dbms_spm.load_plans_from_sqlset(sqlset_name => 'CRCO_DW_3107_DC'); 
end;
/



declare
     l_plans_loaded pls_integer;
begin
     l_plans_loaded := dbms_spm.load_plans_from_cursor_cache(
         sql_id => '52q1ac00nfksc'); 
end;