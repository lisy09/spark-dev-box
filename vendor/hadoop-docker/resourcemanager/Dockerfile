ARG BASE_IMAGE=hadoop-base:1.0.0-hadoop3.3.0-java8
FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG RESOURCEMANAGER_PORT_INTERNAL=8088
ENV RESOURCEMANAGER_PORT_INTERNAL=${RESOURCEMANAGER_PORT_INTERNAL}

HEALTHCHECK --interval=30s --retries=3 --timeout=3s \
    CMD curl -f http://localhost:${RESOURCEMANAGER_PORT_INTERNAL}/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE ${RESOURCEMANAGER_PORT_INTERNAL}

CMD ["/run.sh"]