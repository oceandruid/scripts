#!/bin/zsh

bold=$(tput bold)
normal=$(tput sgr0)

YETI_DOCKER_NAME="wirecutter_yeti-php " # the space at the end of the string is intentional

function getDockerYetiId() {
	YETI_PHP_DOCKER_ID=$(docker ps | grep -e $YETI_DOCKER_NAME | awk '{print$1;}')

	if [[ -z "$YETI_PHP_DOCKER_ID" ]]; then
		echo "Could not find a Docker container named $YETI_DOCKER_NAME"
		exit 1
	fi

	echo $YETI_PHP_DOCKER_ID
}

function runYetiPhpcs() {
	YETI_PHP_DOCKER_ID=$(getDockerYetiId)
	docker exec -i -w /var/www/html/yeti $YETI_PHP_DOCKER_ID bash -c "./vendor/bin/phpcs -n"
}

function runYetiPhpUnit() {
	YETI_PHP_DOCKER_ID=$(getDockerYetiId)
	docker exec -i -w /var/www/html/yeti $YETI_PHP_DOCKER_ID bash -c "./vendor/bin/phpunit"
}

function enterYetiBash() {
	YETI_PHP_DOCKER_ID=$(getDockerYetiId)
	docker exec -it $YETI_PHP_DOCKER_ID /bin/bash
}

function displayHelp() {
	echo "Available Commands:"
	echo "   ${bold}dir:${normal} enter Yeti directory"
	echo "   ${bold}bash:${normal} open a Bash shell in Yeti"
	echo "   ${bold}phpcs:${normal} run PHPCS in Yeti"
	echo "   ${bold}phpunit:${normal} run PHPUnit in Yeti"
}

function yeti() {

	while true; do
		case "$1" in
			dir ) cd $HOME/Sites/yeti; shift; break ;;
			bash ) enterYetiBash; shift; break ;;
			phpcs ) runYetiPhpcs; shift; break ;;
			phpunit ) runYetiPhpUnit; shift; break ;;
			--help ) displayHelp; shift; break ;;
			-h ) displayHelp; shift; break ;;
			-- ) displayHelp; shift; break ;;
			* ) displayHelp; break ;;
		esac
	done
}
