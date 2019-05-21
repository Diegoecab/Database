--
set  linesize 250
col name format a30
col value format a30
COL PROXY_NAME FORMAT A10


prompt v$parameter

SELECT NAME, VALUE FROM V$PARAMETER WHERE name like 'audi%'
/


prompt statements

select * from sys.dba_stmt_audit_opts
order by user_name, proxy_name, audit_option 
/

prompt default

select * from all_def_audit_opts
/

prompt objects

select owner, object_name, object_type, 
       alt,aud,com,del,gra,ind,ins,loc,ren,sel,upd,ref,exe 
from sys.dba_obj_audit_opts 
where  
   alt !='-/-' or aud !='-/-' or com !='-/-' 
or del !='-/-' or gra !='-/-' or ind !='-/-' 
or ins !='-/-' or loc !='-/-' or ren !='-/-' 
or sel !='-/-' or upd !='-/-' or ref !='-/-' or exe !='-/-' 
ORDER BY owner, object_name, object_type
/ 

prompt privileges

select * from dba_priv_audit_opts
order by user_name, proxy_name, privilege
/
