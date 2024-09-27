#!/bin/bash

METADATA_URL="http://169.254.169.254/latest/meta-data"
OUTPUT_FILE="/tmp/instance_metadata.txt"
S3_BUCKET="s3://applicant-task/r2d2/"

INSTANCE_ID=$(curl -s $METADATA_URL/instance-id)
PUBLIC_IP=$(curl -s $METADATA_URL/public-ipv4)
PRIVATE_IP=$(curl -s $METADATA_URL/local-ipv4)
SECURITY_GROUPS=$(curl -s $METADATA_URL/security-groups)

OS_NAME=$(grep "^NAME=" /etc/os-release | cut -d'=' -f2 | tr -d '"')
OS_VERSION=$(grep "^VERSION=" /etc/os-release | cut -d'=' -f2 | tr -d '"')

USERS=$(grep -E '(/bin/bash|/bin/sh)' /etc/passwd | cut -d':' -f1)

cat <<EOF > $OUTPUT_FILE
Instance ID: $INSTANCE_ID
Public IP: $PUBLIC_IP
Private IP: $PRIVATE_IP
Security Groups: $SECURITY_GROUPS
OS Name: $OS_NAME
OS Version: $OS_VERSION
Users: $(echo $USERS | tr ' ' ', ')
EOF

aws s3 cp $OUTPUT_FILE $S3_BUCKET

echo "Instance information collected and saved to s3 bucket."