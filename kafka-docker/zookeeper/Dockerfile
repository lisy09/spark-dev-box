ARG BASE_IMAGE=adoptopenjdk/openjdk11:jre11u-debianslim-nightly
FROM ${BASE_IMAGE} AS builder

RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    curl \
    wget \
    jq \
    gpg \
    gpg-agent \
    && rm -rf /var/lib/apt/lists/*

ARG ZOOKEEPER_VERSION=3.6.2
ENV ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION}

COPY get-zookeeper.sh /tmp
RUN /tmp/get-zookeeper.sh

FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG ZOOKEEPER_VERSION=3.6.2
ENV ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION}
ENV ZK_HOME /opt/zookeeper

COPY --from=builder /zookeeper.tar.gz /tmp/apache-zookeeper-${ZOOKEEPER_VERSION}.tar.gz
RUN mkdir -p /opt \
    && tar -xzf /tmp/apache-zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /opt \
    && ln -s /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin $ZK_HOME \
    && mv $ZK_HOME/conf/zoo_sample.cfg $ZK_HOME/conf/zoo.cfg \
    && sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg; mkdir $ZK_HOME/data

COPY start-zookeeper.sh /usr/bin

ARG ZOOKEEPER_CLIENT_PORT=2181
ARG ZOOKEEPER_FOLLOWER_PORT=2888
ARG ZOOKEEPER_ELECTION_PORT=3888
EXPOSE ${ZOOKEEPER_CLIENT_PORT} ${ZOOKEEPER_FOLLOWER_PORT} ${ZOOKEEPER_ELECTION_PORT} 

VOLUME ["/opt/zookeeper-${ZOOKEEPER_VERSION}-bin/conf", "/opt/zookeeper-${ZOOKEEPER_VERSION}-bin/data"]

CMD ["/bin/sh", "/usr/bin/start-zookeeper.sh"]