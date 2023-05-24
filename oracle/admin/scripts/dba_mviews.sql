col master_link for a20
col owner for a20
col query for a40
col mview_name for a40
set lines 400
select mview_name,MASTER_LINK,
REWRITE_ENABLED,
REWRITE_CAPABILITY,
REFRESH_MODE,
REFRESH_METHOD,
BUILD_MODE,
FAST_REFRESHABLE,
LAST_REFRESH_TYPE,
LAST_REFRESH_DATE from dba_mviews
/
