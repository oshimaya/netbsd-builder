#
# NetBSD builder : For building NetBSD distribution on Docker environment
# 
# Base system: Debiani GNU/Linux
FROM debian:jessie

MAINTAINER oshima-ya@yagoto-urayama.jp

RUN apt-get update -y  && \
    apt-get install wget build-essential zlib1g-dev flex -y 
RUN mkdir -p /release /work /source && \
    useradd netbsd && \
    chown -R netbsd /release /work /source

VOLUME /release
VOLUME /source

COPY entry.sh /opt/bin/
ENTRYPOINT ["/opt/bin/entry.sh"]
USER netbsd
