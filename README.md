# ESP IDF Docker Image

[<img src="https://img.shields.io/badge/dockerhub-download-blue.svg?logo=docker">](https://hub.docker.com/repository/docker/avan1235/espressif-idf-camera)
![build status](https://img.shields.io/github/actions/workflow/status/avan1235/esp-idf-docker/docker-image.yml?branch=master)

This repository has the definition for the environment with [ESP IDF](https://github.com/espressif/esp-idf)
with the following modules included:

- [esp32-camera](https://github.com/espressif/esp32-camera)

## Installation

You can pull the image with

```shell
docker pull avan1235/espressif-idf-camera:latest
```

and then use the [start.sh](./start.sh) script to start the image running in the background with

```shell
./start.sh
```

which will run the image and mount your `/dev/ttyUSB0` device for it.

You need to manually adjust the script if your connected device location is other than `/dev/ttyUSB0`.

You can start the image without a device with

```shell
./start.sh --no-device
```

## Usage

### Shell

You can login to created image using `ssh` with

```shell
ssh root@localhost -p 2222
```

where the password is `password` (defined in [Dockerfile](docker/Dockerfile))

### CLion IDE

From CLion you can configure [remote toolchain](https://www.jetbrains.com/help/clion/remote-projects-support.html)
and use the same data to login to the image within IDE.

https://github.com/avan1235/esp-idf-docker/assets/11787040/5edeb36d-051b-442a-a7f5-97c71aff37f6
