FROM       alpine
MAINTAINER Jason Swank <docker@scalene.net>

ENV NEXUS_DATA /nexus-data

ENV NEXUS_VERSION 3.0.0-b2015110601

ENV JAVA_HOME /opt/java
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 60
ENV JAVA_VERSION_BUILD 27

# Install basics
RUN apk --update add curl ca-certificates tar \
  && cd /var/tmp \
  && curl --fail --silent --location --retry 3 --remote-name \
  https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk \
  && apk add --allow-untrusted ./glibc-2.21-r2.apk \
  && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf 

# Download and install JRE
RUN mkdir /opt \
  && cd /var/tmp \
  && curl --fail --silent --location --retry 3 \
  --header "Cookie: oraclelicense=accept-securebackup-cookie; " \
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/server-jre-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  | gunzip \ 
  | tar -x -C /opt \
  && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME}

RUN mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --location --retry 3 \
    https://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C /tmp nexus-${NEXUS_VERSION} \
  && mv /tmp/nexus-${NEXUS_VERSION}/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-${NEXUS_VERSION}

RUN adduser -S -u 200 -g "nexus role account" -h ${NEXUS_DATA} -s /bin/false nexus

## configure nexus runtime env
RUN sed -e "s|KARAF_HOME}/instances|KARAF_DATA}/instances|" -i /opt/sonatype/nexus/bin/nexus

VOLUME ${NEXUS_DATA}

EXPOSE 8081
USER nexus
WORKDIR /opt/sonatype/nexus

ENV KARAF_BASE /opt/sonatype/nexus
ENV KARAF_DATA ${NEXUS_DATA}
ENV KARAF_ETC ${KARAF_BASE}/etc
ENV KARAF_HOME ${KARAF_BASE}
ENV MAX_MEM 768m
ENV MIN_MEM 256m

CMD bin/nexus start
