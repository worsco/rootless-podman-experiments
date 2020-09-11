
# Testing images "ubi7" vs "ubi7-minimal" and .dockerignore

## ubi7 image

## Open Firewall

I have a firewalld running, open ports.

```/bin/bash
sudo firewall-cmd --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --add-port=8081/tcp
sudo firewall-cmd --permanent --add-port=8081/tcp
```

## Build first image

```/bin/bash
podman build -f Dockerfile.ubi7 -t php-hello-ubi7 .
```

## Excute the container

```/bin/bash
podman run --name=php-hello-ubi7 -dt -p 8080:8080 php-hello-ubi7
```

## Retrieve the default index file

```/bin/bash
curl http://localhost:8080/
```

## Test to see if .dockerignore file works

These should NOT return content (should be not found), if it does -- then the
.dockerignore file is not being honored.

```/bin/bash
curl http://localhost:8080/ignorethese.html
curl http://localhost:8080/ignorethese-01.html
curl http://localhost:8080/ignorethese-02.html
curl http://localhost:8080/ignorethese-03.html
curl http://localhost:8080/ignorethese-04.html
```

## Examine the file system

```/bin/bash
podman exec php-hello-ubi7 ls /opt/rh/httpd24/root/var/www/html
```

## Stop and Remove the container

```/bin/bash
podman stop -l ; podman rm -l
```

---

## Build

```/bin/bash
podman build -f Dockerfile.ubi7-minimal -t php-hello-ubi7-minimal .
```

## Run

```/bin/bash
podman run -dt -p 8081:8080 php-hello-ubi7-minimal
```

## Test default index page

```/bin/bash
curl http://localhost:8081/
```
## Test to see if .dockerignore file works

These should NOT return content (should be not found), if it does -- then the
.dockerignore file is not being honored.

```/bin/bash
curl http://localhost:8080/ignorethese.html
curl http://localhost:8080/ignorethese-01.html
curl http://localhost:8080/ignorethese-02.html
curl http://localhost:8080/ignorethese-03.html
curl http://localhost:8080/ignorethese-04.html
```

## Stop and Remove
podman stop -l ; podman rm -l

