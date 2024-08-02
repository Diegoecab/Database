#!/usr/local/bin/python3


import boto3, time, argparse, sys


# Arguments

# Get all instance information from specific AZ.
# Get only online instances from specific AZ
#   - Get their public addresses


parser = argparse.ArgumentParser(description="Python AWS Workflow Enhancer")


parser.add_argument(
    "-I",
	"--get-instances",
    action="store_true",
    default=False,
    dest="g",
    help="Get all Instance Information",
)


parser.add_argument(
    "-r",
    "--region",
    action="store",
    dest="r",
    help="Which region/Availability Zone to get information from",
)


parser.add_argument(
    "-az", "--list-az", action="store_true", dest="az", help="List Availability Zones"
)


parser.add_argument(
    "-ga",
    "--get-all",
    action="store_true",
    dest="ga",
    help="Check all the Availablility Zones",
)


args = parser.parse_args()


ec2_client = boto3.client("ec2")


get_r = ec2_client.describe_regions()


l_regions = []


for a, b in get_r.items():

    for c in b:

        if isinstance(c, dict):

            l_regions.append(c["RegionName"])

            # print("{} ".format(c['RegionName']))


def listAvail():

    for i in l_regions:

        print("\t{}".format(i))


def getEverything(ec2_parm, region):

    # Would like to stop bruteforce checking via the API call. Maybe display a message that says, "NOTHING HERE" if nothing is found...

    instances = [i for i in ec2_parm.instances.all()]

    print("\nHere is instance information for region:{}\n\t".format(region))

    name = ""

    for i in instances:

        for tags in i.tags:

            if tags["Key"] == "Name":

                name = tags["Value"]

        if i.state["Name"] == "running":

            print(("\t Name        :\t {}".format(name)))

            print(("\t Instance ID :\t {} \t".format(i.id)))

            print(("\t Status      :\t {} \t".format(i.state["Name"])))

            print(("\t Public DNS  :\t {} \t".format(i.public_dns_name)))

            print(("\t Public IP   :\t {} \t".format(i.public_ip_address)))

            print(("\t Private IP  :\t {}".format(i.private_ip_address)))

            print(("\t Inst  Type  :\t {}".format(i.instance_type)))

            print()

        else:

            print(("\t Name        :\t {}".format(name)))

            print(("\t Instance ID :\t {} \t".format(i.id)))

            print(("\t Status      :\t {} \t".format(i.state["Name"])))

            print(("\t Public DNS  :\t {} \t".format(i.public_dns_name)))

            print(("\t Public IP   :\t {} \t".format(i.public_ip_address)))

            print(("\t Private IP  :\t {}".format(i.private_ip_address)))

            print(("\t Inst  Type  :\t {}".format(i.instance_type)))

            print()


def main():

    if args.az:

        listAvail()

        sys.exit(1)

    if args.ga:

        for i in l_regions:

            ec2 = boto3.resource("ec2", region_name=i)  ## This could be inefficient.

            getEverything(ec2, i)

        sys.exit(1)

    if args.g is False or args.r is None:

        parser.print_help(sys.stderr)

        sys.exit(1)

    if args.r not in l_regions:

        parser.print_help(sys.stderr)

        print(
            colored("\n{} | Is not a correct availability zone.".format(args.r), "red")
        )

        print("Here is a list of regions:")

        listAvail()

        #        print(*l_regions, sep='\n')

        sys.exit(1)

    ec2 = boto3.resource("ec2", region_name=args.r)

    getEverything(ec2, args.r)


main()

