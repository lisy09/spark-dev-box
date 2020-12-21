from fastapi import APIRouter

from .endpoints import data

router = APIRouter(prefix="/v1")
router.include_router(data.router)