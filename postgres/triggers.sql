SELECT distinct event_object_table AS table_name ,trigger_name,action_statement
FROM information_schema.triggers  
ORDER BY table_name ,trigger_name;

SELECT  event_object_table AS table_name ,trigger_name         
FROM information_schema.triggers  
GROUP BY table_name , trigger_name 
ORDER BY table_name ,trigger_name 
