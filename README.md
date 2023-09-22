# rsyslog Docker Image

A straightforward rsyslog image that communicates exclusively via a Unix socket.

## Overview

This Docker image is designed to offer a lightweight rsyslog service that communicates over a Unix socket. Instead of employing traditional network protocols, this setup facilitates central logging through the Unix socket, allowing for efficient communication between the host and container on the same system.

## Usage

The configuration and setup are defined in the `docker-compose.yaml` file:

- **Image**: It uses the `rsyslog:latest` image, built on a lightweight Alpine base.
- **Configuration**: The `rsyslog` package is installed, the `imklog` module's loading is disabled, and the `imuxsock` module is set up for communication via Unix sockets.
- **Volumes**: Two volumes are employed, one for log files and the other for the Unix socket.

```yaml
services:
  syslog:
    image: rsyslog:latest
    build:
      context: .
    hostname: rsyslog
    container_name: rsyslog
    environment:
    - TZ=Europe/Berlin
    volumes:
    - ./volumes/syslog_vol:/var/log
    - ./volumes/syslog_socket_vol:/run/syslog

