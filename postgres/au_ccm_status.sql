-- Cluster Cache Management Status
SELECT buffers_sent_last_minute*8/60 AS warm_rate_kbps, 
   100*(1.0-buffers_sent_last_scan/buffers_found_last_scan) AS warm_percent 
   FROM aurora_ccm_status();