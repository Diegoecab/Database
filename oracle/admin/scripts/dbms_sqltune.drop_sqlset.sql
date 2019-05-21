--dbms_sqltune.drop_sqlset.sql
ttitle off

accept USERN prompt 'SQLSet Owner: '
accept SQLSNAME prompt 'SQLSet Name: '


BEGIN 
dbms_sqltune.drop_sqlset(sqlset_name => '&SQLSNAME', sqlset_owner =>'&USERN');
END;
/