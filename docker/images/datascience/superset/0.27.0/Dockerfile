FROM icorrea/debian:stretch-slim

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

# Superset version
ARG SUPERSET_VERSION=0.27.0

ENV SUP_ROW_LIMIT=5000 \
    SUP_WEBSERVER_THREADS=2 \
    SUP_WEBSERVER_PORT=8088 \
    SUP_WEBSERVER_TIMEOUT=60 \
    SUP_SECRET_KEY="senha#123" \
    SUP_META_DB_URI="mysql://superset:superset@mysql:3306/superset" \
    SUP_CSRF_ENABLED="False"
    
# Configure environment
ENV GUNICORN_BIND=0.0.0.0:8088 \
    GUNICORN_LIMIT_REQUEST_FIELD_SIZE=0 \
    GUNICORN_LIMIT_REQUEST_LINE=0 \
    GUNICORN_TIMEOUT=60 \
    GUNICORN_WORKERS=2 \
    LANG=pt_BR.UTF-8 \
    LC_ALL=pt_BR.UTF-8 \
    PYTHONPATH=/etc/superset:/home/superset:$PYTHONPATH \
    SUPERSET_REPO=apache/incubator-superset \
    SUPERSET_VERSION=${SUPERSET_VERSION} \
    SUPERSET_HOME=/var/lib/superset \
    ADMIN_USERNAME=admin \
    ADMIN_FIRST_NAME=admin \
    ADMIN_LAST_NAME=user \
    ADMIN_EMAIL=devops@fazenda.ms.gov.br \
    ADMIN_PWD=superset


ENV GUNICORN_CMD_ARGS="--workers ${SUP_WEBSERVER_THREADS} --timeout ${GUNICORN_TIMEOUT} --bind ${GUNICORN_BIND} --limit-request-line ${GUNICORN_LIMIT_REQUEST_LINE} --limit-request-field_size ${GUNICORN_LIMIT_REQUEST_FIELD_SIZE}"

# Create superset user & install dependencies
RUN useradd -U -m superset && \
    mkdir /etc/superset  && \
    mkdir ${SUPERSET_HOME} && \
    chown -R superset:superset /etc/superset && \
    chown -R superset:superset ${SUPERSET_HOME} && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        default-libmysqlclient-dev \
        freetds-dev \
        freetds-bin \
        libffi-dev \
        libldap2-dev \
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        python3-dev \
        python3-pip && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/* && \
    curl https://raw.githubusercontent.com/${SUPERSET_REPO}/${SUPERSET_VERSION}/requirements.txt -o requirements.txt && \
    pip3 install --no-cache-dir -r requirements.txt && \
    pip3 install --no-cache-dir \
        flask-appbuilder \
        Werkzeug==0.12.1 \
        flask-cors==3.0.3 \
        flask-mail==0.9.1 \
        flask-oauth==0.12 \
        flask_oauthlib==0.9.3 \
        gevent==1.2.2 \
        impyla==0.14.0 \
        infi.clickhouse-orm==1.0.2 \
        mysqlclient==1.3.7 \
        psycopg2==2.6.1 \
        pyathena==1.2.5 \
        pyhive==0.5.1 \
        pyldap==2.4.28 \
        pymssql==2.1.3 \
        redis==2.10.5 \
        sqlalchemy-clickhouse==0.1.5.post0 \
        sqlalchemy-redshift==0.5.0 \
        superset==${SUPERSET_VERSION} && \
    rm requirements.txt

# Configure Filesystem
COPY superset /usr/local/bin

COPY superset-init.sh /superset-init.sh
RUN chmod +x /superset-init.sh
RUN chown -R superset:superset /usr/local/lib/python3.5/dist-packages/superset

VOLUME /home/superset \
       /etc/superset \
       /var/lib/superset
WORKDIR /home/superset

# Deploy application
EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
#CMD ["gunicorn", "superset:app"]
CMD ["/superset-init.sh"]
USER superset

