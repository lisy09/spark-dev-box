ARG JAVA_VERSION=8
FROM openjdk:${JAVA_VERSION}-jdk-slim-buster

LABEL maintainer="lisy09.thu@gmail.com"

ARG HADOOP_VERSION=3.3.0
ARG HADOOP_URL=https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    net-tools \
    curl \
    netcat \
    gnupg \
    libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/local/openjdk-8/

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION ${HADOOP_VERSION}

RUN set -x \
    && curl -fSL ${HADOOP_URL} -o /tmp/hadoop.tar.gz \
    && curl -fSL ${HADOOP_URL}.asc -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-${HADOOP_VERSION}/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-${HADOOP_VERSION}/logs
RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV USER=root
ENV PATH ${HADOOP_HOME}/bin/:$PATH

ENTRYPOINT [ "/bin/bash" ]