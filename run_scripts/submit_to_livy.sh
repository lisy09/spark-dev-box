#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

curl -X POST  \
    -H "Content-Type: application/json" \
    -H "X-Requested-By: user" \
	-d '{
        "file":"file:///root/livy-local-files/spark-app.jar",
        "className":"com.lisy09.spark_dev_box.kafka_word_count.Main",
        "args":[
            "--spark.app.name","KafkaWordCountExample",
            "--kafka.brokers", "kafka:9092",
            "--kafka.topics", "test_topic",
            "--kafka.groupId", "test_group",
            "--batch.duration.seconds", "10",
            "--wordcount.update.url", "http://word-count-api:8001/v1/wordcount"
        ],
        "conf":{
            "spark.app.name":"KafkaTest"
        }
    }' \
    http://localhost:8998/batches

set +x