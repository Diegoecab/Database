--v$statistics_level.sql
SELECT statistics_name,
           session_status,
           system_status,
           activation_level,
           session_settable
    FROM   v$statistics_level
    ORDER BY statistics_name;