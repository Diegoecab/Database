# ------------------------------------------------------------------------------
# File       : cli.current_profile.sh
# Purpose    : aws cloud/cli helper: cli.current profile.
# Engine     : aws
# Category   : cloud/cli
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./cli.current_profile.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws sts get-caller-identity
aws configure list
