FROM ubuntu:latest

MAINTAINER zhonger <zhonger@live.cn>

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/sources.list
RUN apt-get update

#设置时区
RUN echo y | apt-get install tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

#安装vim及升级
RUN echo y | apt-get install apt-utils vim language-pack-zh-hans
RUN echo y | apt-get upgrade