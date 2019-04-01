FROM "ubuntu:bionic"

RUN apt-get update && yes | apt-get upgrade

RUN mkdir -p /tensorflow/models

RUN mkdir -p /object_detection_task

RUN apt-get install -y git python-pip

RUN pip install --upgrade pip

RUN pip install tensorflow

RUN apt-get install -y protobuf-compiler python-pil python-lxml

RUN pip install jupyter

RUN pip install matplotlib

RUN git clone https://github.com/tensorflow/models.git /tensorflow/models

RUN git clone https://github.com/datitran/raccoon_dataset.git /object_detection_task

WORKDIR /tensorflow/models/research

RUN protoc object_detection/protos/*.proto --python_out=.

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

RUN jupyter notebook --generate-config --allow-root

# Jupyter Notebook Password is "Root"

RUN echo "c.NotebookApp.password = u'sha1:772544bc5386:09e3284590d2c079a6e028e81c9e30bb8c9efc65'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
CMD ["jupyter", "notebook","--allow-root", "--notebook-dir=/tensorflow/models/research/object_detection", "--ip=0.0.0.0", "--port=8888", "--no-browser"]


