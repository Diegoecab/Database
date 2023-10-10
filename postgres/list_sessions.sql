select pid as process_id, 
       usename as username, 
       datname as database_name, 
       client_addr as client_address, 
       application_name,
       backend_start,
       state,
       state_change,
       wait_event,
       wait_event_type,
       left(query, 60) 
     --  query
from pg_stat_activity;
