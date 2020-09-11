#!/bin/bash

FILEDIR=/opt/rh/httpd24/root/var/www/html
MYNAME=php-hello-ubi7
MYDOCKERFILE=Dockerfile.ubi7
MYDIVIDER='================'
#BUILDERCMD='buildah bud'
BUILDERCMD="podman build"

echo -e "$MYDIVIDER\nS T A R T\n$MYDIVIDER\n\n"

podman stop $MYNAME ; podman rm $MYNAME

$BUILDERCMD -f $MYDOCKERFILE -t $MYNAME . && \
podman run --name=$MYNAME -dt -p 8080:8080 $MYNAME && \
sleep 7 && \
echo -e "Listing files in $FILEDIR\n$MYDIVIDER\n" && \
podman exec $MYNAME ls $FILEDIR && \
echo -e "$MYDIVIDER\n\nContents of local .dockerignore\n$MYDIVIDER\n" && \
cat .dockerignore  && \
echo -e "\nSTOPPING AND REMOVING $MYNAME\n" && \
podman stop $MYNAME ; podman rm $MYNAME

echo -e "$MYDIVIDER\n\nEND-OF-JOB\n" 

