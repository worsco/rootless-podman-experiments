#!/bin/bash

FILEDIR=/opt/rh/httpd24/root/var/www/html
MYNAME=php-hello-ubi7
MYDOCKERFILE=Dockerfile.ubi7
MYDIVIDER='================'
#BUILDERCMD='buildah bud'
BUILDERCMD="podman build"

echo -ne "$MYDIVIDER\nS T A R T\n$MYDIVIDER\n"

echo -ne "OS RELEASE\n"
cat /etc/redhat-release
echo -ne "$MYDIVIDER\n"

echo -ne "PODMAN VERSION\n"
podman version
echo -ne "$MYDIVIDER\n"

# Stop any containers that are running (they may not be running)
podman stop $MYNAME ; podman rm $MYNAME

$BUILDERCMD -f $MYDOCKERFILE -t $MYNAME . && \
podman run --name=$MYNAME -dt -p 8080:8080 $MYNAME && \
sleep 7 && \
echo -ne "Listing files in $FILEDIR\n$MYDIVIDER\n" && \
podman exec $MYNAME ls $FILEDIR && \
echo -ne "$MYDIVIDER\n\nContents of local .dockerignore\n$MYDIVIDER\n" && \
cat .dockerignore  && \
echo -ne "\nSTOPPING AND REMOVING $MYNAME\n" && \
podman stop $MYNAME ; podman rm $MYNAME

echo -ne "$MYDIVIDER\n\nEND-OF-JOB\n" 


# Could do a "podman run --name=$NAME -it --rm -p 8080:8080 $MYNAME
