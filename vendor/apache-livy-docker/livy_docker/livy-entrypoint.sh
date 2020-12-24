#!/bin/bash

# copy hadoop conf and rewrite yarn-site.xml to disable yarn.timeline-service.enabled
# due to jersey-core/client.jar dependency problem

mkdir -p $HADOOP_CONF_DIR
cp $HADOOP_CONF_DIR_ORIGIN/* $HADOOP_CONF_DIR/
xmlstarlet ed --inplace -u "//*/name[text()='yarn.timeline-service.enabled']/../value" -v false $HADOOP_CONF_DIR/yarn-site.xml

/usr/local/livy/bin/livy-server
