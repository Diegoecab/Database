for r in $(for i in $(( aws dms describe-replication-tasks --query "ReplicationTasks[].[SourceEndpointArn,TargetEndpointArn]" --out text | sort  | awk '{print $1"\n"$2}' & aws dms describe-endpoints --query "Endpoints[].[EndpointArn]" --out text ) | cat | sort | awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}'); do aws dms describe-endpoints --filters Name="endpoint-arn",Values="$i" --query "Endpoints[].[EndpointArn]" --out text ;done); do aws dms delete-endpoint --endpoint-arn $r ; done;


