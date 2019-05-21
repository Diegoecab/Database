select a.sql_text "Sql_Actual", b.username "Usuario_Oracle",b.osuser "Usuario_Sistema_Operativo" from V$sqltext a, v$session b
where a.address = b.sql_address AND B.USERNAME='GEM_ADM';