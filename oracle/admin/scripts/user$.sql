set lines 600
select name,password from sys.user$
where upper(name) like upper('%&name%')
/