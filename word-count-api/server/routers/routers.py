from fastapi import APIRouter

from .v1 import apiv1
from . import healthcheck

router = APIRouter()
router.include_router(apiv1.router)
router.include_router(healthcheck.router)