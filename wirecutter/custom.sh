RED='\033[0;31m'
NC='\033[0m'

function minotaur() {
	if [ "dir" = "$1" ]; then
		cd $HOME/Repos/minotaur
	elif [ "up" = "$1" ]; then
		minotaur dir
		yarn machine:start
		yarn compose up -d
		cd -
	elif [ "down" = "$1" ]; then
		minotaur dir
		yarn compose down
		yarn machine:stop
		cd -
	else
		echo "Undefined command. Try:"
		echo "\t dir => enter Minotaur directory"
		echo "\t up => start Minotaur environment"
		echo "\t down => stop Minotaur environment"
	fi
}

function siren() {
	if [ "dir" = "$1" ]; then
		cd $HOME/Repos/siren
	elif [ "up" = "$1" ]; then
		siren dir
		yarn start
	else
		echo "Undefined command. Try:"
		echo "\t dir => enter Siren directory"
		echo "\t up => start Siren environment"
	fi
}

function phoenix() {
	if [ "dir" = "$1" ]; then
		cd $HOME/Repos/phoenix
	elif [ "up" = "$1" ]; then
		phoenix dir
		vagrant up
		cd -
	elif [ "down" = "$1" ]; then
		phoenix dir
		vagrant halt
		cd -
	else
		echo "Undefined command. Try:"
		echo "\t dir => enter Phoenix directory"
		echo "\t up => start Phoenix environment"
		echo "\t down => stop Phoenix environment"
	fi
}
