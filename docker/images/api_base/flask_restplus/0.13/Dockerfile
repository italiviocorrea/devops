FROM icorrea/miniconda3:latest-alpine3.10

RUN conda config --add channels conda-forge && \
    conda install -y uwsgi

COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt


