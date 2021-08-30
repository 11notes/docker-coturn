# :: Header
    FROM alpine:3.14
    ENV COTURN_VERSION="4.5.2-r0"

# :: Run
    USER root

    # :: prepare
        RUN mkdir -p \
                /coturn/etc \
                /coturn/ssl \
                /coturn/run \
                /coturn/var

        RUN addgroup --gid 1000 coturn \
            && adduser --uid 1000 -H -D -G coturn -h /coturn coturn

    # :: install
        RUN apk --update --no-cache add \
                coturn=${COTURN_VERSION}

    # :: copy root filesystem changes
        COPY ./rootfs /

    # :: docker -u 1000:1000 (no root initiative)
        RUN  chown -R coturn:coturn \
                /coturn \
                /var/lib/coturn

# :: Volumes
    VOLUME ["/coturn/etc"]


# :: Monitor
    RUN apk --update --no-cache add curl
    RUN chmod +x /usr/local/bin/healthcheck.sh
    HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1


# :: Start
    RUN chmod +x /usr/local/bin/entrypoint.sh
    USER coturn
    ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
    CMD ["-c /coturn/etc/turnserver.conf", "--db=/coturn/var/sqlite.db", "--pidfile=/coturn/run/turnserver.pid", "--log-file=stdout", "--external-ip=$(curl -4 https://ifconfig.me 2>/dev/null)"]