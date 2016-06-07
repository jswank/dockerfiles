FROM alpine:edge

ENV EASYRSA=/usr/share/easy-rsa
ENV EASYRSA_PKI=/easyrsa/pki

# Base Dependencies
RUN apk --update add easy-rsa \
    && rm -rf /var/cache/apk/*

VOLUME /easyrsa

ENTRYPOINT ["/usr/share/easy-rsa/easyrsa"]
