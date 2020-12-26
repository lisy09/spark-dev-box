from fastapi import APIRouter,status
from fastapi.logger import logger as fastapi_logger

import logging

router = APIRouter(
    prefix="/healthcheck",
    tags=["healthcheck"],
)

default_response = {
    "healthcheck":"ok"
}

@router.get("",status_code=status.HTTP_200_OK)
async def read_healthcheck():
    """
    Health check.
    """
    fastapi_logger.debug("health check called")
    return default_response
