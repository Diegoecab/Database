curl -k -vvvv https://oms-host:1159  --ciphers rsa_aes_256_cbc_sha_256
* About to connect() to pl-awsoem001.dboracle.awsprod.healthcareit.net  port 1159 (#0)
*   Trying 10.221.124.5...
* Connected to pl-awsoem001.dboracle.awsprod.healthcareit.net  (10.221.124.5) port 1159 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
* NSS error -12286 (SSL_ERROR_NO_CYPHER_OVERLAP)
* Cannot communicate securely with peer: no common encryption algorithm(s).
* Closing connection 0
curl: (35) Cannot communicate securely with peer: no common encryption algorithm(s).
When testing with other encryption algorithms, we verified that OMS accepted a connection using 'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384'. This shows that the OMS host is available, but not configured with a common algorithm to the one specified for the RDS instance. This value was used only for testing, as RDS for Oracle does not support that encryption algorithm.

The fact that this worked while creating a new DB instance and after updating the instance's Option Group, but not after failover, was circumstantial. OEM Agent is not restarted after applying a new Option Group, so the new option settings are not in effect. However, after a MAZ failover, OEM Agent is restarted and uses the new option settings, which in this case did not include an encryption algorithm that matches the OMS configuration. We acknowledge that this is not the best customer experience, and we will fix this in a future release of our automation software. Nevertheless, the root cause of the issue is the mismatch of the OEM Agent and OMS configuration, and not this behavior in our automation.

To avoid this issue, please configure your OMS host to use a common encryption algorithm with your RDS for Oracle DB instance. For more information about how to configure your OMS host, please contact Oracle Support. For more information about the TLS_CIPHER_SUITE setting and its allowed values, please consult our public documentation: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Oracle.Options.OEMAgent.html#Oracle.Options.OEMAgent.Options 
