#!/bin/zsh
FILE_PATH=$(realpath $0)
SCRIPTS_PATH=$(dirname $FILE_PATH)
source $SCRIPTS_PATH/aws/ssm.sh
source $SCRIPTS_PATH/git/git.sh
source $SCRIPTS_PATH/wirecutter/custom.sh
source $SCRIPTS_PATH/wirecutter/yeti.sh
source $SCRIPTS_PATH/wirecutter/phoenix.sh
