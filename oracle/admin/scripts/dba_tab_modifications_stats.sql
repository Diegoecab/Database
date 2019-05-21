--dba_tab_modifications_stats.sql

prompt
prompt Statistics
prompt
prompt
prompt 
prompt diff_days	-	diferencia de dias entre la ultima vez que se ejecuto y las ultimas modificaciones - eg 3
prompt owner		-	schema owner - eg dbauser
prompt pctmod		-	porcentaje de modificaciones respecto al ultimo calculo de estadisticas - eg 10
prompt num_rows	-	eg 1000
--prompt size_mb		- eg 100
prompt 


SET lines 800
SET pages 10000
set verify off
col table_name for a30
col pct_modif for 99999
col owner for a15
col seg heading 'SIZE_MB' for 9999
col diff_days for 999
col stmt for a300

accept owner prompt 'Enter value for owner: '
accept num_rows prompt 'Enter value for num_rows: '
accept pctmod prompt 'Enter value for pctmod: '
accept diff_days prompt 'Enter value for diff_days: '
accept size_mb prompt 'Enter value for size_mb: '
 
select table_owner,table_name,a.partition_name,num_rows,round(bytes/1024/1024) seg, reg_modif, pct_modif, last_analyzed,last_modif, diff_days, truncated, stmt
from (
 select   table_owner, table_name, partition_name,num_rows, aux reg_modif,
         round ((aux * 100)/ num_rows) pct_modif,
         last_analyzed, last_modif, round (last_modif - last_analyzed) diff_days, truncated,
		 'exec dbms_stats.gather_table_stats('''||table_owner||''', '''||table_name||''', partname=> '''||partition_name||''',estimate_percent => dbms_stats.auto_sample_size, cascade=>true, method_opt=>''FOR ALL COLUMNS SIZE AUTO'');' stmt
    from (select a1.table_owner, a1.table_name, a1.num_rows, a1.last_analyzed,a1.partition_name,
                 (select sum(updates + deletes + inserts)
                    from sys.dba_tab_modifications a2
					where a2.table_name = a1.table_name
                     and a2.table_owner = a1.table_owner
					 and a2.partition_name = a1.partition_name) aux,
                 (select max(timestamp)
                    from sys.dba_tab_modifications a3
					where a3.table_name = a1.table_name
                     and a3.table_owner = a1.table_owner
					 and a3.partition_name = a1.partition_name) last_modif,
				 (select truncated from sys.dba_tab_modifications a4
					where a4.table_name = a1.table_name
                     and a4.table_owner = a1.table_owner
					 and a4.partition_name = a1.partition_name) truncated
            from dba_Tab_partitions a1
           where table_owner <> 'SYS' and table_owner like upper('%&owner%') and num_rows > &num_rows)
   where ((aux * 100)/ num_rows) > &pctmod --supera el 10% de modif resp al ultimo calculo de estad
     and last_modif > last_analyzed --Ultima modif es mayor al ultimo analisis
     and round (last_modif - last_analyzed) > &diff_days -- la diferencia entre el ultimo analisis y la ultima actualizacion supera los n dias
union all
select   owner "table_owner", table_name,'' "partition_name", num_rows, aux reg_modif,
         round ((aux * 100)/ num_rows) pct_modif,
         last_analyzed, last_modif, round (last_modif - last_analyzed) diff_days, truncated,
		 'exec dbms_stats.gather_table_stats('''||owner||''', '''||table_name||''', estimate_percent => dbms_stats.auto_sample_size, cascade=>true, method_opt=>''FOR ALL COLUMNS SIZE AUTO'');' stmt
    from (select a1.owner, a1.table_name, a1.num_rows, a1.last_analyzed,
                 (select sum(updates + deletes + inserts)
                    from sys.dba_tab_modifications a2
					where a2.table_name = a1.table_name
                     and a2.table_owner = a1.owner
					 and a2.partition_name is null) aux,
                 (select max(timestamp)
                    from sys.dba_tab_modifications a3
					where a3.table_name = a1.table_name
                     and a3.table_owner = a1.owner
					 and a3.partition_name is null) last_modif,
				(select truncated from sys.dba_tab_modifications a4
					where a4.table_name = a1.table_name
                     and a4.table_owner = a1.owner
					 and a4.partition_name is null) truncated
            from dba_Tables a1
           where owner <> 'SYS' and owner like upper('%&owner%') and num_rows > &num_rows and partitioned = 'NO')
   where ((aux * 100)/ num_rows) > &pctmod --supera el 10% de modif resp al ultimo calculo de estad
     and last_modif > last_analyzed --Ultima modif es mayor al ultimo analisis
     and round (last_modif - last_analyzed) > &diff_days -- la diferencia entre el ultimo analisis y la ultima actualizacion supera los n dias
ORDER BY 6, 5, 8
) a, dba_segments b 
where b.owner=a.table_owner 
and b.segment_name=a.table_name 
and nvl(b.partition_name,'null') = nvl(a.partition_name,'null') 
and bytes/1024/1024 > &size_mb
/

 
prompt Refresh tab modifications view: exec dbms_stats.flush_database_monitoring_info;
 
ttitle off