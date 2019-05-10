FROM icorrea/python:3.6-alpine3.9

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

# Superset version
ARG SUPERSET_VERSION=0.29.0rc7

# Add superset_config.py folder to PYTHONPATH so superset could find it.
# Configure environment
ENV GUNICORN_BIND=0.0.0.0:8088 \
    GUNICORN_LIMIT_REQUEST_FIELD_SIZE=0 \
    GUNICORN_LIMIT_REQUEST_LINE=0 \
    GUNICORN_TIMEOUT=60 \
    GUNICORN_WORKERS=2 \
    PYTHONPATH=/etc/superset:/home/superset:$PYTHONPATH \
    SUPERSET_REPO=apache/incubator-superset \
    SUPERSET_VERSION=${SUPERSET_VERSION} \
    SUPERSET_HOME=/var/lib/superset
ENV GUNICORN_CMD_ARGS="--workers ${GUNICORN_WORKERS} --timeout ${GUNICORN_TIMEOUT} --bind ${GUNICORN_BIND} --limit-request-line ${GUNICORN_LIMIT_REQUEST_LINE} --limit-request-field_size ${GUNICORN_LIMIT_REQUEST_FIELD_SIZE}"


RUN adduser -S -H superset && \
    mkdir -p /etc/superset && chown -R superset /etc/superset && \
    mkdir -p /opt/superset && chown -R superset /opt/superset && \
    apk add --no-cache --virtual .meta-build-dependencies \
        cyrus-sasl-dev \
        g++ \
        gcc \
        libffi-dev \
        libressl-dev \
        musl-dev \
        mariadb-dev \
        postgresql-dev \
        python3-dev && \
    apk add --no-cache libpq mariadb-client-libs && \
    pip3 install --no-cache-dir --no-build-isolation \
        Flask==0.12.4 \
        SQLAlchemy-Utils==0.32.21 && \
    pip3 install --no-cache-dir --no-build-isolation \
        Werkzeug==0.14.1 \
        flask-cors==3.0.3 \
        flask-mail==0.9.1 \
        flask-oauth==0.12 \
        flask_oauthlib==0.9.3 \
        gevent==1.2.2 \
        impyla==0.14.0 \
        infi.clickhouse-orm==1.0.2 \
        psycopg2==2.7.4 \
        mysqlclient \
        pyathena==1.2.5 \
        pyhive==0.5.1 \
        pymssql==2.1.4 \
        redis==2.10.6 \
        sqlalchemy-clickhouse==0.1.5.post0 \
        sqlalchemy-redshift==0.7.1 \
        superset==${SUPERSET_VERSION} && \
    apk del .meta-build-dependencies && \
    find / -type d -name __pycache__ -exec rm -r {} + && \
    find /usr/local/lib/python3.6/site-packages -type d -name tests -exec rm -r {} + && \
    rm -rf \
        /root/.cache \
        /usr/share/terminfo \
        /var/cache

# configure filesystem
VOLUME /home/superset \
       /etc/superset \
       /var/lib/superset
WORKDIR /home/superset

# deploy application
EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
CMD ["gunicorn", "superset:app"]
USER superset
