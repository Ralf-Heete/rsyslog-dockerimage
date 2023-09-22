FROM alpine:latest

ARG SYSLOG_UID=103
ARG DOCKER_GID=997

RUN apk add --no-cache rsyslog tzdata bash
RUN sed -i '/module(load="imklog")/s/^/#/' /etc/rsyslog.conf &&\
    echo "input(type=\"imuxsock\" Socket=\"/run/rsyslog/socket\")"  >> /etc/rsyslog.conf

RUN mkdir -p /opt/rsyslog/scripts
COPY ./scripts/* /opt/rsyslog/scripts/
COPY ./etc/* /etc

# Erstellen Sie /dev/log und ändern Sie die Berechtigungen dafür
#RUN touch /dev/log && \
#    chown ${SYSLOG_UID}:${DOCKER_GID} /dev/log
#RUN chown ${SYSLOG_UID}:${DOCKER_GID} /dev


CMD ["rsyslogd", "-n"]

