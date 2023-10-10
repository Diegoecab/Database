--sql_plan_statistics_all sqlid

set lines 400
col object_owner for a20 truncate
col object_name for a50 truncate
col object_type for a20 truncate
col operation for a40 truncate
col partition_start for a20 truncate
col partition_stop for a20 truncate
col elapsed_time for 9999999999



select * from (
with plan_objects as
     ( select 
              p.object_owner
            , p.object_name
            , p.object_type
            , p.partition_start
            , p.partition_stop
            , p.cardinality
            , p.operation
            , p.options
			, p.time
			, p.last_elapsed_time  / 1000000 AS last_elapsed_time
			, last_output_rows
            , count(*) as occurs_in_plan
       from   gv$sql_plan_statistics_all p
       where  p.sql_id = '&1'
       and    p.plan_hash_value =
              ( select plan_hash_value from
                       ( select plan_hash_value, row_number() over (order by timestamp desc) as seq
                         from   gv$sql_plan p
                         where  p.sql_id = '&1'
                         and    p.inst_id = 1 )
                where seq = 1 )
       and    p.object_type != 'VIEW'
       group by p.object_owner, p.object_name, p.object_type, p.partition_start, p.partition_stop, p.cardinality, p.operation, p.options, p.time, p.last_elapsed_time, last_output_rows )
   , object_stats as
     ( select ts.owner as object_owner
            , ts.table_name as object_name
            , ts.table_name as display_name
            , ts.num_rows
            , ts.blocks
            , ts.last_analyzed
            , ts.stale_stats
       from   dba_tab_statistics ts
       where  (ts.owner, ts.table_name)  in
              (select object_owner, object_name from plan_objects where object_type like 'TABLE%')
       and    ts.partition_name is null
       union
       select xs.owner
            , xs.index_name
            , '(' || xs.table_name || ') ' || index_name as display_name
            , xs.num_rows
            , xs.leaf_blocks as blocks
            , xs.last_analyzed
            , xs.stale_stats
       from   dba_ind_statistics xs
       where  (xs.owner, xs.index_name) in
              (select object_owner, object_name from plan_objects where object_type like 'INDEX%')
       and    xs.partition_name is null
     )
select --+ dynamic_sampling(8)
       object_owner
     , o.object_type
     , nvl(s.display_name,object_name) as object_name
     , s.stale_stats as "Stale?"
     -- , o.occurs_in_plan
     , o.operation || ' ' || o.options as operation
	 , time
	 , last_elapsed_time
     , o.cardinality
     , s.num_rows as "Rows (global)"
     , s.blocks
     , s.last_analyzed
     , o.partition_start
     , o.partition_stop
	 , last_output_rows 
from   plan_objects o
       left join object_stats s using(object_owner, object_name)
order by
      case object_owner when 'SYS' then 2 else 1 end
    , object_owner
    , ltrim(object_name,'(')
);