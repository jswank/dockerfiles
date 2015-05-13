#!/bin/sh

set -o errexit

docker build --tag jswank/centos-rpm:6 --file Dockerfile.6 .
docker build --tag jswank/centos-rpm:7 --file Dockerfile.7 .
