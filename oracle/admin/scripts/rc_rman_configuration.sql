--rc_rman_configuration
set pages 100
set lines 900
select a.name, b.* from
rc_database a,
rc_rman_configuration b
where a.db_key = b.db_key
and a.name like upper('%&db_name%')
order by a.name, conf#
/