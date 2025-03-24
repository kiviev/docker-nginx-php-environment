ARG VERSION=1.27.4
ARG UID=1000
ARG TARGET=web

#################################################################

FROM nginx:${VERSION}
ARG VERSION=1.27.4
ARG UID=1000
ARG TARGET=web

RUN adduser -u ${UID} --disabled-password --gecos "" appuser
RUN apt-get update && apt-get install -y nano procps
#RUN echo 'if [ "$(id -u)" = "0" ] && [ -n "$PS1" ]; then exec su - appuser; fi' >> /root/.bashrc


COPY nginx.conf /etc/nginx/
COPY sites/${TARGET}.conf.template /etc/nginx/templates/default.conf.template

ENV NGINX_VERSION=${VERSION}
ENV SERVER_ALIAS=ms
ENV TZ=Europe/Madrid

EXPOSE 80
