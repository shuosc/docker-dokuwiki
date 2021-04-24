# Dokuwiki Dockerlize

## How to get it

- One way is `docker pull shuosc/dokuwiki` from Docker Hub in US.
- Another way is `docker pull daocloud.io/zhonger/dokuwiki` from Daocloud in China.
- The third way is `docker build . -t shuosc/dokuwiki` from `Dockerfile`.

## Features

- China Ubuntu Sources mirror
- Multilevel
- Supervisor
- Subdirectory (2018.05.02 add)

## Description

- Based on `ubuntu:latest`, it build from `ubuntu` to `nginx` and `php`. When we add dokuwiki's `nginx conf` and `source code`, the Dokuwiki Dockerlize is done.

- Based on `supervisor`, it keep the `nginx progress` alive in front.

## Usage

- change the volumes in the `docker-compose.yml`
- `sudo docker-compose up -d`
- browser `http://127.0.0.1:8004/wiki`
- default admin username & password are both `admin`.

## Tips

- The subdirectory can be set in `docker-compose.yml`, and `/wiki` is the default.
- The dokuwiki version can be upgrade to the latter stable if you build the images from `Dockerfile`.
- `v1 version` is incomplete because it don't include the dokuwiki source code. In other words, it is just a run enviroment. As `v2 version`, it including all the need, and it cloud be used as long as you pull the latest image from [Docker Hub](https://hub.docker.com/r/shuosc/dokuwiki).

## ChangeLogs

- 2021/4/24  Upgrade the base image to Ubuntu Focal (20.04) & the PHP version to 7.4. Add vendor directory deny rules.
