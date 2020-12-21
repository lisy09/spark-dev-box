from fastapi import FastAPI
from fastapi_plugins import redis_plugin, RedisSettings
import logging

from .routers import routers
from .core.config import get_config, get_gunicorn_config
from .core.logger import setup_logger, StubbedGunicornLogger

import gunicorn.app.base

def createSimpleFastapi():
    app = FastAPI()
    app.include_router(routers.router)
    return app

def createFastapi(conf):
    app = createSimpleFastapi()
    app.state.config = conf

    @app.on_event('startup')
    async def on_startup() -> None:
        redisConf = RedisSettings()
        redisConf.redis_host = conf["redis"]["host"]
        redisConf.redis_port = int(conf["redis"]["port"])
        await redis_plugin.init_app(app, config=redisConf)
        await redis_plugin.init()
    @app.on_event('shutdown')
    async def on_shutdown() -> None:
        await redis_plugin.terminate()
    return app

class GunicornApplication(gunicorn.app.base.BaseApplication):
    def __init__(self, app, options=None):
        self.options = options or {}
        self.application = app
        super().__init__()

    def load_config(self):
        config = {key: value for key, value in self.options.items()
                  if key in self.cfg.settings and value is not None}
        for key, value in config.items():
            self.cfg.set(key.lower(), value)

    def load(self):
        return self.application

if __name__ == "__main__":
    conf = get_config()
    setup_logger()
    app = createFastapi(conf)

    gunicorn_options = get_gunicorn_config(StubbedGunicornLogger)
    GunicornApplication(app, gunicorn_options).run()