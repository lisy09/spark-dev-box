ARG BASE_IMAGE=hadoop-base:1.0.0-hadoop3.3.0-java8
FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG NAMENODE_PORT_INTERNAL=9870
ARG HDFS_CONF_dfs_namenode_name_dir=/hadoop/dfs/name
ENV NAMENODE_PORT_INTERNAL=${NAMENODE_PORT_INTERNAL}

HEALTHCHECK --interval=30s --retries=3 --timeout=3s \
    CMD curl -f http://localhost:${NAMENODE_PORT_INTERNAL}/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file://${HDFS_CONF_dfs_namenode_name_dir}
RUN mkdir -p ${HDFS_CONF_dfs_namenode_name_dir}
VOLUME ${HDFS_CONF_dfs_namenode_name_dir}

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE ${NAMENODE_PORT_INTERNAL}

CMD ["/run.sh"]