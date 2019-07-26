FROM debian:stretch

MAINTAINER Sagnik Sasmal, <sagnik@zadeservers.net>

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get -y install dirmngr curl software-properties-common locales git cmake \
    && adduser -D -h /home/container container

    # Ensure UTF-8
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # Python3.7
RUN python3.7 python3-pip libffi-dev mono-complete \
    && pip3 install aiohttp websockets pynacl opuslib libopus0 \
    && python3 -m pip install -U discord.py[voice]

USER container
ENV  USER=container HOME=/home/container


WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
