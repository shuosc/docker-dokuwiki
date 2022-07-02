# Dokuwiki Dockerlize v3

English | [中文简体](README.zh.md)

## Description

It is based on `php:7.4-apache` and has pre-installed Dokuwiki. You need do nothing else to start your Dokuwiki journey with our docker image.

We also provide the supports for subdirectory and LDAP auth way, which help you to integrate with existed sites and LDAP service.

## Features

- Support subdirectory
- Support LDAP
- Support all CPU archs (including amd64, i386, arm64, s390x and so on)
- Support user real ip
- Support log files persistence

## How to get it

- **First way** is `docker pull shuosc/dokuwiki` from Docker Hub in US.
- **Second way** is `docker pull registry.cn-shanghai.aliyuncs.com/shuosc/dokuwiki` from Aliyun Container Registry (ACR) in China.
- **Third way** is `docker build . -t shuosc/dokuwiki` from `Dockerfile`.

## Usage

### Docker run

#### The simplest way

```bash
docker run -ti -d run --name dokuwiki shuosc/dokuwiki:latest
```

#### The completed way

```bash
docker run -ti -d run --name dokuwiki -p 80:80 -v data:opt/data -v log:/var/log/apache2 -e DIR=wiki shuosc/dokuwiki:latest
```

### Docker-compose

```yaml
# docker-compose.yml

version: '3'
services:
  dokuwiki:
    image: shuosc/dokuwiki:latest
    ports:
      - 80:80
    environment:
      - DIR=wiki
    volumes:
      - ./data:/opt/data
      - ./log:/var/log/apache2
```

```bash
docker-compose up -d
```

After running the container with the above, you can refer to `http://localhost/wiki` to check it.

The default admin username & password are both `admin`. **Considering the security, please modify it while you are logged in**.

## Tips

- The subdirectory can be set in `docker-compose.yml`, and `/wiki` is the default. If you don't want to use subdirectory, you can just ignore it.
- Because Dokuwiki stable version generally needs much time (serveral years), we provide both the stable version and development version. Moreover, the `latest` tag of image is the latest development version.
- Now we have supported all CPU archs. Whether it is a common server or Raspberry Pi, it will work.

## Changelogs

- 2018/05/03, Build the essential environments for running Dokuwiki (not including Dokuwiki source code). 
- 2021/04/24, Upgrade the base image to Ubuntu Focal (20.04) & the PHP version to 7.4. Add vendor directory deny rules.
- 2022/07/02, Upgrade the base image to php:7.4-apache. Fix some bugs for subdirectory. Add LDAP auth way, all cpu archs, user real ip and log files persistentce.

## Acknowledges

Thanks DockerHub and ACR for providing free Docker image resitry. Thanks Github for providing source code hosting and CI/CD tools. Thanks Dokuwiki for developing so elegant Dokuwiki.