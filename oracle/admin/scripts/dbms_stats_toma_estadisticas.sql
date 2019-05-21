/*ejemplo de toma de estadisticas para indice*/
exec dbms_stats.gather_index_stats ( ownname=>'ahs_sop',indname=>'stk_grupo_stks_idx',estimate_percent=>100);
/*ejemplo de toma de estadisticas para tabla*/
exec dbms_stats.gather_table_stats ( ownname=>'ahs_sop',tabname=>'stk_grupo_stks_idx',estimate_percent=>100);
