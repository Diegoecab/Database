set lines 900
col value for a50 
col name for a50
 
select name, value, group_number from v$asm_attribute; 
--where upper(name) like 'CELL%';