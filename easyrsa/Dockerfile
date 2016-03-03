FROM alpine:edge

ENV EASYRSA=/usr/share/easy-rsa
ENV EASYRSA_PKI=/easyrsa/pki

# Base Dependencies
RUN apk --update add easy-rsa \
    && rm -rf /var/cache/apk/*

#RUN cd /tmp \
#    && apk --update --virtual=build-deps add curl ca-certificates tar \
#    && mkdir /easyrsa \
#    && curl -f -s -L -O https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz \
#    && tar -xz -f EasyRSA-3.0.1.tgz -C /easyrsa --strip-components 1 \
#    && chown -R nobody /easyrsa \
#    && mv /easyrsa/easyrsa /usr/local/bin/easyrsa \
#    && rm -rf EasyRSA-3.0.1.tgz \
#    && apk del build-deps \
#    && rm -rf /var/cache/apk/*

VOLUME /easyrsa

ENTRYPOINT ["/usr/share/easy-rsa/easyrsa"]
