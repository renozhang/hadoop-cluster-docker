# Creates a base ubuntu image with serf and dnsmasq
# FROM ubuntu:15.04
FROM sequenceiq/pam:centos-6.5

MAINTAINER KiwenLau <kiwenlau@gmail.com>

# install basic tools
RUN yum install -y curl which tar sudo openssh-server openssh-clients rsync dnsmasq
RUN yum update -y libselinux

# dnsmasq configuration
ADD dnsmasq/* /etc/

# install serf
COPY resources/serf-0.6.4_linux_amd64.zip serf.zip
RUN unzip serf.zip -d /bin && \
rm serf.zip

# configure serf
ENV SERF_CONFIG_DIR /etc/serf
ADD serf/* $SERF_CONFIG_DIR/
ADD handlers $SERF_CONFIG_DIR/handlers
RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh
