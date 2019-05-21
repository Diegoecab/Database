col test format a40
/*indica si algùn paràmetro està seteado en el spfile*/
select decode(count(*), 1, 'SI', 'NO' ) SPFILE
from v$spparameter
where rownum=1 and isspecified='TRUE'
/
prompt
col value format a 60
select value from v$parameter where name = 'spfile'
/