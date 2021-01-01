FROM python:3.9-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get install -yqq --no-install-recommends \
    build-essential \
    krb5-user libpam-krb5 libkrb5-dev \
    && apt-get -yqq clean
    
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
   && rm -rf /tmp/pip-tmp

COPY server /workspace/server
COPY conf /workspace/conf
WORKDIR /workspace
CMD ["python","-m","server.main"]