# ------------------------------------------------------------------------------
# File       : modify_option_group.sh
# Purpose    : AWS/RDS/DMS Oracle administration helper: modify option group.
# Category   : cloud/aws
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./modify_option_group.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds add-option-to-option-group \
	    --option-group-name oracle-ee-19-apex-diegoec \
	        --options "OptionName=Timezone,OptionSettings=[{Name=TIME_ZONE,Value=Africa/Cairo}]" \
		    --apply-immediately


aws rds add-option-to-option-group \
	    --option-group-name oracle-ee-19-apex-diegoec \
	        --options "OptionName=APEX" \
		    --apply-immediately
	


aws rds modify-db-instance \
	    --db-instance-identifier orclro \
	        --option-group-name oracle-ee-19-apex-diegoec \
		    --apply-immediately


aws rds remove-option-from-option-group \
	     --option-group-name oracle-ee-19-apex-diegoec \
	          --options APEX \
		       --apply-immediately

--This worked fine


aws rds remove-option-from-option-group \
	    --option-group-name oracle-ee-19-apex-diegoec \
	        --options Timezone \
		    --apply-immediately
	
--Returned this message:
An error occurred (InvalidOptionGroupStateFault) when calling the ModifyOptionGroup operation: The option 'Timezone' cannot be deleted because it is persistent.


aws rds modify-db-instance \
	    --db-instance-identifier orclro \
	        --option-group-name default:oracle-ee-19 \
		    --apply-immediately

--Returned this message:
The requested instance must be associated with an option group that contains the permanent option Timezone.



aws rds add-option-to-option-group \
	    --option-group-name oracle-ee-19-apex-diegoec-2 \
	        --options "OptionName=Timezone,OptionSettings=[{Name=TIME_ZONE,Value=Africa/Cairo}]" \
		    --apply-immediately
	
aws rds modify-db-instance \
	    --db-instance-identifier orclro \
	        --option-group-name oracle-ee-19-apex-diegoec-2 \
		    --apply-immediately

--It works



aws rds remove-option-from-option-group \
	    --option-group-name oracle-ee-19-apex-diegoec \
	        --options Timezone \
		    --apply-immediately
	
	


aws rds remove-option-from-option-group \
	    --option-group-name oracle-ee-cdb-21-apex-diegoec \
	        --options Timezone \
		    --apply-immediately
