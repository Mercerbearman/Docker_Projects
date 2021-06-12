# CentOS readme

## Build Base Image

This will build the development image that we will use for test purposes.

```sh
docker build -t centos_base:5.11 -f Dockerfile.Base .
```

## Build CLIP development image

```sh
docker build -t centos_dev_clip:5.11 .
```

## Run image interactively

This allows us to log in and poke around the file system to see what the state of it is.

```sh
docker run -it centos_dev_clip:5.11
```

## Run clip  

```sh
docker run --sysctl fs.mqueue.msg_max=300 centos_dev_clip:5.11
```

The flag:

```sh
--sysctl fs.mqueue.msg_max=300
```

allows us to change the number of message queue messages that are allowed per queue.  CLIP requires this when running as it passes all messages via POSIX message queues.

See [Docker Kernel Params](https://docs.docker.com/engine/reference/commandline/run/#configure-namespaced-kernel-parameters-sysctls-at-runtime) for more information.

## To Save a Docker image

```sh
docker save centos_base:5.11 | gzip > centos_base_5.11.tar.gz
docker save centos_dev_clip:5.11 | gzip > centos_dev_clip_5.11.tar.gz
```

## To Load a Docker image

```sh
docker load -i centos_base_5.11.tar.gz
docker load -i centos_dev_clip_5.11.tar.gz
```
