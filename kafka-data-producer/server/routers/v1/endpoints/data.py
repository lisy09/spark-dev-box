from fastapi import APIRouter,status, Request
from fastapi.logger import logger as fastapi_logger
from server.core.config import get_config
from kafka import KafkaProducer
from pydantic import BaseModel

import logging

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
    producer = KafkaProducer(bootstrap_servers=kafkaConfig["brokers"])
    producer.send(kafkaConfig["targetTopic"], data.msg.encode('utf-8'))
    producer.flush()
    fastapi_logger.debug(f"send message:{data.msg}")
    return {}
