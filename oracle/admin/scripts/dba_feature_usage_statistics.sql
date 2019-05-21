--dba_feature_usage_statistics
col name for a45
col detected_usages for 999999
col total_samples for 9999999
col version for a10
SELECT name,version,first_usage_date,last_usage_date,detected_usages,total_samples
  FROM dba_feature_usage_statistics
 WHERE dbid IN (SELECT dbid
                  FROM v$database);