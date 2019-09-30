FROM zobees/steamcmd

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
      netcat qstat && \
    rm -rf /var/lib/apt/lists/*

ENV STEAMCMD_APP_ID="294420" \
    CONFIG_FILE=serverconfig.xml \
    QUERY_PORT=26901

ADD 7dtd-* /usr/local/bin/
RUN chmod +x /usr/local/bin/7dtd-*
RUN chown -R 995:995 /data

HEALTHCHECK CMD [ "7dtd-status" ]

EXPOSE 26900/tcp 26900/udp 26901/udp 26902/udp 8080/tcp 8081/tcp
VOLUME /data

CMD ["steamcmd-wrapper", "7dtd-server"]
