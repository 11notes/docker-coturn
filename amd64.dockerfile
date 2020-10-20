# :: Header
    FROM alpine:3.12

# :: Run
    USER root

    RUN apk --update --no-cache add \
            coturn \
            curl \
        && addgroup --gid 1000 coturn \
        && adduser --uid 1000 -H -D -G coturn -h /coturn coturn \
        && install -d -o coturn -g coturn /coturn \
        && mkdir -p \
            /coturn/etc \
            /coturn/ssl

    COPY src /

    # :: docker -u 1000:1000 (no root initiative)
        RUN chown -R coturn:coturn \
            /coturn

    # :: docker start and health script
        RUN chmod +x \
            && /usr/local/bin/entrypoint.sh \
            && /usr/local/bin/healthcheck.sh \
            && /usr/local/bin/get-public-ip.sh

# :: Volumes
    VOLUME ["/coturn/etc"]

# :: Monitor
    HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
    USER coturn
    ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
    CMD ["--log-file=stdout", "--external-ip=$(get-public-ip)"]