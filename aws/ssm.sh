#!/bin/bash
# Custom functions to interact with AWS

function ssm() {
	if ! command -v aws &> /dev/null; then
		echo
		echo 'This command requires the AWS CLI package to be installed.'
		return 1
	fi

	while [[ $# > 0 ]]
	do
		case "$1" in
			--instance)
				INSTANCE="$2"
				shift
				;;

			--region)
				REGION="$2"
				shift
				;;

			--profile)
				PROFILE="$2"
				shift
				;;

			--help|*)
				usage
				return 1
				;;
		esac
		shift
	done

	if [ -z "$INSTANCE" ]; then
		echo
		echo 'No Instance ID specified.'
		usage
		return 1
	elif [ -z "$REGION" ]; then
		echo
		echo 'No region specified. Defaulting to us-east-1.'
		REGION='us-east-1'
	elif [ -z "$PROFILE" ]; then
		echo
		echo 'No profile specified. Defaulting to default.'
		PROFILE='default'
	fi

	echo
	echo "Logging into AWS..."
	aws sso login --profile $PROFILE
	export AWS_PROFILE="$PROFILE"

	echo
	echo "Connecting to Instance $INSTANCE in the $REGION region..."
	aws ssm start-session --target $INSTANCE --region $REGION
}

function usage() {
	echo
	echo 'Example usage: ssm --instance <instance id> [--region <region>]'
	echo '<instance id> Required. Instance ID obtained from EC2 Dashboard. Ex. i-XXXXXXXXXXXXXXXX'
	echo '<region> Optional. Specify the AWS region to connect to. Defaults to us-east-1'
	echo '<profile> Optional. Specify the AWS SSO profile to use. Defaults to default'
}
