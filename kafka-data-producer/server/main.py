from fastapi import FastAPI
import logging
import os

from .routers import routers
from .core.config import get_config, get_gunicorn_config, get_kerberos_config, get_use_kerberos_config
from .core.logger import setup_logger, StubbedGunicornLogger

import gunicorn.app.base

def createSimpleFastapi():
    app = FastAPI()
    app.include_router(routers.router)
    return app

def createFastapi(conf):
    app = createSimpleFastapi()
    app.state.config = conf
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

def initKerberos():
    krb5Conf = get_kerberos_config()
    cmd = f"kinit -fV -k -t {krb5Conf['keytab']} {krb5Conf['principal']}"
    print(cmd)
    return os.system(cmd)

if __name__ == "__main__":
    conf = get_config()
    setup_logger()
    if get_use_kerberos_config():
        success = initKerberos()
        print("initKerberos:", success)
        if success != 0:
            print("exit for failing to init kerberos...")
            exit(1)

    app = createFastapi(conf)

    gunicorn_options = get_gunicorn_config(StubbedGunicornLogger)
    GunicornApplication(app, gunicorn_options).run()