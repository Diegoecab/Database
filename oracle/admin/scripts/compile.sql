set pagesize 0
select  'alter ' || decode(object_type, 'PACKAGE BODY', 'package', object_type) ||
       ' ' ||  object_name|| ' compile' ||  decode(object_type, 'PACKAGE BODY', ' body;', ';')
from   dba_objects
where  status <> 'VALID' and object_name like '&1%'

/