#!/bin/bash

#-----------------------------------------------------------------------------------------

show_usage() {

  echo ""

  echo "Script Usage : $0 RDS_END_POINT DEST_RES_ID [DEST_PORT]"

  echo ""

  echo "     RDS_END_POINT : Fully qualified endpoint of the RDS Database (Cluster/Instance)"

  echo "     DEST_RES_ID   : AWS Resource ID of the Destination Resource (NAT, IGW, TGW, VPCE etc.) "

  echo "     DEST_PORT     : [Optional] Port of the Detination resource"

  echo ""

  echo "script execution failed argument(S) missing"

  echo ""

  exit 1

}

#------------------------------- Send Mail  ----------------------------------------------

# Input validation

if [ $# -eq 2 ]; then

   RDS_EP=$1

   DEST_ID=$2

elif [ $# -eq 3 ]; then

   RDS_EP=$1

   DEST_ID=$2

   DEST_PORT=$3

else

   show_usage

fi

# Get IP of RDS DB Instance using nslookup

DB_HOST_IP=$(nslookup ${RDS_EP} | tail -2 | head -1 | cut -d':' -f 2 | sed 's/ //g')

echo -e "Source IP adderss : ${DB_HOST_IP}"

# Get RDS DB Instance ENI

DB_HOST_ENI=`aws ec2 describe-network-interfaces --filters Name=private-ip-address,Values=${DB_HOST_IP} --query 'NetworkInterfaces[*].[NetworkInterfaceId]' --no-cli-pager --output text`

if [ $? -ne 0 ]; then

  echo -e "Error in fetching ENI details"

  exit 1

else

  echo -e "Source ENI : ${DB_HOST_ENI}"

fi

# Create network insights analysis path

if [ $# -eq 3 ]; then

   NI_PATH_ID=`aws ec2 create-network-insights-path --source ${DB_HOST_ENI} --destination ${DEST_ID} --destination-port ${DEST_PORT} --protocol TCP --query 'NetworkInsightsPath.NetworkInsightsPathId' --no-cli-pager --output text`

else

   NI_PATH_ID=`aws ec2 create-network-insights-path --source ${DB_HOST_ENI} --destination ${DEST_ID} --protocol TCP --query 'NetworkInsightsPath.NetworkInsightsPathId' --no-cli-pager --output text`

fi

echo -e "Network Insights Path ID : ${NI_PATH_ID}"

# Start network insights analysis

NIA_ID=`aws ec2 start-network-insights-analysis --network-insights-path-id ${NI_PATH_ID} --query 'NetworkInsightsAnalysis.NetworkInsightsAnalysisId' --no-cli-pager --output text`

echo -e "Network Insights Analysis ID : ${NIA_ID}"

# Validate Result

STATUS=""

while [ "${STATUS}" == "" ]; do

  echo -e "Analysis in progress, wiating for 10 sec... "

  sleep 10

  STATUS=`aws ec2 describe-network-insights-analyses --network-insights-analysis-ids ${NIA_ID} --query 'NetworkInsightsAnalyses[].NetworkPathFound' --no-cli-pager --output text`

done

echo -e "Network Insights Analysis Status : ${STATUS}"

if [ "${STATUS}" == "True" ]; then

# Success

   echo -e "\nFound path to the destination"

   echo -e "\nForward Path :\n"

   aws ec2 describe-network-insights-analyses --network-insights-analysis-ids ${NIA_ID} \

   --query '[ NetworkInsightsAnalyses[*].ForwardPathComponents[*].SequenceNumber, NetworkInsightsAnalyses[*].ForwardPathComponents[*].Component[].Id ]' \

   --no-cli-pager --output table

   echo -e "\nReturn Path :\n"

   aws ec2 describe-network-insights-analyses --network-insights-analysis-ids ${NIA_ID} \

   --query '[ NetworkInsightsAnalyses[*].ReturnPathComponents[*].SequenceNumber, NetworkInsightsAnalyses[*].ReturnPathComponents[*].Component[].Id ]' \

   --no-cli-pager --output table

else

# Failure

   echo -e "\nNo Path Found to the destination"

   echo -e "\nDetails :\n"

   aws ec2 describe-network-insights-analyses --network-insights-analysis-ids ${NIA_ID} \

   --query 'NetworkInsightsAnalyses[*].Explanations[*]' --no-cli-pager --output table

fi<
