aws rds describe-db-snapshots \
    --snapshot-type manual --output table

aws rds describe-db-snapshots \
    --snapshot-type manual \
    --query "length(*[].{DBSnapshots:SnapshotType})" \
    --region eu-central-1
