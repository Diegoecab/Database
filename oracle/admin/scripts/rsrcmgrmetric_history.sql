--rsrcmgrmetric_history
SELECT begin_time,consumer_group_name, cpu_utilization_limit,CPU_WAIT_TIME,NUM_CPUs,avg_cpu_utilization FROM v$rsrcmgrmetric_history order by 1;