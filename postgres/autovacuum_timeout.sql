
To avoid the session timeout, you can set below parameters in the DB parameter group. If you are using same parameter group for multiple databases, then please review the setting for any possible impact. These parameters are dynamic so no need to restart the DB instance.

tcp_keepalives_count=2
tcp_keepalives_interval=30
tcp_keepalives_idle= 300

Also, you can create a script with below parameters, Vacuum command and run the script using nohup option. Below is an example:

set idle_in_transaction_session_timeout = 0;
set statement_timeout = 0;
VACUUM FREEZE VERBOSE rkms.transaction;  

[+] Working with parameters on your RDS for PostgreSQL DB instance - RDS for PostgreSQL DB instance parameter list - https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.PostgreSQL.CommonDBATasks.Parameters.html#Appendix.PostgreSQL.CommonDBATasks.Parameters.parameters-list
[+] https://www.postgresql.org/docs/current/runtime-config-client.html

Finally, if possible, you can try to reduce the rate of transactions on the DB until you are out of the issue, this will provide some more time for XID wraparound. 

