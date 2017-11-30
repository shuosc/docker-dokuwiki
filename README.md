# Dokuwiki Dockerlize

## Features

- China Ubuntu Sources mirror
- Multilevel
- Supervisor

## Description

- Based on `ubuntu:latest`, it build from `ubuntu` to `nginx` and `php`. When we add dokuwiki's `nginx conf` and `source code`, the Dokuwiki Dockerlize is done.

- Based on `supervisor`, it keep the `nginx progress` alive in front.

## Usage

- change the volumes in the docker-compose.yml
- `sudo docker-compose up -d`
- browser `http://127.0.0.1:8004`