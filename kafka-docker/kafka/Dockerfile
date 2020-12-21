ARG BASE_IMAGE=adoptopenjdk/openjdk11:jre11u-debianslim-nightly
FROM ${BASE_IMAGE} AS builder

RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    curl \
    wget \
    jq \
    gpg \
    gpg-agent \
    && rm -rf /var/lib/apt/lists/*

ARG KAFKA_VERSION=2.6.0
ARG KAFKA_SCALA_VERSION=2.12
ENV KAFKA_VERSION=${KAFKA_VERSION} \
    KAFKA_SCALA_VERSION=${KAFKA_SCALA_VERSION} \
    KAFKA_HOME=/opt/kafka

COPY get-kafka.sh versions.sh /tmp/
RUN chmod a+x /tmp/*.sh \
    && /tmp/get-kafka.sh

FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG KAFKA_VERSION=2.6.0
ARG KAFKA_SCALA_VERSION=2.12
ENV KAFKA_VERSION=${KAFKA_VERSION} \
    KAFKA_SCALA_VERSION=${KAFKA_SCALA_VERSION} \
    KAFKA_HOME=/opt/kafka \
    PATH=${PATH}:${KAFKA_HOME}/bin

COPY --from=builder /kafka.tar.gz /tmp/kafka.tar.gz
RUN tar xfz /tmp/kafka.tar.gz -C /opt \
    && rm /tmp/kafka.tar.gz \
    && ln -s /opt/kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}

COPY start-kafka.sh /usr/bin
RUN chmod a+x /usr/bin/start-kafka.sh

VOLUME ["/kafka"]
CMD ["/bin/bash", "/usr/bin/start-kafka.sh"]