from functools import lru_cache
import yaml
from multiprocessing import cpu_count

@lru_cache()
def get_config():
    with open("/workspace/conf/app.yaml",'r') as stream:
        config = yaml.safe_load(stream)
    return config

def get_log_level_config():
    return get_config()["logLevel"]

@lru_cache()
def get_kerberos_config():
    config = get_config()
    if ("kerberos" in config and 
        "enable" in config["kerberos"] and
        config["kerberos"]["enable"]):
        return config["kerberos"] 
    return None

@lru_cache()
def get_use_kerberos_config() -> bool:
    return get_kerberos_config() != None

def get_gunicorn_config(logger_class):
    config = get_config()
    gunicorn_conf = config["gunicorn"]

    workers = 1
    if "workers" in gunicorn_conf:
        workers = int(gunicorn_conf["workers"])
        assert workers > 0
    else:
        cores = cpu_count()
        worker_per_core = float(gunicorn_conf["worker_per_core"])
        workers = max(int(cores * worker_per_core), 2)
        if "max_workers" in gunicorn_conf:
            workers = min(workers, int(gunicorn_conf["max_workers"]))
            
    return {
        'bind': config["bind"],
        'workers': workers,
        'accesslog': gunicorn_conf["log"]["access"],
        'errorlog':gunicorn_conf["log"]["error"],
        'worker_class':'uvicorn.workers.UvicornWorker',
        'logger_class':logger_class,
        'grateful_timeout': int(gunicorn_conf['grateful_timeout']),
        'timeout': int(gunicorn_conf['timeout']),
        'keepalive': int(gunicorn_conf['keepalive']),
    }