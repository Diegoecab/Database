set serveroutput on
set pages 80
set lines 185

define name=&1
begin
	dbms_sqltune.capture_cursor_cache_sqlset (
		sqlset_name => '&name'
		, time_limit => 216000 -- 1 hour ; 108000 30min; 300 5min
		, repeat_interval => 5 -- seconds
		, capture_mode => dbms_sqltune.MODE_ACCUMULATE_STATS
		, basic_filter => 'parsing_schema_name=upper(''&schema'')'
		);
end;
/
