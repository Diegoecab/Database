# ------------------------------------------------------------------------------
# File       : db2_registry_variables.sh
# Purpose    : db2 utilities helper: db2 registry variables.
# Engine     : db2
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./db2_registry_variables.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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
