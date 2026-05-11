# ------------------------------------------------------------------------------
# File       : listing_unsused_dms_endpoitns.sh
# Purpose    : aws cloud/dms helper: listing unsused dms endpoitns.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./listing_unsused_dms_endpoitns.sh
# Parameters : arg1, arg2
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
#Listing unused DMS endpoints
for i in $(( aws dms describe-replication-tasks --query "ReplicationTasks[].[SourceEndpointArn,TargetEndpointArn]" --out text | sort  | awk '{print $1"\n"$2}' & aws dms describe-endpoints --query "Endpoints[].[EndpointArn]" --out text ) | cat | sort | awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}'); do aws dms describe-endpoints --filters Name="endpoint-arn",Values="$i" --query "Endpoints[].[EndpointIdentifier]" --out text ;done
for i in $(( aws dms describe-replication-tasks --query "ReplicationTasks[].[SourceEndpointArn,TargetEndpointArn]" --out text | sort  | awk '{print $1"\n"$2}' & aws dms describe-endpoints --query "Endpoints[].[EndpointArn]" --out text ) | cat | sort | awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}'); do aws dms describe-endpoints --filters Name="endpoint-arn",Values="$i" --query "Endpoints[].[EndpointArn]" --out text ;done

