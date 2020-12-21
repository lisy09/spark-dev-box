ARG JAVA_VERSION=8
FROM openjdk:${JAVA_VERSION}-jdk-slim-buster

LABEL maintainer="lisy09.thu@gmail.com"

RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    curl \
    make \
    gnupg

# install scala-sbt based on https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    sbt \
    && rm -rf /var/lib/apt/lists/*

# Env
ARG SCALA_VERSION
ENV SCALA_VERSION ${SCALA_VERSION}
ARG SBT_VERSION
ENV SBT_VERSION ${SBT_VERSION}

WORKDIR /root/workspace

# prepare sbt (warming cache)
RUN sbt sbtVersion \
    && mkdir -p project \
    && echo "scalaVersion := \"${SCALA_VERSION}\"" > build.sbt \
    && echo "sbt.version=${SBT_VERSION}" > project/build.properties \
    && echo "case object Temp" > Temp.scala \
    && sbt compile \
    && rm -r project target \
    && rm build.sbt Temp.scala

SHELL ["/bin/bash", "-c"] 