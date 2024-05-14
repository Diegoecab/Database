printf '%-40s %-10s %-20s %-20s %-10s\n' "Database Identifier" "Status" "Role" "Engine" "Engine Version"
printf '%-40s %-10s %-20s %-20s %-10s\n' -------------------- ------ ------------- ------------- ------------
for cl in $(aws rds describe-db-clusters --query 'DBClusters[].[DBClusterIdentifier]' --out text); do
	cld=$(aws rds describe-db-clusters --db-cluster-identifier $cl --out json --query 'DBClusters[].{Engine:Engine,EngineVersion:EngineVersion,Status:Status}')
	cld=$(echo $cld | jq -c '.[]')
	EngineVersion=$(jq -r '.EngineVersion' <<< "$cld")
	Status=$(jq -r '.Status' <<< "$cld")
	Engine=$(jq -r '.Engine' <<< "$cld")
	printf '%-40s %-10s %-20s %-20s %-10s\n' $cl $Status "Regional cluster" "$Engine" $EngineVersion
	id=$(aws rds describe-db-clusters --db-cluster-identifier $cl --out json --query 'DBClusters[].DBClusterMembers[].{DBInstanceIdentifier:DBInstanceIdentifier,IsClusterWriter:IsClusterWriter }');
	ids=$(echo $id | jq -c '.[]')
	for idl in $ids; do
		DBInstanceIdentifier=$(jq -r '.DBInstanceIdentifier' <<< "$idl")
		dbInstanceStatus=$(aws rds describe-db-instances --db-instance-identifier $DBInstanceIdentifier --query 'DBInstances[].DBInstanceStatus' --out text)
		IsClusterWriter=$(jq '.IsClusterWriter' <<< "$idl")
		if [ "$IsClusterWriter" = "true" ]; then iRole="Writer instance"; else iRole="Reader instance"; fi
		printf '%-40s %-10s %-20s %-20s %-10s\n' "|___$DBInstanceIdentifier" "$dbInstanceStatus" "$iRole" "$Engine" "$EngineVersion"
done;
done;
