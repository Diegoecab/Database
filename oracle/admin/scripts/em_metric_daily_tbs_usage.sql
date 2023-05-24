--em_metric_daily_tbs_usage.sql
--select distinct target_name from MGMT$TARGET_METRIC_SETTINGS where target_name like '%rgibsp%;
SELECT Database,
Month_Date,
round(sum(decode(metric_column, 'spaceUsed', maximum))/1024/1024, 3) Used_Size_Tb,
round(sum(decode(metric_column, 'spaceAllocated', maximum))/1024/1024, 3) Allocated_Size_Tb
FROM
(
SELECT target_name Database, trunc(rollup_timestamp, 'MONTH') Month_Date, key_value TB, metric_column, round(max(maximum),0) maximum
FROM mgmt$metric_daily
WHERE target_type = 'rac_database'
and metric_name = 'tbspAllocation'
and metric_column in ('spaceAllocated', 'spaceUsed')
and target_name in ('&target_name')
GROUP BY target_name, key_value, trunc(rollup_timestamp, 'MONTH'), metric_column
)
GROUP BY Database, Month_Date
ORDER BY Database, Month_Date
/