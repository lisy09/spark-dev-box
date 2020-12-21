from fastapi import APIRouter, Depends
from fastapi.logger import logger as fastapi_logger
from fastapi_plugins import depends_redis
from aioredis import Redis
from pydantic import BaseModel

router = APIRouter(
    prefix="/wordcount",
    tags=["wordcount"]
)

WORD_COUNT_KEY = "wordcount"

@router.get("")
async def read_word_count(
    redis:Redis=Depends(depends_redis)
):
    wordcount = await redis.hgetall(WORD_COUNT_KEY)
    fastapi_logger.debug(wordcount)
    return wordcount

@router.delete("")
async def reset_word_count(
    redis:Redis=Depends(depends_redis)
):
    result = await redis.delete(WORD_COUNT_KEY)
    resp = {"result":result}
    fastapi_logger.debug(resp)
    return resp

class AddWordCountReq(BaseModel):
    wordcount:dict[str,int] = {}

@router.post("")
async def add_word_count(
    wordCountDict:AddWordCountReq,
    redis:Redis=Depends(depends_redis)
):
    pipe = redis.pipeline()
    for key,count in wordCountDict.wordcount.items():
        pipe.hincrby(WORD_COUNT_KEY, key, count)
    result = await pipe.execute()
    resp = {"result":result}
    fastapi_logger.debug(resp)
    return resp