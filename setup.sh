#!/bin/bash
FILE_PATH=$(realpath $0)
SCRIPTS_PATH=$(dirname $FILE_PATH)
source $SCRIPTS_PATH/aws/ssm.sh