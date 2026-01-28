#!/bin/bash

set -euo pipefail

check_awscli() {

	if ! command -v aws &> /dev/null; then
		echo "awscli is not installed" >&2
		exit 1
		# Code to install awscli
	else 
		echo "awscli is installed"
	fi
}

create_ec2() {
	local ami_id="$1"
	local instance_type="$2"
    	local key_name="$3"
    	local subnet_id="$4"
    	local security_group_ids="$5"
    	local instance_name="$6"

    # Run AWS CLI command to create EC2 instance
    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name" \
        --subnet-id "$subnet_id" \
        --security-group-ids "$security_group_ids" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
        --query 'Instances[0].InstanceId' \
        --output text
    )
	if [[ -z "$instance_id" ]]; then
		echo "Failed to create instance"
		exit 1
	else
		while true; do
			state=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].State.Name' --output text)
			if [[ "$state" == "running" ]]; then
				break
			fi
			sleep 10
		done
	fi 
}

main() {
check_awscli

	AMI_ID=""
    	INSTANCE_TYPE="t2.micro"
    	KEY_NAME=""
 	SUBNET_ID=""
 	SECURITY_GROUP_IDS=""  # Add your security group IDs separated by space
    	INSTANCE_NAME="Shell-Script-EC2-Demo"

	create_ec2 "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME"
}
main "$@"
