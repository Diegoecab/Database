--dba_feature_usage_statistics_java_jvm
prompt For Oracle version 11.2 or later query the DBA_FEATURE_USAGE_STATISTICS view to confirm if the Java features are being used.

select currently_used, name from  dba_feature_usage_statistics where name like '%Java%';