#!/bin/bash
ARG=$1
APP_NAME=hugo

if [ "$DOCKER_ID" == "" ]; then
  DOCKER_ID=tonymackay
fi

if [ "$PASSWORD" == "" ]; then
  PASSWORD=$(cat ~/.docker/password.txt)
fi

if [ "$VERSION" == "" ]; then
  VERSION=$(git describe)
  if [[ $VERSION != v* ]]; then
    VERSION="v0.73.0"
  fi
fi

if [ "$ARG" == "build" ]; then
  echo "build Docker image"
  docker build -t "$DOCKER_ID/$APP_NAME" --build-arg VERSION=$VERSION .
  echo "create tag $VERSION"
  docker tag "$DOCKER_ID/$APP_NAME" "$DOCKER_ID/$APP_NAME:$VERSION"
fi

if [ "$ARG" == "publish" ]; then
  echo "publish Docker image"
  echo "$PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin
  docker push "$DOCKER_ID/$APP_NAME:$VERSION"
fi

if [ "$ARG" == "test" ]; then
  echo $DOCKER_ID
  echo $APP_NAME
  echo $VERSION
fi
