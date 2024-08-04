import sys, boto3, argparse
from prettytable import PrettyTable

parser = argparse.ArgumentParser()
parser.add_argument(
    "-r",
    "--region",
    action="store",
    dest="r",
    help="Which region/Availability Zone to get information from",
)
args = parser.parse_args()

#Colors
R = "\033[0;31;40m" #Red
Y = "\033[0;33;40m" #Yellow
G = "\033[0;32;40m" #Green
N = "\033[0m" #Reset

RdsDbs = PrettyTable()
RdsDbs.align = "l"
RdsDbs.field_names = ['DB identifier', 'Status', 'Role', 'Engine', 'Engine Version', 'Region & AZ', 'Size']

def instances (rdsClient):
    MyDBInstances = rdsClient.describe_db_instances()
    return MyDBInstances

def regions ():
    Regions = boto3.Session().get_available_regions('rds')
    return Regions

def clusters (rdsClient):
    MyDBClusters = rdsClient.describe_db_clusters()
    return MyDBClusters

def globalclusters (rdsClient):
    MyGlobalDBClusters = rdsClient.describe_global_clusters()
    return MyGlobalDBClusters

def getdblist (region):
    rdsClient = boto3.client("rds", region_name=region)
    RdsDbs.title = 'AWS RDS Databases in AWS Region {}'.format(region)
    try:
        MyGlobalDBClusters = globalclusters(rdsClient)
        MyDBClusters = clusters(rdsClient)
        MyDBInstances = instances(rdsClient)
        for c in MyDBClusters["DBClusters"]:
            if len( c["DBClusterMembers"]) > 1: 
                InstanceMembers=(str(len( c["DBClusterMembers"])) + " instances") 
            else:
                InstanceMembers=("1 instance")
            if c["Status"]=='available':
                ClStatus=G+c["Status"]+N 
            else: 
                ClStatus=c["Status"]
            if len( c["DBClusterMembers"]) == 0:
                RdsDbs.add_row([c["DBClusterIdentifier"], ClStatus,"Regional Cluster", c["Engine"],  c["EngineVersion"], "Region",  InstanceMembers], divider=True)
            else:
                RdsDbs.add_row([c["DBClusterIdentifier"], ClStatus,"Regional Cluster", c["Engine"],  c["EngineVersion"], "Region",  InstanceMembers])
            pos = 0
            for member in c["DBClusterMembers"]:
                IsWriterInstance="Writer instance" if member["IsClusterWriter"] else "Reader instance"
                for i in MyDBInstances["DBInstances"]:
                    if  i["DBInstanceIdentifier"] == member["DBInstanceIdentifier"]:
                        pos += 1
                        if i["DBInstanceStatus"]=='available':
                            InstStatus=G+i["DBInstanceStatus"]+N 
                        else: 
                            InstStatus=i["DBInstanceStatus"]
                        if pos == len( c["DBClusterMembers"]):
                            RdsDbs.add_row(["|__"+i["DBInstanceIdentifier"], InstStatus, IsWriterInstance, i["Engine"],  i["EngineVersion"], "Region",   i["DBInstanceClass"]], divider=True)
                        else:
                            RdsDbs.add_row(["|__"+i["DBInstanceIdentifier"], InstStatus, IsWriterInstance, i["Engine"],  i["EngineVersion"], "Region",   i["DBInstanceClass"]])
        for i in MyDBInstances["DBInstances"]:
            try:
                if  i["DBClusterIdentifier"]:
                    continue
            except KeyError:
                if i["DBInstanceStatus"]=='available':
                    InstStatus=G+i["DBInstanceStatus"]+N 
                else: 
                    InstStatus=i["DBInstanceStatus"]
                RdsDbs.add_row([i["DBInstanceIdentifier"], InstStatus, "Instance", i["Engine"], i["EngineVersion"] ,"Region",i["DBInstanceClass"]], divider=True)
        print(RdsDbs)
    except Exception as e:
        print('There was an error trying to list resources in the region {0}. \nException: {1!r}\n'.format(region, e.args))

def main ():
    Regions = regions()
    if args.r not in Regions and str(args.r) != "all":
        parser.print_help(sys.stderr)
        print(
            "\n{} is not a correct availability zone.".format(args.r)
        )
        print("Here is a list of regions:")

        for rg in Regions:
            print(rg)

        sys.exit(1)
    
    if str(args.r) == "all":
        for rg in Regions:
            getdblist (rg)
            RdsDbs.clear_rows()
            
    else:
        getdblist (args.r)
    
main()








