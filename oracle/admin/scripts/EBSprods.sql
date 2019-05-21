set echo off veri off
accept 1 prompt 'Enter PATCH LEVEL (ej. 11i.FND.G):'

select patch_level, application_name
from apps.fnd_product_installations fpi
, apps.fnd_application_tl fat
where patch_level is not null
and fpi.application_id = fat.application_id
and PATCH_LEVEL like upper('%&&1%')
order by application_name
/
