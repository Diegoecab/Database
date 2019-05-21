select a.owner, mview_name, rname,  updatable,refresh_method 
from dba_mviews a,dba_refresh_children  b
where mview_name = '&1'
and name = mview_name
and a.owner = b.owner
/