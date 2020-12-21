ARG JAVA_VERSION=8
FROM openjdk:${JAVA_VERSION}-jdk-slim-buster

LABEL maintainer="lisy09.thu@gmail.com"

ARG PREBUILT_HADOOP=spark-3.0.1-bin-hadoop3.2
ARG SPARK_SRC_URL=https://downloads.apache.org/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz
ARG SPARK_ASC_URL=https://downloads.apache.org/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz.asc
ARG PREBUILT_LIVY=apache-0.7.0-incubating-bin
ARG LIVY_SRC_URL=https://downloads.apache.org/incubator/livy/0.7.0-incubating/apache-livy-0.7.0-incubating-bin.zip
ARG LIVY_ASC_URL=https://downloads.apache.org/incubator/livy/0.7.0-incubating/apache-livy-0.7.0-incubating-bin.zip.asc

RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://dist.apache.org/repos/dist/release/spark/KEYS
RUN gpg --import KEYS

RUN set -x \
    && curl -fSL ${SPARK_SRC_URL} -o /tmp/spark.tar.gz \
    && curl -fSL ${SPARK_ASC_URL} -o /tmp/spark.tar.gz.asc \
    && gpg --verify /tmp/spark.tar.gz.asc \
    && tar zxvf /tmp/spark.tar.gz -C /usr/local --owner root --group root --no-same-owner \
    && rm /tmp/spark.tar.gz*
RUN ln -s /usr/local/${PREBUILT_HADOOP} /usr/local/spark

ENV SPARK_HOME /usr/local/spark
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

RUN curl -O https://downloads.apache.org/incubator/livy/KEYS
RUN gpg --import KEYS

RUN set -x \
    && curl -fSL ${LIVY_SRC_URL} -o /tmp/livy.zip \
    && curl -fSL ${LIVY_ASC_URL} -o /tmp/livy.zip.asc \
    && gpg --verify /tmp/livy.zip.asc \
    && unzip /tmp/livy.zip -d /usr/local \
    && rm /tmp/livy.zip*
RUN ln -s /usr/local/${PREBUILT_LIVY} /usr/local/livy

# Set the Livy logs folder and start the server
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /usr/local/${PREBUILT_LIVY}/logs
CMD ["/usr/local/livy/bin/livy-server"]