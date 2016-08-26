FROM alpine:latest

COPY config.yml /etc/tailon/config.yml
RUN apk add --no-cache python py-pip grep gawk && \
    pip install tailon && \
    ln -sf /usr/bin/grep /bin/grep

EXPOSE 8080

VOLUME /logs

ENTRYPOINT ["/usr/bin/tailon", "-c", "/etc/tailon/config.yml"]
