---
title: "Third Coast Pygrapher"
description: "A simple Third Coast Telemetry client written in Python"
date: 2017-10-18T10:04:47-04:00
categories:
  - "project"
tags:
  - "python"
  - "thirdcoast"
  - "telemetry"
  - "frc"
draft: false
weight: 0
---
One of the benefits of using open data formats such as JSON and HTTP/REST is the ease with which we can develop client applications for Third Coast Telemetry. This is a simple demonstration client written in Python.

This is a sample of output when run with `./pygrapher 1 SETPOINT`

{{<figure src="/media/talon-1-setpoint.png" title="Pygrapher screen shot">}}

## Source Code
```python
#!/usr/bin/env python

# usage: pygrapher <id> <measurement>
# example: pygrapher 0 SETPOINT

import sys
import requests
import socket
import json
import matplotlib.pyplot as plt

id = int(sys.argv[1]) # CAN address
measure_id = sys.argv[2] # measurement id from inventory

# server endpoints
SERVER = 'http://localhost:5800'
SUB_ENDPOINT = SERVER + '/v1/grapher/subscription'

# send subscription to start UDP streaming, retrieve description from response
payload = {'type':'start', 'subscription': [{'itemId':id, 'measurementId':measure_id}]}
r = requests.post(SUB_ENDPOINT, data=json.dumps(payload))
description = json.loads(r.text)['descriptions'][0]

# listen on UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', 5555))

ts = [] # each data point elapsed time in milliseconds, x-axis
data = [] # the data points, y-value

# keep track of elapsed milliseconds
first = True
start = 0

# grab first 100 data points from UDP stream
for i in range(0, 100):
    packet = sock.recvfrom(2048)
    j = json.loads(packet[0].decode(encoding='UTF-8'))
    if i == 0:
        First = False
        start = j['timestamp']
    ts.append(j['timestamp'] - start)
    data.append(j['data'])

# stop UDP stream
requests.delete(SUB_ENDPOINT)

# plot the data
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.set_title(description)
ax.set_xlabel('elapsed milliseconds')
plt.plot(ts, data)
plt.grid()
plt.show()
```
