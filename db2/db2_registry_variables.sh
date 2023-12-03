#Display all the set variables, including global ones
db2set -all 
#Displays help detail on this command
db2set -h
#Displays all variables, set or not
db2set -lr
#set a particular variable to a partic value
db2set db2_clp_histsize=100
#resets value ot its default
db2set db2_clp_histsize=
#interective CLP mode requires OS ! invocation method
db2 => !db2set -all
