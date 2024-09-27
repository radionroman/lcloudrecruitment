#!/bin/bash

METADATA_URL="http://169.254.169.254/latest/meta-data"

printf "instance-id:"
curl -s $METADATA_URL/instance-id 
printf "\npublic-ip:"
curl -s $METADATA_URL/public-ipv4
printf "\nprivate_ip:"
curl -s $METADATA_URL/local-ipv4
printf "\n"
curl -s $METADATA_URL/security-groups
printf "\n"
