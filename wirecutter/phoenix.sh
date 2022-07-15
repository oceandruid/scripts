#!/bin/zsh

bold=$(tput bold)
normal=$(tput sgr0)

PHX_DOCKER_NAME="wirecutter_php74 " # the space at the end of the string is intentional

function getDockerPhoenixId() {
	PHX_DOCKER_ID=$(docker ps | grep -e $PHX_DOCKER_NAME | awk '{print$1;}')

	if [[ -z "$PHX_DOCKER_ID" ]]; then
		echo "Could not find a Docker container named $PHX_DOCKER_NAME"
		exit 1
	fi

	echo $PHX_DOCKER_ID
}

function runPhoenixPhpcs() {
	PHX_DOCKER_ID=$(getDockerPhoenixId)
	docker exec -i -w /var/www/html/phoenix $PHX_DOCKER_ID bash -c "./vendor/bin/phpcs -n"
}

function runPhoenixPhpUnit() {
	PHX_DOCKER_ID=$(getDockerPhoenixId)
	docker exec -i -w /var/www/html/phoenix $PHX_DOCKER_ID bash -c "./vendor/bin/phpunit"
}

function enterPhoenixBash() {
	PHX_DOCKER_ID=$(getDockerPhoenixId)
	docker exec -it $PHX_DOCKER_ID /bin/bash
}

function displayHelp() {
	echo "Available Commands:"
	echo "   ${bold}dir:${normal} enter Phoenix directory"
	echo "   ${bold}bash:${normal} open a Bash shell in Phoenix"
	echo "   ${bold}phpcs:${normal} run PHPCS in Phoenix"
	echo "   ${bold}phpunit:${normal} run PHPUnit in Phoenix"
}

function phoenix() {

	while true; do
		case "$1" in
			dir ) cd $HOME/Sites/phoenix; shift; break ;;
			bash ) enterPhoenixBash; shift; break ;;
			phpcs ) runPhoenixPhpcs; shift; break ;;
			phpunit ) runPhoenixPhpUnit; shift; break ;;
			--help ) displayHelp; shift; break ;;
			-h ) displayHelp; shift; break ;;
			-- ) displayHelp; shift; break ;;
			* ) displayHelp; break ;;
		esac
	done
}
