# Powershell script for Louie Liu to simulate Perl scripting data mining on Perf Databases
# - Louie Liu @Citi May, 2013
# - Added frame information provided by the upgraded BMC agent. -Louie, April 3, 2014
# - Partition_name changed to node_name in caxvm to address inconsistent naming issue. - June 16, 2014
# - Added Frame avg physical cpu usage %. - June 17, 2014
# - Added Frame avg physical cpu allocation %. - June 18, 2014
# - Corrected SQL for frame physical cpu usage: Average, Max and P90 - June 23, 2014
# - Added CPU Allocation max/avg/90-percentile (PC usage) - July 1, 2014
# - Added nodeVALIDATE function - July 3, 2014

$username = "forecast_usr"
$password = "b1vizuser"
#$targetDbinstance = "cppd2viz"
$targetDbinstance = "cpp1viz"
if ($args[0] -ne $null) {
$nodeName = $args[0].toLower() }
$startD = $args[1]
$endD = $args[2]

#$sourceFileFullPath = "C:\Temp\cpp4aix.ps1"
$sourceFileFullPath = $myInvocation.myCommand.path
$sourcePath = [System.IO.Path]::GetDirectoryName($sourceFileFullPath)
$sourceFileName = [System.IO.Path]::GetFileName($sourceFileFullPath)
$logFile = [System.IO.Path]::Combine($sourcePath,$("{0}.log" -f $sourceFileName ))

$sqlSet1 = "SET PAGESIZE 0"
$sqlSet2 = "SET FEEDBACK OFF"

#Check if log file exists.
$FileExists = (Test-Path $logFile -PathType Leaf)
If (!($FileExists)) 
{
echo "Host;Start Date;End Date;Status;Aperture OS;Type;Frame;Model;CPU;Clock;Real OS Type;OS Version;Min Dedicated Processors;Min vCPU;Max vCPU;Min Ent;Max Ent;Avg Used CPU;Max CPU Used;Min Total Memory;Max Total Memory;P90 CPU Used;Avg CPU Allocation;Max CPU Allocation;P90 CPU Allocation;Real Memory Max;Paging 2PCT;Max IO MB/S;Max Network MB/S;Application;Frame Configured CPU;Frame Configure Memory MB;Frame Available CPU Units;Frame Available Memory MB;Frame Avg Physical CPU Usage %;Frame Max Physical CPU Usage %;Frame P90 Physical CPU Usage %" >$logFile
}

#"[$([datetime]::now)]Running Script $sourceFileFullPath...." >> $logFile

