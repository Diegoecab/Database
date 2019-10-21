srvctl modify service -db crm -service GL -failovermethod BASIC -failovertype SELECT 
-failoverretry 10 -failoverdelay 30