from fastapi import APIRouter,status, Request
from fastapi.logger import logger as fastapi_logger
from server.core.config import get_config, get_kerberos_config, get_use_kerberos_config
from kafka import KafkaProducer, KafkaConsumer
from pydantic import BaseModel

import logging
import os

router = APIRouter(
    prefix="/data",
    tags=["data"],
)

class KafkaData(BaseModel):
    msg: str

@router.post("/kafka",status_code=status.HTTP_201_CREATED)
async def send_kafka_data(data:KafkaData):
    """
    Send single line kafka data
    """
    kafkaConfig = get_config()["kafka"]
    if get_use_kerberos_config():
        krb5Config = get_kerberos_config()
        producer = KafkaProducer(bootstrap_servers=kafkaConfig["brokers"],
            security_protocol='SASL_PLAINTEXT',
            sasl_mechanism='GSSAPI',
            sasl_kerberos_domain_name=krb5Config["domain"],
            sasl_kerberos_service_name=krb5Config["kafkaServiceName"],
            client_id="kafka-clients"
        )
        consumer = KafkaConsumer(bootstrap_servers=kafkaConfig["brokers"],
            security_protocol='SASL_PLAINTEXT',
            sasl_mechanism='GSSAPI',
            sasl_kerberos_domain_name=krb5Config["domain"],
            sasl_kerberos_service_name=krb5Config["kafkaServiceName"],
        )
    else:
        producer = KafkaProducer(bootstrap_servers=kafkaConfig["brokers"])
    t = consumer.topics()
    fastapi_logger.debug(t)
    producer.send(kafkaConfig["targetTopic"], data.msg.encode('utf-8'))
    producer.flush()
    fastapi_logger.debug(f"send message:{data.msg}")
    return {}