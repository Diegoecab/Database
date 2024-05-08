aws rds describe-db-engine-versions --engine postgres --engine-version 13.11 --query DBEngineVersions[*].ValidUpgradeTarget[*].{EngineVersion:EngineVersion} --region eu-west-1
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.PostgreSQL.html#USER_UpgradeDBInstance.PostgreSQL.MajorVersion
