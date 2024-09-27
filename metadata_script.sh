#!/bin/bash

METADATA_URL="http://169.254.169.254/latest/meta-data"
OUTPUT_FILE="/tmp/tmp_metadata.txt"

INSTANCE_ID=$(curl -s $METADATA_URL/instance-id)
PUBLIC_IP=$(curl -s $METADATA_URL/public-ipv4)
PRIVATE_IP=$(curl -s $METADATA_URL/local-ipv4)
SECURITY_GROUPS=$(curl -s $METADATA_URL/security-groups)

cat <<EOF > $OUTPUT_FILE
Instance ID: $INSTANCE_ID
Public IP: $PUBLIC_IP
Private IP: $PRIVATE_IP
Security Groups: $SECURITY_GROUPS
EOF

echo "Instance information collected and saved to a file."