#!/bin/bash -e

DIRNAME=$(dirname "$0")

containerID=$(docker run --detach nixm0nk3y/docker-bareos-arm)
docker cp "$containerID:/tmp/*.deb" "$DIRNAME"
sleep 1
docker rm "$containerID"
