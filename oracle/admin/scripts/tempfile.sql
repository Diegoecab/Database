--tempfile.sql
select name, BYTES/1024/1024/1024 GB from v$tempfile;
--alter tablespace temp add tempfile size 2G autoextend on next 500M maxsize unlimited;