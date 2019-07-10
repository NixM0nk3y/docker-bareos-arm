#!/bin/bash -ex

DIRNAME=$(dirname "$0")

containerID=$(docker run --detach nixm0nk3y/docker-bareos-arm:latest /bin/sleep 120)
docker cp "$containerID:/tmp/bareos-Release-18.2.6/*.deb" "$DIRNAME"
sleep 1
docker rm "$containerID"
