# build stage
FROM golang:1.9.4-alpine
RUN set -x && \
    apk -U add git && \
    go get -t -v github.com/jswank/http-echo-server && \
    CGO_ENABLED=0 go build -a -v github.com/jswank/http-echo-server 

# final stage
FROM alpine
WORKDIR /app
COPY --from=0 /go/bin/http-echo-server /app/http-echo-server
USER nobody
EXPOSE 7000
ENTRYPOINT /app/http-echo-server
