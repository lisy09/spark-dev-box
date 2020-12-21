#!/usr/bin/env python

import requests

url = 'http://kafka-data-producer:8000/v1/data/kafka'
lines = open('/workspace/data/wordcount_data.txt').read().split("\n")
for line in lines:
    response = requests.post(url, json={"msg":line}, 
        # headers={"Content-Type": "text/plain"}
    )