# ------------------------------------------------------------------------------
# File       : orcl_wallet.sh
# Purpose    : Oracle administration helper: orcl wallet.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./orcl_wallet.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
#Crear wallet
orapki wallet create -wallet wallet_location [-pwd password]

#  create an auto login wallet (cwallet.sso) that does not need a password to open
orapki wallet create -wallet . -auto_login_only

#Modificar credenciales

mkstore -wrl $PWD -listCredential
mkstore -wrl $PWD -modifyCredential rdp4-scan4/csibsp_bkup1.dtvpan.com sys VriCCxMC2pXKuD
mkstore -wrl $PWD -createCredential cnibsr sys pdntem19


#  Add the two certificates to the wallet
orapki wallet add -wallet . -trusted_cert -cert AmazonRootCA1.pem -auto_login_only
orapki wallet add -wallet . -trusted_cert -cert SFSRootCAG2.pem -auto_login_only
