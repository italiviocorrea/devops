FROM icorrea/spark:2.4.3-alpine3.9

# Install o pyspark
RUN conda install pyspark --quiet --yes

EXPOSE 8888

# ENTRYPOINT [ "/usr/bin/tini", "--" ]
# ENTRYPOINT ["pyspark","--master","spark://master:7077"]
