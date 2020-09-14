#!/bin/bash

MYFILES="Jenkinsfile-UC3-3 Jenkinsfile-UC3-2 Dockerfile-UC3-3 Dockerfile-UC3-2 \
Jenkinsfile-rebar Jenkinsfile-core Jenkinsfile-aws-nexus Dockerfile-prod"

for FILENAME in $MYFILES
do
echo "$FILENAME file contents" > $FILENAME
done
