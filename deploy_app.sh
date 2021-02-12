#!/bin/bash
########################################
# Put this on a Server
# run chmod +x deploy_app.sh to make the script executable
# 
# Execute this script:  ./deploy_app.sh ariv3ra/python-circleci-docker:$TAG
# Replace the $TAG with the actual Build Tag you want to deploy
#
########################################

set -e

DOCKER_IMAGE=$1
CONAINER_NAME="test_action"

# Check for arguments
if [[ $# -lt 1 ]] ; then
    echo '[ERROR] You must supply a Docker Image to pull'
    exit 1
fi

echo "Deploying app to Docker Container"

echo "Check for running container & stop it before starting a new one"
#Check for running container & stop it before starting a new one
if [ $(sudo docker inspect -f '{{.State.Running}}' $CONAINER_NAME) = "true" ]; then
    sudo docker stop test_action
fi

echo "Starting app using Docker Image name: $DOCKER_IMAGE"

sudo docker build -t test_action .

sudo docker run -d --rm=true -p 5000:5000  --name test_action $DOCKER_IMAGE

sudo docker ps -a

echo "Remove <none> tag docker images"
sudo docker rmi $(sudo docker images -f "dangling=true" -q)