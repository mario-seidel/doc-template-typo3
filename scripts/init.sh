#!/bin/bash

#load settings
source "$DOC_SETTINGS"

GIT_REPO="$1"
DOC_TYPO3_VERSION=${2:-8}
DOC_DOCKERFILE_TYPO3="./dockerfiles/Dockerfile-typo3"

docker inspect "$DOC_USERNAME"/typo3base:"$DOC_TYPO3_VERSION" &> /dev/null

if [ $? -ne 0 ]; then
	echo "-> start building TYPO3 $DOC_TYPO3_VERSION"
	echo -e "--build-arg hostuser=${HOST_USER}"
	docker build \
	    --build-arg typo3_version=$DOC_TYPO3_VERSION \
	    --force-rm=true \
	    -f "$DOC_DOCKERFILE_TYPO3" \
	    -t "$DOC_USERNAME/typo3base:$DOC_TYPO3_VERSION" .
fi

if [ -z ${GIT_REPO} ]; then
	echo "-> copy composer.json from config/composer.json"
	cp config/composer.json sources/composer.json
	cp config/.gitignore sources/.gitignore
else
	echo "-> init project from $GIT_REPO"
	rm -rf ./sources
	git clone ${GIT_REPO} sources
fi
