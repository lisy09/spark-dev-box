from fastapi import APIRouter,status, Request, HTTPException
from fastapi.logger import logger as fastapi_logger
from server.core.config import get_config, get_global_request_timeout
from pydantic import BaseModel
from typing import Optional
import logging
import requests

router = APIRouter(
    prefix="/stream",
    tags=["stream"],
)

class CreateStreamAppReq(BaseModel):
    """
    Request body for POST /stream
    """
    sparkAppName: str = ""
    
    def verifySparkAppName(self) -> bool:
        return len(self.sparkAppName) > 0

class LivyBatch(BaseModel):
    id: int
    name: Optional[str] # pylint: disable=unsubscriptable-object
    appId: Optional[str] # pylint: disable=unsubscriptable-object
    # appInfo: dict
    log: list[str]
    state: str

def createLivyCommonHeaders():
    headers = {
        "Content-Type": "application/json",
        "X-Requested-By": "user"
    }
    return headers

@router.post("", response_model=LivyBatch)
async def create_stream_app(data:CreateStreamAppReq):
    """
    Create a streaming application through apache livy.
    """
    if not data.verifySparkAppName():
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail={
            "msg": "sparkAppName is invalid"
        })
    conf = get_config()
    livyConf = conf["livy"]
    url = livyConf["url"] + "/batches"
    headers = createLivyCommonHeaders()
    wordCountUpdateUrl = livyConf['wordCountUpdateUrl']
    json = {
        "file": livyConf["jarPath"],
        "className": livyConf["className"],
        "queue": livyConf["queue"],
        "numExecutors": livyConf["numExecutors"],
        "executorMemory": livyConf["executorMemory"],
        "executorCores": livyConf["executorCores"],
        "driverMemory": livyConf["driverMemory"],
        "args": [
            "--spark.app.name", data.sparkAppName,
            "--kafka.brokers", livyConf["kafka"]["brokers"],
            "--kafka.topics", livyConf["kafka"]["topics"],
            "--kafka.groupId", livyConf["kafka"]["groupId"],
            "--batch.duration.seconds", livyConf["duration"]["batch"],
            "--wordcount.update.url", wordCountUpdateUrl,
        ],
        "name": data.sparkAppName
    }
    livyResp = requests.post(url,
        json=json,
        headers=headers,
        timeout=get_global_request_timeout(),
    )
    livyRespJson = livyResp.json()
    if livyResp.status_code != status.HTTP_201_CREATED:
        raise HTTPException(
            status_code=livyResp.status_code,
            detail=livyRespJson
        )
    resp = LivyBatch.parse_obj(livyRespJson)
    fastapi_logger.debug(resp)
    return resp

class LivyGetBatchResp(BaseModel):
    start: int
    total: int
    sessions: list[LivyBatch]

@router.get("", response_model=LivyGetBatchResp)
async def get_stream_apps(
    start: Optional[int] = 0, # pylint: disable=unsubscriptable-object
    size: Optional[int] = 10, # pylint: disable=unsubscriptable-object
):
    """
    Get all streaming applications.
    start: Start index of the applications
    size: Number of sessions to fetch
    """
    conf = get_config()
    livyConf = conf["livy"]
    url = livyConf["url"] + "/batches"
    parameters = {
        "from": start,
        "size": size,
    }
    headers = createLivyCommonHeaders()
    livyResp = requests.get(url,
        params=parameters,
        headers=headers,
        timeout=get_global_request_timeout(),
    )
    livyRespJson = livyResp.json()
    if livyResp.status_code != status.HTTP_200_OK:
        raise HTTPException(
            status_code=livyResp.status_code,
            detail=livyRespJson
        )
    livyRespJson["start"] = livyRespJson["from"]
    resp = LivyGetBatchResp.parse_obj(livyRespJson)
    fastapi_logger.debug(resp)
    return resp

@router.get("/{id}", response_model=LivyBatch)
async def get_stream_app(id:int):
    """
    Get detail for a streaming application with {id}
    """
    conf = get_config()
    livyConf = conf["livy"]
    url = livyConf["url"] + f"/batches/{id}"
    headers = createLivyCommonHeaders()
    livyResp = requests.get(url,
        headers=headers,
        timeout=get_global_request_timeout(),
    )
    livyRespJson = livyResp.json()
    if livyResp.status_code != status.HTTP_200_OK:
        raise HTTPException(
            status_code=livyResp.status_code,
            detail=livyRespJson
        )
    resp = LivyBatch.parse_obj(livyRespJson)
    fastapi_logger.debug(resp)
    return resp
    
@router.delete("/{id}")
async def delete_stream_app(id:int):
    """
    Delete a streaming application with {id}
    """
    conf = get_config()
    livyConf = conf["livy"]
    url = livyConf["url"] + f"/batches/{id}"
    headers = createLivyCommonHeaders()
    livyResp = requests.delete(url,
        headers=headers,
        timeout=get_global_request_timeout(),
    )
    livyRespJson = livyResp.json()
    if livyResp.status_code != status.HTTP_200_OK:
        raise HTTPException(
            status_code=livyResp.status_code,
            detail=livyRespJson
        )
    resp = livyRespJson
    fastapi_logger.debug(resp)
    return resp