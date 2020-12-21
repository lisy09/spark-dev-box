ARG BASE_IMAGE=hadoop-base:1.0.0-hadoop3.3.0-java8
FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG NODEMANAGER_PORT_INTERNAL=8042
ENV NODEMANAGER_PORT_INTERNAL=${NODEMANAGER_PORT_INTERNAL}

HEALTHCHECK --interval=30s --retries=3 --timeout=3s \
    CMD curl -f http://localhost:${NODEMANAGER_PORT_INTERNAL}/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE ${NODEMANAGER_PORT_INTERNAL}

CMD ["/run.sh"]