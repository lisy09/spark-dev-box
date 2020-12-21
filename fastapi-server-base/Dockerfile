FROM python:3.9-slim

RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
   && rm -rf /tmp/pip-tmp

COPY server/ /workspace/server/
COPY conf/ /workspace/conf/

WORKDIR /workspace
CMD ["python","-m","server.main"]