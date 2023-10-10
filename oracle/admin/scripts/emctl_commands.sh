[oracle@dblxorafront01 datafile]$ /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl control agent runCollection CDB6_RIO6:oracle_pdb tbspAllocation




[oracle@dblxorafront01 datafile]$ /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl getmetric agent CDB6_RIO6,oracle_pdb,tbspAllocation


/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl status agent scheduler | grep -i tbs


/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl status agent scheduler




./emctl control agent runCollection <Target_Name>:oracle_database problemTbsp_10i_Loc_cdb

/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl status agent scheduler | grep -i problemTbsp_10i_Loc_cdb



/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl control agent runCollection CDB39:oracle_database problemTbsp_10i_Loc_cdb





/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl clearstate agent
/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent


select distinct metric_name,metric_column from MGMT$METRIC_DETAILS t where target_type ='oracle_pdb'
and metric_label='Tablespaces Full' and column_label='Tablespace Space Used (%)' 



ssh dblxopersrv03.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent
ssh dblxintesrv01.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent
ssh dblxopersrv01.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent
ssh dblxorainet03.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent
ssh dblxopersrv03.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent
ssh dblxorazero01.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent
ssh dblxintesrv01.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent




ssh dblxorazero01.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl control agent runCollection CDB74:oracle_database problemTbsp_10i_Loc_cdb
ssh dblxorazero01.ar.bsch /oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent


/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl clearstate agent
for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo -e "\n ${db}:oracle_database"
/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl control agent runCollection ${db}:oracle_database problemTbsp_10i_Loc_cdb
done
/oracle/app/oracle/product/agentoms/agent_inst/bin/emctl upload agent