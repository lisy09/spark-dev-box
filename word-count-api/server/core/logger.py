import logging
import sys

from fastapi.logger import logger as fastapi_logger
from gunicorn.glogging import Logger
from loguru import logger as loguru_logger

from .config import get_log_level_config, get_log_all_modules

class InterceptHandler(logging.Handler):
    def emit(self, record):
        # Get corresponding Loguru level if it exists
        try:
            level = loguru_logger.level(record.levelname).name
        except ValueError:
            level = record.levelno

        # Find caller from where originated the logged message
        frame, depth = logging.currentframe(), 2
        while frame.f_code.co_filename == logging.__file__:
            frame = frame.f_back
            depth += 1

        loguru_logger.opt(depth=depth, exception=record.exc_info).log(level, record.getMessage())

class StubbedGunicornLogger(Logger):
    def setup(self, cfg):
        handler = logging.NullHandler()
        self.error_logger = logging.getLogger("gunicorn.error")
        self.error_logger.addHandler(handler)
        self.access_logger = logging.getLogger("gunicorn.access")
        self.access_logger.addHandler(handler)
        logLevel = get_log_level_config()
        self.error_logger.setLevel(logLevel)
        self.access_logger.setLevel(logLevel)
        fastapi_logger.setLevel(logLevel)

def setup_logger():
    intercept_handler = InterceptHandler()
    if get_log_all_modules():
        logging.root.setLevel(get_log_level_config())

    seen = set()
    for name in [
        *logging.root.manager.loggerDict.keys(),
        "gunicorn",
        "gunicorn.access",
        "gunicorn.error",
        "uvicorn",
        "uvicorn.access",
        "uvicorn.error",
    ]:
        if name not in seen:
            seen.add(name.split(".")[0])
            logging.getLogger(name).handlers = [intercept_handler]
    fastapi_logger.handlers = [intercept_handler]
    
    loguru_logger.configure(handlers=[{"sink": sys.stdout}])