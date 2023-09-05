Select max((octet_length(native_message))/(1024)) as "size in KB" from clinical_message; 

Select max((octet_length(<COL_NAME>))/(1024)) as “size in KB” from <TABLE_NAME>; 
