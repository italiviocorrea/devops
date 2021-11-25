FROM mcr.microsoft.com/mssql/server:2019-latest
ENV RUN_USER 500
ENV RUN_GROUP 0
ENV ACCEPT_EULA Y
ENV SA_PASSWORD senha123
RUN chown -R ${RUN_USER}:${RUN_GROUP} /var/opt/mssql && \
chmod -R 770 /var/opt/mssql
ADD scripts /scripts # This adds the new entrypoint, listed below
RUN dpkg -i /scripts/libnss-wrapper_1.1.2-1_amd64.deb
USER ${RUN_USER}:${RUN_GROUP}
ENTRYPOINT ["/scripts/entrypoint"]

