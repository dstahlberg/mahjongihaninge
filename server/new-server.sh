#!/bin/bash

TERRAFORM=/'usr/bin/terraform'
ANSIBLE_PLAYBOOK='/usr/bin/ansible-playbook'

SECRETS_FILE='/home/dan/lin.tfvars'

export TERRAFORM_DIR="$(pwd)/tf"
export ANSIBLE_DIR="$(pwd)/ansible"
export ANSIBLE_CONFIG="$ANSIBLE_DIR/ansible.cfg"

export fast_process=false  # if true: skip wait, package update and reboot
configure_only=false  # just run Ansible scripts
while getopts "fhc" OPTION; do
  case $OPTION in
    f) fast_process=true
       ;;
    c) configure_only=true
       ;;
    h) 
       echo "Usage: $(basename $0) [-f] [-c] [-h]"
       echo "  -f  do a fast process - skips sleep, package update and reboot steps"
       echo "  -c  only run the Ansible configuration scripts"
       echo "  -h  print this helptext"
       exit 1
       ;;
  esac
done

if ! $configure_only; then
    $TERRAFORM -chdir=$TERRAFORM_DIR init
    $TERRAFORM -chdir=$TERRAFORM_DIR apply -auto-approve -var-file=$SECRETS_FILE
fi

if ! $fast_process; then
    echo "Sleeping..."
    sleep 30 # wait for server to awaken
fi

$ANSIBLE_PLAYBOOK --inventory-file $ANSIBLE_DIR/inventory.yml $ANSIBLE_DIR/main.yml
