--dba_column_usage.sql
/*
create view dba_column_usage
as
select oo.name owner,
o.name,
c.name column_name,
u.equality_preds,
u.equijoin_preds,
u.nonequijoin_preds,
u.range_preds,
u.like_preds,
u.null_preds,
u.timestamp
from sys.col_usage$ u,
sys.obj$ o,
sys.user$ oo,
sys.col$ c
where o.obj# = u.obj#
and oo.user# = o.owner#
and c.obj# = u.obj#
and c.col# = u.intcol#;

create public synonym dba_column_usage for dba_column_usage;


*/

set lines 400

select * from dba_column_usage 
where owner like upper ('%&owner%')
and name like upper ('%&name%')
and column_name like upper ('%&column_name%')
order by 1,2,10
/