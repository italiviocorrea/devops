FROM icorrea/python:3.6.7-alpine3.8

# Superset version
ARG SUPERSET_VERSION=0.28.1

# Superset setup options
ENV SUP_ROW_LIMIT 5000
ENV SUP_WEBSERVER_THREADS 10
ENV SUP_WEBSERVER_PORT 8088
ENV SUP_WEBSERVER_TIMEOUT 120
ENV SUP_SECRET_KEY 'senha#123'
ENV SUP_META_DB_URI "sqlite:///${SUPERSET_HOME}/superset.db"

# admin auth details
ENV ADMIN_USERNAME admin
ENV ADMIN_FIRST_NAME admin
ENV ADMIN_LAST_NAME user
ENV ADMIN_EMAIL admin@nowhere.com
ENV ADMIN_PWD superset

# Add superset_config.py folder to PYTHONPATH so superset could find it.
ENV PYTHONPATH=/etc/superset:$PYTHONPATH \
    SUPERSET_HOME=/opt/superset \
    SUPERSET_VERSION=${SUPERSET_VERSION}

RUN adduser -S -H superset && \
    mkdir -p /etc/superset && chown -R superset /etc/superset && \
    mkdir -p /opt/superset && chown -R superset /opt/superset && \
    apk add --no-cache --virtual .meta-build-dependencies \
        cyrus-sasl-dev \
        g++ \
        gcc \
        freetds \
        freetds-dev \
        unixodbc-dev \
        unixodbc \
        mariadb-dev \ 
        libffi-dev \
        libressl-dev \
        musl-dev \
        postgresql-dev \
        krb5-libs \
        krb5 \
        python3-dev && \
    apk add --no-cache libpq && \
    pip3 install --no-cache-dir --no-build-isolation \
        Flask==0.12.4 \
        SQLAlchemy-Utils==0.32.21 && \
    pip3 install --no-cache-dir --no-build-isolation \
        gevent==1.2.2 \
        psycopg2==2.7.4 \
        Cython \
        pymssql \
        mysqlclient==1.3.13 \
        redis==2.10.6 \
        pyhive==0.5.1 \
        impala==0.2 \
        thrift_sasl==0.2.1 \
        sasl \
        superset==${SUPERSET_VERSION} && \
    apk del .meta-build-dependencies && \
    find / -type d -name __pycache__ -exec rm -r {} + && \
    find /usr/local/lib/python3.6/site-packages -type d -name tests -exec rm -r {} + && \
    rm -rf \
        /root/.cache \
        /usr/share/terminfo \
        /var/cache

EXPOSE 8088
CMD ["gunicorn", "--workers=10", "--worker-class=gevent", "--timeout=120", "--bind=0.0.0.0:8088", "--limit-request-line=0", "--limit-request-field_size=0", "superset:app"]
USER superset
