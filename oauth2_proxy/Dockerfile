FROM alpine:latest

ENV OAUTH2_PROXY_VERSION=2.1
ENV GOLANG_VERSION=1.6

# Base Dependencies
RUN apk --no-cache --update --virtual build-deps add curl tar \
  && curl -L -k -f -s \
  https://github.com/bitly/oauth2_proxy/releases/download/v${OAUTH2_PROXY_VERSION}/oauth2_proxy-2.1.linux-amd64.go${GOLANG_VERSION}.tar.gz \
  | tar xz --strip-components 1 -C /usr/local/bin/ \
  && mkdir /etc/oauth2_proxy \
  && apk del --virtual build-deps

ADD oauth2_proxy.cfg /etc/oauth2_proxy/config

USER nobody
EXPOSE 4180
ENTRYPOINT ["/usr/local/bin/oauth2_proxy", "-config", "/etc/oauth2_proxy/config"]
