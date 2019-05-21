CREATE OR REPLACE VIEW lista_constraints_si as
select a.owner,a.table_name ,a.constraint_name,b.column_name,b.position Posicion_Columna from all_constraints a 
join all_cons_columns b on a.constraint_name=b.constraint_name 
where constraint_type='R'
and a.owner NOT IN ('SYS','SYSTEM','TOAD','D4OSYS','DB_BACKUP','DBSNMP')
AND NOT EXISTS (SELECT '1'
                FROM all_ind_columns aid
                WHERE aid.table_name=b.table_name
                AND aid.column_name=b.column_name)
 order by a.table_name,a.constraint_name,b.position