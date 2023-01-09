FROM rockylinux:8
ENV container=docker

# Install systemd -- See https://hub.docker.com/_/centos/
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

## prep libwandio repo
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandio/cfg/setup/bash.rpm.sh' | bash


# Install requirements.
RUN yum -y install rpm dnf-plugins-core \
 && yum -y update \
 && dnf -y groupinstall "Development Tools" \
 && yum -y config-manager --set-enabled powertools \
 && yum -y install \
      epel-release \
      initscripts \
      sudo \
      wget \
      which \
      git-core \
      librdkafka-devel \ 
      libwandio1 \
      libwandio1-devel \
      libwandio1-tools \
      automake \
      hostname \
&& yum -y clean all

# Build libwandio.
RUN cd /tmp && \
    wget https://github.com/CAIDA/libbgpstream/releases/download/v2.2.0/libbgpstream-2.2.0.tar.gz && \
    tar -xf libbgpstream-2.2.0.tar.gz && \
    cd libbgpstream-2.2.0 && \
    autoreconf -fvi . && \
    sh ./configure && \
    make install 
