#!/bin/bash
# Custom functions to interact with AWS

function ssm() {
	if ! command -v aws &> /dev/null; then
		echo
		echo 'This command requires the AWS CLI package to be installed.'
		return 1
	fi

	INSTANCE="$1"
	shift

	while [[ $# > 0 ]]
	do
		case "$1" in
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
	fi

	if [ -z "$REGION" ]; then
		REGION='us-east-1'
	fi

	if [ -z "$PROFILE" ]; then
		PROFILE='default'
	fi

	echo
	echo "Logging into AWS with profile $PROFILE..."
	aws sso login --profile $PROFILE
	export AWS_PROFILE="$PROFILE"
	echo "...done."

	echo
	echo "Connecting to Instance $INSTANCE in the $REGION region..."
	aws ssm start-session --target $INSTANCE --region $REGION --profile $PROFILE
	echo "...done."
}

function usage() {
	echo
	echo 'Example usage: ssm <instance id> [--region <region>] [--profile <profile>]'
	echo '<instance id> Required. Instance ID obtained from EC2 Dashboard. Ex. i-XXXXXXXXXXXXXXXX'
	echo '<region> Optional. Specify the AWS region to connect to. Defaults to us-east-1'
	echo '<profile> Optional. Specify the AWS SSO profile to use. Defaults to default'
}
