#!/bin/bash

function gitup() {
	STATUS=$(git status --porcelain)

	echo $STATUS
}

function gmb() {
	BRANCH_NAME="$1"
	git show-ref --verify --quiet refs/heads/$BRANCH_NAME

	if [ $? = 0 ]; then
		echo "Branch ${RED}${BRANCH_NAME}${NC} already exists."
	else
		echo
		echo "${RED}Checking out main branch and cleaning house...${NC}"
		gitup()
		echo "${RED}...done.${NC}"

		echo
		echo "${RED}Creating branch ${BRANCH_NAME}...${NC}"
		git checkout -b $BRANCH_NAME
		echo "${RED}...done.${NC}"

		echo
		echo "${RED}Setting branch upstream...${NC}"
		git push --set-upstream origin $BRANCH_NAME
		echo "${RED}...done.${NC}"
	fi
}
