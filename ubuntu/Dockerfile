FROM ubuntu:20.04

LABEL maintainer "zhonger <zhonger@live.cn>"

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates && \
    mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/sources.list
RUN apt-get update

#设置时区
RUN apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

#安装vim及升级
RUN apt-get install -y apt-utils vim language-pack-zh-hans && \
    apt-get upgrade -y && \
    apt-get clean