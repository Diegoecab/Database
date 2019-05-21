set long 3000

select dbms_metadata.get_ddl ('TABLE',upper('&1')) FROM DUAL
/
