# :: Header
  FROM alpine:latest
  ENV COTURN="4.5.2-r3"

# :: Run
  USER root

  # :: prepare
    RUN set -ex; \
      mkdir -p \
        /coturn/etc \
        /coturn/ssl \
        /coturn/run \
        /coturn/var

    RUN set -ex; \
      addgroup --gid 1000 coturn; \
      adduser --uid 1000 -H -D -G coturn -h /coturn coturn

  # :: install
    RUN set -ex; \
      apk --update --no-cache add \
        coturn=${COTURN}

  # :: copy root filesystem changes
    COPY ./rootfs /

  # :: docker -u 1000:1000 (no root initiative)
    RUN  set -ex; \
      chown -R coturn:coturn \
        /coturn \
        /var/lib/coturn

# :: Volumes
  VOLUME ["/coturn/etc"]


# :: Monitor
  RUN set -ex; apk --update --no-cache add curl
  RUN chmod +x /usr/local/bin/healthcheck.sh
  HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1


# :: Start
  RUN chmod +x /usr/local/bin/entrypoint.sh
  USER coturn
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]