from fastapi import APIRouter

from .endpoints import wordcount 

router = APIRouter(prefix="/v1")
router.include_router(wordcount.router)