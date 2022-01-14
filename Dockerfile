FROM centos:centos7

ARG UID=1000
ARG USER=docker
ARG PASS=docker

RUN yum -y update && yum clean all && \
    yum -y install epel-release sudo && \
    yum install -y --enablerepo=epel xrdp && \
    useradd -m -u ${UID} ${USER} && \
    echo ${USER}:${PASS} | chpasswd && \
    echo "$USER ALL=(ALL) ALL" >> /etc/sudoers && \
    yum -y groupinstall "GNOME Desktop" && \
    systemctl enable xrdp

COPY ./public.xml /etc/firewalld/zones/