#!/bin/sh

# Exit script on error
set -e

DOCKER_USERNAME="hagro"
IMAGE_NAME="mssql-server-linux-fts"
REPOSITORY_NAME="mssql-server-linux-fts"
TAG="2019-CU23-ubuntu-20.04"
DOCKERFILE_PATH="."

echo "docker build"
docker build -t $IMAGE_NAME:$TAG $DOCKERFILE_PATH

echo "docker login"
docker login -u $DOCKER_USERNAME

echo "docker tag"
docker tag $IMAGE_NAME:$TAG $DOCKER_USERNAME/$REPOSITORY_NAME:$TAG

echo "docker push"
docker push $DOCKER_USERNAME/$REPOSITORY_NAME:$TAG

echo "push completed"