function sqlCALL
{
echo $sqlSet1 $sqlSet2 $sqlStatement |sqlplus -s $username/$password`@$targetDbinstance
}

function outPUT
{
write-host "start-date:" $startDate "- end-date:" $endDate
write-host "Status:" $deComm "- Aperture OS:" $osType "- Real OS:" (%{$sqlOutput_hardware.split(";")[5]}) (%{$sqlOutput_hardware.split(";")[6]})
write-host "type:" (%{$sqlOutput_hardware.split(";")[0]}) "- frame:" (%{$sqlOutput_hardware.split(";")[1]})
write-host "model:" (%{$sqlOutput_hardware.split(";")[2]}) "- cpu:" (%{$sqlOutput_hardware.split(";")[3]}) "- clock:" (%{$sqlOutput_hardware.split(";")[4]})
write-host "min dedicated_processors:" (%{$sqlOutput.split(";")[0]})
write-host "min virtual processors:" (%{$sqlOutput.split(";")[1]}) "- max virtual processors:" (%{$sqlOutput.split(";")[2]})
write-host "min entitlement:" (%{$sqlOutput.split(";")[3]}) "- max entitlement:" (%{$sqlOutput.split(";")[4]})
write-host "avg cpu used:" (%{$sqlOutput.split(";")[5]}) "- max cpu used:" (%{$sqlOutput.split(";")[6]})
write-host "90-percentile cpu used:" (%{$sqlOutput_90pctcpuused})
write-host "avg cpu allocation:" (%{$sqlOutput_cpuallocation.split(";")[0]}) "- max cpu allocation:" (%{$sqlOutput_cpuallocation.split(";")[1]})
write-host "90-percentile cpu allocation:" (%{$sqlOutput_cpuallocation.split(";")[2]})
write-host "min total memory (mb):" (%{$sqlOutput.split(";")[7]}) "- max total memory (mb):" (%{$sqlOutput.split(";")[8]})
write-host "real memory max:" (%{$sqlOutput_realm_2pctpaging_io_network.split(";")[0]}) "- paging 2pct:" (%{$sqlOutput_realm_2pctpaging_io_network.split(";")[1]})
write-host "max io mb/s:" (%{$sqlOutput_realm_2pctpaging_io_network.split(";")[2]}) "- max network mb/s:" (%{$sqlOutput_realm_2pctpaging_io_network.split(";")[3]})
write-host "frame configured cpu:" (%{$sqlOutput_frame.split(";")[0]}) "- frame configured memory (mb):" (%{$sqlOutput_frame.split(";")[1]})
write-host "frame available cpu units:" (%{$sqlOutput_frame.split(";")[2]}) "- frame available memory (mb):" (%{$sqlOutput_frame.split(";")[3]})
write-host "frame average physical cpu usage %:" (%{$sqlOutput_frame_usage.split(";")[0]})
write-host "frame max physical cpu usage %:" (%{$sqlOutput_frame_usage.split(";")[1]}) 
write-host "frame 90-percentile physical cpu usage %:" (%{$sqlOutput_frame_usage.split(";")[2]})
"{0};{1};{2};{3};{4};{5};{6};{7};{8};{9};{10};{11};{12}" -f $nodeName,$startDate,$endDate,$deComm,$osType,$sqlOutput_hardware,$sqlOutput,$sqlOutput_90pctcpuused,$sqlOutput_cpuallocation,$sqlOutput_realm_2pctpaging_io_network,$appL,$sqlOutput_frame,$sqlOutput_frame_usage |out-file -filepath $logFile -append
}

function sysSTAT
{
write-host $nodeName "-" $appL
$sqlStatement = "select min(dedicated_processors)||';'||min(virtual_processors)||';'||max(virtual_processors)||';'||min(entitlement)||';'||max(entitlement)||';'||round(avg(cpu_used),2)||';'||round(max(cpu_used),2)||';'||min(total_memory)||';'||max(total_memory) from caxvmd where vms in (select indexx from caxvm where node_name='$nodeName') and intvl between (select min(indexx) from caxintvl where int_start_date like '$startDate') and (select max(indexx) from caxintvl where int_start_date like '$endDate');"
sqlCALL |tee-object -variable sqlOutput |out-null
$sqlStatement = "select round(max((memory_size-(free_mem+buff_cache_siz/1024))/memory_size),2)||';'||round(percentile_cont(.02) WITHIN GROUP (order by paging_io_rate desc),2)||';'||round(max(total_io_rate)*4/1024,2)||';'||round(max(network_byte_rate),2) from caxnode,caxnoded where indexx=systems and systems in (select indexx from caxnode where host_name='$nodeName') and intvl in (select indexx from caxintvl where int_start_date between '$startDate' and '$endDate');"
sqlCALL |tee-object -variable sqlOutput_realm_2pctpaging_io_network |out-null
#$sqlStatement = "select trim(round(percentile_cont(.9) WITHIN GROUP (order by cpu_used asc),2)) from caxvmd where vms in (select indexx from caxvm where partition_name = '$nodeName') and intvl in (select indexx from caxintvl where int_start_date between '$startDate' and  '$endDate') order by cpu_used asc;"
$sqlStatement = "select trim(round(percentile_cont(.9) WITHIN GROUP (order by cpu_used asc),2)) from caxvmd where vms in (select indexx from caxvm where node_name = '$nodeName') and intvl in (select indexx from caxintvl where int_start_date between '$startDate' and  '$endDate') order by cpu_used asc;"
sqlCALL |tee-object -variable sqlOutput_90pctcpuused |out-null
$sqlStatement = "select max(distinct trim(partition_type)||';'||trim(host_ID)||';'||trim(system_model)||';'||trim(cpu_model)||';'||trim(clock_rate)||';'||trim(os_type)||';'||trim(os_version)) from caxnode where host_name = '$nodeName';"
sqlCALL |tee-object -variable sqlOutput_hardware |out-null
$sqlStatement = "select max(physical_processors)||';'||max(Total_Memory)||';'||min(Unassigned_Cores)||';'||min(Unassigned_Mem) from caxpsysd where physs in (select indexx from caxpsys where host_name='$frameID') and intvl between (select min(indexx) from caxintvl where int_start_date like '$startDate') and (select max(indexx) from caxintvl where int_start_date like '$endDate');"
sqlCALL |tee-object -variable sqlOutput_frame |out-null
#$sqlStatement = "select round(sum(avg((vde.cpu_used/pde.physical_processors)*100)),2)||';'||round(sum(avg(((VDE.System_CPU_Used + VDE.User_CPU_Used + VDE.Idle_CPU_Alloc + VDE.Wait_CPU_Alloc)/pde.physical_processors)*100)),2) from CAXPSYSD pde,CAXVMD vde,caxvm ve where pde.physs in (select indexx from caxpsys where host_name='$frameID') and VE.INDEXX=VDE.VMS and vde.pHYSS=PDE.PHYSS and pde.intvl=vde.intvl and vde.intvl in (select indexx from caxintvl where int_start_date between '$startDate' and  '$endDate') group by partition_name;"
$sqlStatement = "SELECT round(Avg(SUM(GUEST.CPU_USED)),2)||';'||round(Max(SUM(GUEST.CPU_USED)),2)||';'||round(percentile_cont(.9) WITHIN GROUP (order by SUM(GUEST.CPU_USED) asc),2)
     FROM CAXINTVL I, 
     (SELECT AVG(100 * (VDE.CPU_USED/PDE.PHYSICAL_PROCESSORS)) AS CPU_USED,
             VE.NODE_NAME AS NODE_NAME,
             IE.INDEXX AS IIDX,
             PE.HOST_NAME AS HOST_NAME
      FROM CAXINTVL IE, CAXPSYS PE, CAXPSYSD PDE, CAXVM VE, CAXVMD VDE
      WHERE PDE.PHYSS=PE.INDEXX
        AND PDE.INTVL=IE.INDEXX
        AND VDE.PHYSS=PDE.PHYSS
        AND VE.INDEXX=VDE.VMS
        AND VDE.INTVL=IE.INDEXX
        AND VDE.INTVL=PDE.INTVL
        AND VDE.CPU_USED >= 0
        AND IE.INTTYPE='M'
        AND PDE.PHYSICAL_PROCESSORS > 0 
        AND NOT EXISTS (SELECT 0
                              FROM CAXPOOL PLSE, CAXPOOLD PLDE, CAXINTVL IE2
                              WHERE PLDE.INTVL = IE2.INDEXX 
                                AND PLSE.INDEXX = PLDE.POOLS
                                AND PLSE.VIRTUALIZATION_TYPE IN ('PowerVM') 
                                AND VDE.POOLS = PLDE.POOLS
                                AND IE2.INTTYPE='M'
                                AND IE2.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
                              GROUP BY PLDE.POOLS)
        AND VE.VIRTUAL_TYPE IN ('SPLPAR')
        AND PE.HOST_TYPE IN ('PowerVM')
        AND PE.HOST_NAME IN ('$frameID')
        AND IE.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
     GROUP BY VE.NODE_NAME, PE.HOST_NAME, IE.INDEXX
     UNION
     SELECT AVG(100 * (VDE.CPU_USED/PDE.PHYSICAL_PROCESSORS)) AS CPU_USED,
             VE.NODE_NAME AS NODE_NAME,
             IE.INDEXX AS IIDX,
             PE.HOST_NAME AS HOST_NAME
      FROM CAXINTVL IE, CAXPSYS PE, CAXPSYSD PDE,
           CAXVM VE, CAXVMD VDE, CAXPOOL PL, CAXPOOLD PLD
      WHERE PDE.PHYSS=PE.INDEXX
        AND PDE.INTVL=IE.INDEXX
        AND VDE.PHYSS=PDE.PHYSS
       AND VE.INDEXX=VDE.VMS
        AND VDE.INTVL=IE.INDEXX
        AND PL.INDEXX=PLD.POOLS
        AND PLD.INTVL=IE.INDEXX
        AND PLD.POOLS=VDE.POOLS
        AND PLD.INTVL=VDE.INTVL
        AND PDE.INTVL=VDE.INTVL
        AND PLD.INTVL=PDE.INTVL
        AND VDE.CPU_USED >= 0
        AND PDE.PHYSICAL_PROCESSORS > 0 
        AND PLD.CPU_USED < 0
        AND IE.INTTYPE='M'
        AND VE.VIRTUAL_TYPE IN ('SPLPAR')
        AND PE.HOST_TYPE IN ('PowerVM')
        AND PE.HOST_NAME IN ('$frameID')
        AND IE.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
     GROUP BY VE.NODE_NAME, PE.HOST_NAME, IE.INDEXX
     UNION
     SELECT AVG(100 * (PLD.CPU_USED/PDE.PHYSICAL_PROCESSORS)) AS CPU_USED,
             PL.POOL_ID AS NODE_NAME,
             IE.INDEXX AS IIDX,
             PE.HOST_NAME AS HOST_NAME
      FROM CAXINTVL IE, CAXPSYS PE, CAXPSYSD PDE,
           CAXVM VE, CAXVMD VDE, CAXPOOL PL, CAXPOOLD PLD
      WHERE PDE.PHYSS=PE.INDEXX
        AND PDE.INTVL=IE.INDEXX
        AND VDE.PHYSS=PDE.PHYSS
       AND VE.INDEXX=VDE.VMS
        AND VDE.INTVL=IE.INDEXX
        AND PL.INDEXX=PLD.POOLS
        AND PLD.INTVL=IE.INDEXX
        AND PLD.INTVL=VDE.INTVL
        AND PLD.POOLS=VDE.POOLS
        AND PDE.PHYSICAL_PROCESSORS > 0 
        AND PLD.CPU_USED >= 0
        AND IE.INTTYPE='M'
        AND VE.VIRTUAL_TYPE IN ('SPLPAR')
        AND PE.HOST_TYPE IN ('PowerVM')
        AND PE.HOST_NAME IN ('$frameID')
        AND IE.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
      GROUP BY PE.HOST_NAME, IE.INDEXX, PL.POOL_ID
      UNION
      SELECT AVG(100 * (VDE.CPU_USED/PDE.PHYSICAL_PROCESSORS)) AS CPU_USED,
             VE.NODE_NAME AS NODE_NAME,
             IE.INDEXX AS IIDX,
             PE.HOST_NAME AS HOST_NAME
      FROM CAXINTVL IE, CAXPSYS PE, CAXPSYSD PDE, CAXVM VE, CAXVMD VDE
      WHERE PDE.PHYSS=PE.INDEXX
        AND PDE.INTVL=IE.INDEXX
        AND VDE.PHYSS=PDE.PHYSS
        AND VE.INDEXX=VDE.VMS
        AND VDE.INTVL=IE.INDEXX
        AND VDE.INTVL=PDE.INTVL
       AND VDE.CPU_USED >= 0
        AND PDE.PHYSICAL_PROCESSORS > 0
        AND IE.INTTYPE='M'
        AND VE.VIRTUAL_TYPE IN ('LPAR', 'DLPAR')
        AND PE.HOST_TYPE IN ('PowerVM')
        AND PE.HOST_NAME IN ('$frameID')
        AND IE.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
      GROUP BY VE.NODE_NAME, PE.HOST_NAME, IE.INDEXX
     ) GUEST
     WHERE I.INDEXX = GUEST.IIDX
       AND I.INTTYPE='M' 
       AND I.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
     GROUP BY GUEST.HOST_NAME, I.INT_START_DATE, I.INT_START_TIME, I.INDEXX
     ORDER BY GUEST.HOST_NAME, I.INT_START_DATE, I.INT_START_TIME, I.INDEXX;"
sqlCALL |tee-object -variable sqlOutput_frame_usage |out-null
$sqlStatement = "SELECT round(avg(VD.System_CPU_Used + VD.User_CPU_Used + VD.Idle_CPU_Alloc + VD.Wait_CPU_Alloc),2)||';'||round(max(VD.System_CPU_Used + VD.User_CPU_Used + VD.Idle_CPU_Alloc + VD.Wait_CPU_Alloc),2)||';'||round(percentile_cont(.9) WITHIN GROUP (order by (VD.System_CPU_Used + VD.User_CPU_Used + VD.Idle_CPU_Alloc + VD.Wait_CPU_Alloc) asc),2)
	  FROM CAXINTVL I, CAXVM V, CAXVMD VD
         WHERE  V.INDEXX = VD.VMS AND
                I.INDEXX = VD.INTVL AND
                I.INTTYPE='M' AND 
                (VD.System_CPU_Used + VD.User_CPU_Used + VD.Idle_CPU_Alloc + VD.Wait_CPU_Alloc) >= 0 AND
                V.VIRTUAL_TYPE IN ('SPLPAR','LPAR','DLPAR') AND 
                V.NODE_NAME IN ('$nodeName') AND
                I.INT_START_DATE BETWEEN '$startDate' AND '$endDate'
         ORDER BY V.NODE_NAME, I.INT_START_DATE, I.INT_START_TIME, I.INDEXX;"
sqlCALL |tee-object -variable sqlOutput_cpuallocation |out-null
outPUT
}

function nodeVALIDATE
{
$sqlStatement = "SELECT nodename FROM mainnodelist where lower(os_type) like '%aix%' and nodename='$nodeName';"
if ($(sqlCALL) -eq $null) { write-host "$nodeName is not an AIX server."
$sqlStatement = "SELECT os_type,application FROM mainnodelist where nodename='$nodeName';"
if ($(sqlCALL) -ne $null) { write-host (sqlCALL)[0,1] }; exit}
}

if ($nodeName -ne $null)
{
nodeVALIDATE
$sqlStatement = "SELECT nodename||';'||dblocation||';'||decommissioned||';'||os_type||';'||application FROM mainnodelist where nodename='$nodeName';"
$nodeSpecial = (sqlCALL)
$dbLocation = (%{"$nodeSpecial".split(";")[1]})
$deComm = (%{"$nodeSpecial".split(";")[2]})
$osType = (%{"$nodeSpecial".split(";")[3]})
$sqlStatement = "set linesize 1000`n SELECT application FROM mainnodelist where nodename='$nodeName';"
$appL = (sqlCALL)
#echo $dbLocation
#echo $deComm
#echo $osType
#echo $appL

$sqlStatement = "SELECT Location||';'||Dbserver||';'||Login||';'||Password FROM dblocdet where Location='$dbLocation';"
$dbSpecial = (sqlCALL)
$targetDbinstance = (%{$dbSpecial.split(";")[1]})
$username = (%{$dbSpecial.split(";")[2]})
$password = (%{$dbSpecial.split(";")[3]})
#echo $targetDbinstance
#echo $username
#echo $password

$sqlStatement = "select max(trim(host_ID)) from caxnode where host_name='$nodeName';"
$frameID = (sqlCALL)
#echo $frameID

#$sqlStatement = "select trim(host_name)||';'||trim(os_type)||';'||trim(os_version)||';'||model from caxnode where host_name='$nodeName';"
#sqlCALL

if (($startD -ne $null) -and ($endD -ne $null))
{
$startDate = $startD
$endDate = $endD
sysSTAT
}
elseif ($startD -ne $null)
{
$startDate = $startD
$sqlStatement = "select trim(max(intvl)) from caxvmd where vms in (select indexx from caxvm where node_name='$nodeName');"
$maxIntvl = (sqlCALL |%{$_.split(";")[0]})
$sqlStatement = "select max(int_start_date) from caxintvl where indexx = $maxIntvl;"
$endDate = (sqlCALL |%{$_.split(";")[0]})
sysSTAT
}
else
{
$sqlStatement = "select trim(min(intvl))||';'||trim(max(intvl)) from caxvmd where vms in (select indexx from caxvm where node_name='$nodeName');"
$minIntvl = (sqlCALL |%{$_.split(";")[0]})
$maxIntvl = (sqlCALL |%{$_.split(";")[1]})
$sqlStatement = "select min(int_start_date)||';'||max(int_start_date) from caxintvl where indexx between $minIntvl and $maxIntvl;"
$startDate = (sqlCALL |%{$_.split(";")[0]})
$endDate = (sqlCALL |%{$_.split(";")[1]})
sysSTAT
}
}
else
{
$sqlStatement = "SELECT nodename||';'||dblocation||';'||decommissioned||';'||os_type FROM mainnodelist where lower(os_type) like '%aix%';"
#$sqlStatement = "SELECT distinct os_type FROM mainnodelist where lower(os_type) like '%aix%';"
sqlCALL
}

#"[$([datetime]::now)]------------FINISHED COMPILING-------" >> $logFile
#"" >> $logFile
