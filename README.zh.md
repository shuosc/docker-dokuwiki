# Dokuwiki 容器化 V3

[English](README.md) | 中文简体

## 简介

本镜像是基于 `php:7.4-apache` 镜像进行构建，采用预安装的方式呈现。使用该镜像无须做任何安装操作即可开始 Dokuwiki 之旅。

本镜像还提供了对二级目录部署方式、LDAP 认证方式的支持，可以快速与团队内部已有的站点、认证方式集成使用。

## 特性

- 支持二级目录部署
- 支持 LDAP 认证集成
- 全架构支持（包含 amd64、i386、arm64 等 8 种架构）
- 用户真实 IP 显示
- 日志可持久化

## 如何获取

这里提供了三种方式获取镜像：

- **第一种**，使用命令 `docker pull shuosc/dokuwiki` 从 Docker Hub（美国） 拉取。
- **第二种**，使用命令 `docker pull registry.cn-shanghai.aliyuncs.com/shuosc/dokuwiki` 从阿里云容器镜像服务（上海）拉取。
- **第三种**，使用命令 `docker build . -t shuosc/dokuwiki` 从 `Dockerfile` 手动构建。

## 用法

### Docker run

#### 最简配置

```bash
docker run -ti -d run --name dokuwiki shuosc/dokuwiki:latest
```

#### 完整配置

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

访问 `http://localhost/wiki/` 即可，默认管理员用户名和密码均为 `admin`。**出于安全考虑，请务必在登录后修改默认密码**。

## 提示

- 二级子目录是通过变量 `DIR` 设定的，如果不想使用子目录则无需设置该变量。
- Dokuwiki 的正式版本一般会隔比较长的时间，所以本镜像会同时提供正式版本和开发版本，并且默认 `latest` 标签是最新开发版本。
- 本镜像目前已支持全 CPU 架构，无论是一般的服务器还是树莓派，均可使用。

## 开发日志

- 2018/05/03，构建运行 Dokuwiki 所需的完整环境镜像（不含 Dokuwiki 代码）。
- 2021/04/24，升级基础镜像为 Ubuntu Focal (20.04)、PHP 版本为 7.4，增加 `vendor` 目录禁止访问限制。
- 2022/07/02，升级基础镜像为 php:7.4-apache，完善二级子目录支持，增加 LDAP 认证支持、全架构镜像支持、用户真实 IP 及日志持久化。

## 致谢

感谢 Dockerhub 和 ACR 为我们提供了镜像托管，感谢 Github 为我们提供了代码托管和 CI/CD 环境，感谢 Dokuwiki 团队开发了优雅的 Dokuwiki。