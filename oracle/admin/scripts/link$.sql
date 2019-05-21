set lines 800
col passwordx for a300
col authpwdx for a20
set pages 5000

select
owner#, name, host, userid, password, authusr, authpwd, passwordx--, authpwdx
from sys.link$
where --upper(name) like upper('%&name%')
--and upper(host) like upper('%&host%')
--and 
upper(userid) like upper('%&userid%')
--and upper(password) like upper('%&password%')
--and 
--upper(authusr) like upper('%&authusr%')
/