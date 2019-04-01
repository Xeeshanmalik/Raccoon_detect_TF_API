#!/bin/bash
cd "$(dirname "$0")"
docker build -t tensorflow .
if [ $? -eq 0 ]; then
	echo Docker Image Successfully Created
else
	echo Docker Image Creation Fail
fi
docker build -t tensorflow .
if [ $? -eq 0 ]; then
	echo Docker Container Successfully Created from Docker Image
else
	echo Docker Container Fail to Create
fi
docker run --name tensorflow -p 8888:8888 -d tensorflow

docker cp preprocessing tensorflow:/tensorflow/models/research/object_detection
docker cp raccoon_detection.ipynb tensorflow:/tensorflow/models/research/object_detection

python -mwebbrowser http://localhost:8888/notebooks/raccoon_detection.ipynb
