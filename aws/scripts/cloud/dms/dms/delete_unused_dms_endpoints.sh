# ------------------------------------------------------------------------------
# File       : delete_unused_dms_endpoints.sh
# Purpose    : aws cloud/dms helper: delete unused dms endpoints.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./delete_unused_dms_endpoints.sh
# Parameters : arg1, arg2
# Risk       : DESTRUCTIVE
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
for r in $(for i in $(( aws dms describe-replication-tasks --query "ReplicationTasks[].[SourceEndpointArn,TargetEndpointArn]" --out text | sort  | awk '{print $1"\n"$2}' & aws dms describe-endpoints --query "Endpoints[].[EndpointArn]" --out text ) | cat | sort | awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}'); do aws dms describe-endpoints --filters Name="endpoint-arn",Values="$i" --query "Endpoints[].[EndpointArn]" --out text ;done); do aws dms delete-endpoint --endpoint-arn $r ; done;


