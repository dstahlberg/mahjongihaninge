#!/bin/bash

TERRAFORM=/'usr/bin/terraform'

SECRETS_FILE='/home/dan/lin.tfvars'

export TERRAFORM_DIR="$(pwd)/tf"

# Set environment variable for IP-address to be used to remove SSH fingerprint later
export MIHHOSTIP=$($TERRAFORM -chdir=$TERRAFORM_DIR output -raw mihhost_ip)

$TERRAFORM -chdir=$TERRAFORM_DIR destroy -var-file=$SECRETS_FILE

# remove fingerprint of server
ssh-keygen -R "$MIHHOSTIP"
