FROM icorrea/postgresql:9.6-alpine3.10

COPY dbappmodeler_init.backup /docker-entrypoint-initdb.d/dbappmodeler.backup
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh




