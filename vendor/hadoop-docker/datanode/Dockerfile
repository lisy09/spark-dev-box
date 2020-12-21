ARG BASE_IMAGE=hadoop-base:1.0.0-hadoop3.3.0-java8
FROM ${BASE_IMAGE}

LABEL maintainer="lisy09.thu@gmail.com"

ARG DATANODE_PORT_INTERNAL=9870
ENV DATANODE_PORT_INTERNAL=${DATANODE_PORT_INTERNAL}
ARG HDFS_CONF_dfs_datanode_data_dir=/hadoop/dfs/data

HEALTHCHECK --interval=30s --retries=3 --timeout=3s \
    CMD curl -f http://localhost:${DATANODE_PORT_INTERNAL}/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file://${HDFS_CONF_dfs_datanode_data_dir}
RUN mkdir -p ${HDFS_CONF_dfs_datanode_data_dir}
VOLUME ${HDFS_CONF_dfs_datanode_data_dir}

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE ${DATANODE_PORT_INTERNAL}

CMD ["/run.sh"]