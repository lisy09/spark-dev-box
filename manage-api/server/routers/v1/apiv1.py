from fastapi import APIRouter

from .endpoints import stream

router = APIRouter(prefix="/v1")
router.include_router(stream.router)