pgbench -i postgres
pgbench --host rds-pg-labs.cdus3jhjlk3a.us-east-1.rds.amazonaws.com --username=masteruser --protocol=prepared -P 30 --time=300 --client=200 --jobs=200 postgres
