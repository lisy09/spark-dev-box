ARG BASE_IMAGE=hadoop-base:1.0.0-hadoop3.3.0-java8
FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG HISTORYSERVER_PORT_INTERNAL=8188
ARG YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline

ENV HISTORYSERVER_PORT_INTERNAL=${HISTORYSERVER_PORT_INTERNAL}

HEALTHCHECK --interval=30s --retries=3 --timeout=3s \
    CMD curl -f http://localhost:${HISTORYSERVER_PORT_INTERNAL}/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=${YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path}
RUN mkdir -p ${YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path}
VOLUME ${YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path}

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE ${HISTORYSERVER_PORT_INTERNAL}

CMD ["/run.sh"]